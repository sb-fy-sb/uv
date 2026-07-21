## 1. Workflow 文件骨架

- [x] 1.1 创建 `.github/workflows/ohos-build.yml` 文件，定义 workflow name (`OHOS Build`)、触发条件（push 到 `ohos-aarch64`/`claude/ohos-*` 分支 + `workflow_dispatch`）、并发控制（`concurrency` group + `cancel-in-progress`）
- [x] 1.2 定义全局 `env` 块：`OHOS_SDK_ROOT`、`OHOS_SYSROOT`、`CARGO_INCREMENTAL=1`、`CARGO_BUILD_JOBS=2`、`CARGO_TARGET_DIR` 指向 Runner 本地持久路径
- [x] 1.3 定义单个 `build` Job，设置 `runs-on: [self-hosted, Linux, ARM64]` 和 `timeout-minutes: 300`

## 2. 源码检出与缓存

- [x] 2.1 添加 `actions/checkout@v4` 步骤检出源码
- [x] 2.2 添加 Cargo registry 缓存恢复步骤：从 Runner 本地 `/home/user/sources/uv/.cargo/registry` 复制到 workspace 的 `.cargo/registry`
- [x] 2.3 添加 Rust 增量编译产物恢复步骤：确认 `CARGO_TARGET_DIR` 路径存在且可写
- [x] 2.4 添加 `actions/cache@v4` 步骤作为 fallback，cache key 基于 `Cargo.lock` 哈希，path 为 `target/` 目录

## 3. 环境配置

- [x] 3.1 添加 "Verify runner environment" 步骤：检查 `OHOS_SDK_ROOT` 目录存在、`rustc --print target-list` 包含 `aarch64-unknown-linux-ohos`、`cmake --version` 和 `ninja --version` 可用
- [x] 3.2 添加 "Setup environment" 步骤：通过 `$GITHUB_ENV` 导出 OHOS 交叉编译环境变量（`CC_*`、`CXX_*`、`AR_*`、`CFLAGS_*`、`AWS_LC_SYS_CMAKE_*` 等）

## 4. 构建执行

- [x] 4.1 添加 "Build uv" 步骤：执行 `cargo build --release --target aarch64-unknown-linux-ohos -p uv`
- [x] 4.2 构建失败时 Job 自动标记失败（由 `set -e` 或 shell 默认行为保证）

## 5. 产物验证

- [x] 5.1 添加 "Verify binary" 步骤：使用 `file` 命令确认产物包含 `ELF` 和 `ARM aarch64`
- [x] 5.2 使用 `readelf -d` 检查 NEEDED 条目仅包含 `libc.so`，出现其他动态库时构建失败
- [x] 5.3 使用 `ls -lh` 记录产物文件大小

## 6. 产物打包与上传

- [x] 6.1 添加 "Package binary" 步骤：生成名称 `uv-ohos-aarch64-{version}-{commit}-{date}`，创建 tar.gz 包含 uv 二进制和 README
- [x] 6.2 添加 `actions/upload-artifact@v4` 步骤上传 tar.gz，`retention-days: 30`
- [x] 6.3 添加 `actions/upload-artifact@v4` 步骤上传原始 ELF 二进制，`retention-days: 30`

## 7. 共享目录与缓存保存

- [x] 7.1 添加 "Copy to shared directory" 步骤：将 uv 二进制复制到 `/mnt/linux_share/ci-test/`，目录不存在时输出警告但不失败
- [x] 7.2 添加 "Save cargo registry cache" 步骤：将 workspace 的 `.cargo/registry` 同步回 Runner 本地缓存路径

## 8. 验证与测试（需在 Runner 上手动执行）

- [ ] 8.1 在 Runner 上手动触发 workflow_dispatch，确认全量构建成功
- [ ] 8.2 推送小改动到 `ohos-aarch64` 分支，确认增量构建时间 < 10 分钟
- [ ] 8.3 验证 artifacts 下载后可在 OHOS 设备上正常执行 `uv --version`
