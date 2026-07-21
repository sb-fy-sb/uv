## Why

sb-fy-sb/uv 仓库已完成 OpenHarmony (OHOS) aarch64 平台的全方位适配（代码适配、CI/CD 流水线、功能测试），但目前缺少一个面向 OHOS 用户的专用 README 文件。当前仓库的 README 仍是上游 astral-sh/uv 的原始内容，无法让 OHOS 用户快速了解该 fork 的移植内容、构建方法和部署指南。参考 OpenHarmonyPCDeveloper/rust 等 OHOS 生态项目的 README 格式，需要为该仓库编写一个完整的 OHOS 移植专用 README。

## What Changes

- 在仓库根目录新增 `README_OHOS.md` 文件（或替换现有 README），采用中文编写，仿照 OpenHarmonyPCDeveloper/rust 的 README 风格
- 涵盖项目简介、CI/CD 流水线状态徽章、OHOS 平台适配改动清单、交叉编译构建指南、设备部署方法、测试结果统计、已知问题等内容
- 引用 openspec/changes 下已完成的所有 OHOS 相关变更（ohos-ci-build-pipeline、ohos-default-storage-path、ohos-build-platform-stub、ohos-verify-tests）

## Capabilities

### New Capabilities
- `ohos-readme`: 面向 OHOS 用户的仓库 README 文档，涵盖项目概述、CI 流水线、适配内容、构建部署指南和测试结果

### Modified Capabilities

（无）

## Impact

- **新增文件**: `README_OHOS.md`（仓库根目录）
- **不影响**: 现有代码、构建流程、CI 流水线
- **维护**: 每次新增 OHOS 适配功能时需同步更新 README
