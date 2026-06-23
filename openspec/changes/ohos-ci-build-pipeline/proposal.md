## Why

当前 uv 的 OHOS aarch64 构建完全依赖手动操作：开发者需要在本地或 OHOS 设备上手动配置工具链、执行 `cargo build`、验证产物、打包分发。这种方式不可复现、不可追溯，且无法在每次代码变更时自动验证 OHOS 平台的编译兼容性。需要一个 GitHub Actions CI/CD 流水线来实现自动化构建、验证和产物发布。

## What Changes

- 新增 `.github/workflows/ohos-build.yml` GitHub Actions workflow，在自托管 ARM64 Linux Runner 上交叉编译 uv for OHOS aarch64
- 使用 OHOS SDK（musl sysroot + LLVM 工具链）进行交叉编译，目标 triple 为 `aarch64-unknown-linux-ohos`
- 实现多级缓存策略：cargo registry 缓存、Rust 增量编译产物缓存、actions/cache 持久化缓存
- 构建后自动验证产物为有效的 ARM64 ELF 二进制，且仅动态链接 `libc.so`（无意外依赖）
- 构建产物打包为 tar.gz 并上传到 GitHub Actions Artifacts
- 支持 push 到 `ohos-aarch64` 分支和 `workflow_dispatch` 手动触发

## Capabilities

### New Capabilities
- `ohos-ci-pipeline`: 覆盖 GitHub Actions workflow 文件、触发条件、Runner 环境要求、构建步骤编排、缓存策略、产物验证与上传的完整 CI/CD 流水线定义

### Modified Capabilities
<!-- 无需修改已有 spec 的需求 -->

## Impact

- **新增文件**: `.github/workflows/ohos-build.yml`（约 200 行 workflow 定义）
- **Runner 环境依赖**: 需要自托管 ARM64 Linux Runner，预装 OHOS SDK、LLVM 工具链、cmake、ninja
- **构建依赖**: `aws-lc-rs` 需要 cmake + ninja 编译 aws-lc；jemalloc 已在 OHOS 上禁用
- **crates.io 镜像**: 使用 USTC 镜像（已在 `.cargo/config.toml` 中配置）
- **不影响**: 现有平台的构建流程、CI 流水线、代码逻辑
