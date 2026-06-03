## Why

当前 OHOS uv 测试脚本（107 个用例）仅通过命令退出码（exit code == 0）判断测试通过，无法验证功能的实际可用性。例如 `uv pip install requests` 返回 0 只说明命令没有报错，但安装的包可能因 `.so` 扩展不兼容、依赖损坏等原因无法实际 `import`。这导致测试通过率高（99.1%）但无法确认 uv 在 OHOS 上的端到端功能完整性。

## What Changes

- 新增功能验证测试设计文档 `OHOS_uv_功能验证测试设计文档.md`，列出 107 个用例中需要且适合增加 PARTIAL 状态验证的用例及具体验证命令
- 新增独立测试脚本 `verify-uv-ohos.sh`，在原脚本执行完成后运行，仅包含功能验证部分
- 引入三种测试结果：`PASS`（功能验证通过）、`PARTIAL`（命令成功但功能不可用）、`FAIL`（命令本身失败）
- 不修改原有测试文档和脚本

## Capabilities

### New Capabilities

- `ohos-verify-tests`: OHOS 设备上 uv 功能验证测试能力，覆盖 Python 管理、虚拟环境、pip 操作、项目管理、Tool 管理、Build 等核心模块的实际功能验证

### Modified Capabilities

（无，不修改现有功能需求）

## Impact

- 新增文件：`ohos/OHOS_uv_功能验证测试设计文档.md`、`ohos/verify-uv-ohos.sh`
- 依赖：原测试脚本 `test-uv-ohos.sh` 的前置条件（Python 3.12 已安装、testvenv 已创建等），verify 脚本需独立运行或在原脚本后运行
- 不影响现有测试脚本和文档
