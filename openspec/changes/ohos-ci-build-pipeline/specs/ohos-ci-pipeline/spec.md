## ADDED Requirements

### Requirement: Workflow 触发条件

流水线 SHALL 在以下条件下触发：
- 当代码推送到 `ohos-aarch64` 或 `claude/ohos-*` 分支，且变更涉及 Rust 源码、Cargo 配置或 workflow 文件时
- 当通过 `workflow_dispatch` 手动触发时

#### Scenario: Push 到 ohos-aarch64 分支触发构建
- **WHEN** 开发者推送代码到 `ohos-aarch64` 分支，且变更文件匹配路径过滤器（`crates/**/*.rs`、`Cargo.toml`、`Cargo.lock`、`.cargo/**`、`.github/workflows/ohos-build.yml`）
- **THEN** GitHub Actions SHALL 自动启动 OHOS 构建流水线

#### Scenario: Push 到非匹配分支不触发
- **WHEN** 开发者推送代码到 `main` 分支
- **THEN** OHOS 构建流水线 SHALL NOT 被触发

#### Scenario: 手动触发构建
- **WHEN** 用户在 GitHub Actions 页面点击 "Run workflow"
- **THEN** 流水线 SHALL 启动构建，使用默认或用户指定的参数

#### Scenario: 并发构建取消
- **WHEN** 同一分支有新的 push 触发构建，且上一次构建仍在运行
- **THEN** 旧的构建 SHALL 被自动取消（`cancel-in-progress: true`）

### Requirement: Runner 环境

流水线 SHALL 在自托管 ARM64 Linux Runner 上运行，Runner MUST 预装以下工具：
- OHOS SDK（含 musl sysroot 和 LLVM 工具链）
- Rust 工具链（含 `aarch64-unknown-linux-ohos` target）
- cmake、ninja
- git

#### Scenario: Runner 标签匹配
- **WHEN** workflow 调度 Job
- **THEN** Job SHALL 仅在标签为 `[self-hosted, Linux, ARM64]` 的 Runner 上运行

#### Scenario: OHOS SDK 不存在时报错
- **WHEN** Runner 上 `OHOS_SDK_ROOT` 指向的目录不存在
- **THEN** 构建 SHALL 在环境检查步骤失败，并输出明确的错误信息

#### Scenario: 构建超时保护
- **WHEN** 构建时间超过 300 分钟
- **THEN** Job SHALL 被自动终止

### Requirement: 源码检出

流水线 SHALL 将 uv 仓库源码检出到 Runner 工作目录。

#### Scenario: 检出指定分支
- **WHEN** 流水线被 push 事件触发
- **THEN** 系统 SHALL 使用 `actions/checkout@v4` 检出触发构建的 commit

#### Scenario: 手动触发时检出默认分支
- **WHEN** 流水线通过 `workflow_dispatch` 触发
- **THEN** 系统 SHALL 检出仓库的默认分支

### Requirement: 多级缓存

流水线 SHALL 实现三级缓存策略以加速增量构建。

#### Scenario: Cargo registry 缓存恢复
- **WHEN** Runner 本地存在 cargo registry 缓存目录
- **THEN** 系统 SHALL 将缓存复制到 workspace 的 `.cargo/registry` 目录，避免重新下载 crates

#### Scenario: Cargo registry 缓存保存
- **WHEN** 构建完成后
- **THEN** 系统 SHALL 将 workspace 的 `.cargo/registry` 目录同步回 Runner 本地缓存路径

#### Scenario: Rust 增量编译产物持久化
- **WHEN** `CARGO_TARGET_DIR` 指向 Runner 本地持久路径
- **THEN** 编译产物 SHALL 跨 run 保留，cargo 增量编译可直接利用上次产物

#### Scenario: actions/cache 作为 fallback
- **WHEN** Runner 本地无增量编译产物（首次构建或 Runner 重建后）
- **THEN** 系统 SHALL 尝试从 `actions/cache@v4` 恢复缓存，cache key 基于 Cargo.lock 哈希

### Requirement: 环境配置

流水线 SHALL 在构建前配置 OHOS 交叉编译所需的环境变量。

#### Scenario: OHOS SDK 环境变量设置
- **WHEN** 环境配置步骤执行
- **THEN** 系统 SHALL 设置 `OHOS_SYSROOT`、`CC_aarch64_unknown_linux_ohos`、`CFLAGS_aarch64_unknown_linux_ohos`、`CXX_aarch64_unknown_linux_ohos`、`AR_aarch64_unknown_linux_ohos`、`CARGO_TARGET_AARCH64_UNKNOWN_LINUX_OHOS_LINKER`、`AWS_LC_SYS_CMAKE_AR`、`AWS_LC_SYS_CMAKE_RANLIB` 等环境变量

#### Scenario: CARGO_BUILD_JOBS 限制
- **WHEN** 环境配置步骤执行
- **THEN** 系统 SHALL 设置 `CARGO_BUILD_JOBS=2` 以控制内存使用

### Requirement: 构建执行

流水线 SHALL 使用 cargo 构建 uv 的 OHOS aarch64 release 二进制。

#### Scenario: 构建命令执行
- **WHEN** 环境配置和缓存恢复完成
- **THEN** 系统 SHALL 执行 `cargo build --release --target aarch64-unknown-linux-ohos -p uv`

#### Scenario: 构建失败时退出
- **WHEN** cargo build 返回非零退出码
- **THEN** Job SHALL 标记为失败，后续步骤（验证、打包、上传）SHALL NOT 执行

### Requirement: 产物验证

流水线 SHALL 对构建产物进行格式和依赖验证。

#### Scenario: ELF 格式验证
- **WHEN** 构建成功
- **THEN** `file` 命令的输出 SHALL 包含 `ELF` 和 `ARM aarch64`

#### Scenario: 动态依赖验证
- **WHEN** 构建成功
- **THEN** `readelf -d` 输出的 NEEDED 条目 SHALL 仅包含 `libc.so`，不包含其他动态库

#### Scenario: 产物大小记录
- **WHEN** 构建成功
- **THEN** 系统 SHALL 使用 `ls -lh` 记录产物文件大小到日志

### Requirement: 产物打包与上传

流水线 SHALL 将构建产物打包并上传到 GitHub Actions Artifacts。

#### Scenario: 产物命名
- **WHEN** 构建和验证通过
- **THEN** 产物名称 SHALL 遵循格式 `uv-ohos-aarch64-{version}-{commit_short}-{date}`

#### Scenario: tar.gz 打包
- **WHEN** 产物命名完成
- **THEN** 系统 SHALL 将 `uv` 二进制和 README 文件打包为 `.tar.gz`

#### Scenario: 上传到 Artifacts
- **WHEN** 打包完成
- **THEN** 系统 SHALL 使用 `actions/upload-artifact@v4` 上传 tar.gz 文件，保留 30 天

#### Scenario: 原始二进制上传
- **WHEN** 打包完成
- **THEN** 系统 SHALL 额外上传原始 `uv` ELF 二进制文件，便于直接下载使用

### Requirement: 共享目录复制（可选）

流水线 SHALL 支持将产物复制到 Runner 上的共享目录，供 OHOS 设备取用。

#### Scenario: 共享目录存在时复制
- **WHEN** Runner 上 `/mnt/linux_share/ci-test` 目录存在或可创建
- **THEN** 系统 SHALL 将 `uv` 二进制复制到该目录，文件名包含版本和 commit 信息

#### Scenario: 共享目录不可用时跳过
- **WHEN** 共享目录创建失败
- **THEN** 该步骤 SHALL 输出警告但不影响 Job 整体状态
