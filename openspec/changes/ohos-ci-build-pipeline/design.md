## Context

uv 项目已完成 OHOS aarch64 平台的代码适配（jemalloc 禁用、musl 版本检测、解释器执行方式、平台标识识别等），并在本地和 OHOS 设备上通过手动构建验证了可行性。当前 `.cargo/config.toml` 已配置 OHOS 设备端原生编译工具链，`aarch64-unknown-linux-ohos` target 可用。

参考 `springmin/bun` 的 OHOS Rust Build 流水线（在自托管 ARM64 Runner 上使用 OHOS SDK + LLVM + ninja 交叉编译 Bun），我们需要为 uv 设计一个类似的 GitHub Actions 流水线，但 uv 的构建系统更简单（纯 cargo，无 WebKit/C++ 依赖）。

约束条件：
- Runner 为自托管 ARM64 Linux 机器，需预装 OHOS SDK、Rust 工具链、cmake、ninja
- `aws-lc-rs` 依赖需要 cmake + ninja 编译 C 代码
- 构建时间目标：< 30 分钟（增量编译），< 60 分钟（全量编译）
- Runner 内存有限（约 8-16GB），需控制并行度

## Goals / Non-Goals

**Goals:**
- 每次推送到 `ohos-aarch64` 分支时自动构建 OHOS aarch64 二进制
- 支持手动触发（`workflow_dispatch`）用于按需构建
- 构建产物通过 ELF 格式和动态依赖验证
- 产物上传到 GitHub Actions Artifacts，保留 30 天
- 通过多级缓存最小化增量构建时间
- 可选：将产物复制到共享目录供 OHOS 设备测试

**Non-Goals:**
- 不在 GitHub 官方 Runner 上构建（需要 OHOS SDK，体积大且有许可证限制）
- 不自动发布到 Release/Gitea 等（初期仅 Artifacts）
- 不在 CI 中运行 OHOS 设备上的功能测试（由独立的设备端测试脚本覆盖）
- 不构建其他 OHOS 架构（仅 aarch64）
- 不处理 Windows/macOS 平台的 OHOS 交叉编译

## Decisions

### Decision 1: 单 Job 流水线（非多 Job）

**选择**: 单个 `build` Job，包含从源码检出到产物上传的所有步骤

**理由**: uv 的构建是单一 cargo build 命令，不像 Bun 需要先编译 WebKit 再链接。拆分为多 Job 会引入 artifact 传递开销，且无并行收益。

**替代方案**: 分离 `configure` / `build` / `verify` 三个 Job —— 对 uv 来说过度工程。

### Decision 2: 缓存策略 — 本地目录 + actions/cache 双保险

**选择**:
1. **Cargo registry 缓存**: 从 Runner 本地持久目录 `cp -a` 到 workspace，避免每次重新下载 crates
2. **Rust 增量编译产物**: 通过 `CARGO_TARGET_DIR` 指向 Runner 本地持久路径，编译产物跨 run 保留
3. **actions/cache**: 用 `actions/cache@v4` 缓存 `target/` 目录作为 fallback

**理由**: 自托管 Runner 的本地磁盘比 actions/cache 的上传/下载快 10 倍以上。actions/cache 作为 Runner 重建后的 fallback。

**替代方案**: 纯 actions/cache —— 上传/下载 target 目录（可能 2GB+）耗时过长。

### Decision 3: 构建命令 — cargo build with --no-default-features

**选择**: `cargo build --release --target aarch64-unknown-linux-ohos -p uv --no-default-features --features "test-defaults"`

**理由**: 与现有 `build_ohos.sh` 脚本一致，已验证可编译。禁用默认 features 可避免不兼容 OHOS 的依赖被拉入。

### Decision 4: 产物验证 — file + readelf

**选择**:
1. `file` 命令确认 `ELF 64-bit LSB ... ARM aarch64`
2. `readelf -d` 检查 NEEDED 仅包含 `libc.so`（OHOS musl 动态库）
3. `ls -lh` 记录产物大小

**理由**: 与 Bun 流水线验证策略一致。uv 不依赖 libc++（纯 Rust + musl），所以 NEEDED 应该只有 `libc.so`。如果 aws-lc-rs 静态链接了 libcrypto，则不应出现在 NEEDED 中。

### Decision 5: 触发条件 — push + workflow_dispatch

**选择**:
- `push` 到 `ohos-aarch64` 和 `claude/ohos-*` 分支
- `workflow_dispatch` 手动触发，支持可选 `cargo_features` 输入

**理由**: push 触发确保每次提交都验证编译；手动触发支持按需构建和调试。

### Decision 6: 并发控制 — concurrency group

**选择**: `concurrency: { group: ohos-build-${{ github.ref }}, cancel-in-progress: true }`

**理由**: 同一分支的新提交应取消旧的构建，节省 Runner 资源。

## Risks / Trade-offs

| 风险 | 缓解措施 |
|---|---|
| Runner 宕机或不可用 | workflow 超时设为 300 分钟；Runner 健康检查通过 self-hosted runner 监控 |
| OHOS SDK 版本更新导致编译失败 | SDK 路径通过 env 变量集中管理，更新时只改一处 |
| aws-lc-rs cmake 构建失败 | 环境变量 `AWS_LC_SYS_CMAKE_AR` / `AWS_LC_SYS_CMAKE_RANLIB` 已在 `.cargo/config.toml` 中配置 |
| 增量编译产物损坏 | 本地缓存目录定期清理；全量构建通过 workflow_dispatch 手动触发 |
| crates.io 下载慢 | 已配置 USTC 镜像（`.cargo/config.toml`） |
| 内存不足导致 OOM | `CARGO_BUILD_JOBS` 限制为 2，避免并行编译消耗过多内存 |
