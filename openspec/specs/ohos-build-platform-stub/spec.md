# OHOS 平台兼容性桩

## Requirements

### Requirement: OHOS 平台兼容性桩自动注入
当 uv 在 OHOS 平台上编译并运行时，PEP 517 构建后端调用 `sysconfig.get_platform()` MUST 返回包含 `"linux"` 的平台标识，而非原始的 `"harmonyos"` 标识。

#### Scenario: setuptools 构建 sdist 成功
- **WHEN** 用户在 OHOS 设备上运行 `uv build --sdist`
- **THEN** 构建成功生成 `.tar.gz` 源码分发包，退出码为 0

#### Scenario: setuptools 构建 wheel 成功
- **WHEN** 用户在 OHOS 设备上运行 `uv build --wheel`
- **THEN** 构建成功生成 `.whl` 二进制分发包，退出码为 0

#### Scenario: setuptools 同时构建 sdist 和 wheel
- **WHEN** 用户在 OHOS 设备上运行 `uv build`（不指定 `--sdist` 或 `--wheel`）
- **THEN** 同时生成 `.tar.gz` 和 `.whl` 文件，退出码为 0

### Requirement: 桩代码仅影响 OHOS 平台
桩代码 MUST 仅在 `target_env = "ohos"` 编译时注入，非 OHOS 平台的 uv 二进制 MUST NOT 包含此桩代码。

#### Scenario: Linux 平台构建不受影响
- **WHEN** 用户在 Linux 设备上运行 `uv build`
- **THEN** 构建行为与此改动前完全一致，`sysconfig.get_platform()` 返回原始值

#### Scenario: macOS 平台构建不受影响
- **WHEN** 用户在 macOS 设备上运行 `uv build`
- **THEN** 构建行为与此改动前完全一致

#### Scenario: Windows 平台构建不受影响
- **WHEN** 用户在 Windows 设备上运行 `uv build`
- **THEN** 构建行为与此改动前完全一致

### Requirement: 桩代码覆盖 distutils 路径
桩代码 MUST 同时处理 `sysconfig.get_platform` 和 `distutils.util.get_platform`（如果可用），确保通过 distutils 调用平台检测的构建后端也能正常工作。

#### Scenario: 通过 distutils 调用 get_platform 时返回正确值
- **WHEN** 构建后端通过 `distutils.util.get_platform()` 获取平台信息
- **THEN** 返回值中 `"harmonyos"` MUST 被替换为 `"linux"`

#### Scenario: distutils 不可用时不报错
- **WHEN** 构建环境中的 Python 版本不提供 `distutils` 模块
- **THEN** 桩代码 MUST 静默跳过 distutils 部分，不影响构建流程

### Requirement: 不修改磁盘文件
桩代码 MUST 通过内联到生成的 Python 脚本字符串中注入，MUST NOT 在磁盘上写入 `sitecustomize.py`、`.pth` 文件或修改任何 Python 标准库文件。

#### Scenario: 隔离 venv 的 site-packages 保持干净
- **WHEN** uv build 创建隔离构建环境后
- **THEN** 隔离 venv 的 `site-packages` 目录中 MUST NOT 包含任何桩相关的文件（如 `sitecustomize.py`、`.pth` 文件）

#### Scenario: 构建完成后无残留文件
- **WHEN** uv build 完成后
- **THEN** 临时隔离环境 MUST 被清理，系统 Python 安装目录中 MUST NOT 留下任何桩相关文件
