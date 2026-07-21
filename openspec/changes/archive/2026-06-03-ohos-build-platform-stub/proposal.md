## Why

在 OHOS（OpenHarmony）设备上运行 `uv build` 时，构建失败（G1/G2/G3 全部失败）。原因是 uv 在隔离环境中调用 PEP 517 构建后端（通常是 setuptools），而 setuptools 内部的 `sysconfig.get_platform()` 返回 `"harmonyos"` 平台标识，setuptools 不认识这个值导致构建失败。uv 已经在 `get_interpreter_info.py` 中将 `"harmonyos"` 映射为 `"linux"` 解决了 Python 解释器发现的问题，现在需要在构建阶段做同样的处理。

## What Changes

- 在 `uv-build-frontend` 的 PEP 517 构建脚本生成逻辑中，当运行在 OHOS 平台（`cfg(target_env = "ohos")`）时，自动在构建脚本开头注入平台兼容性桩代码。
- 桩代码在 setuptools import 之前，将 `sysconfig.get_platform()` 的返回值从 `"harmonyos*"` 替换为 `"linux*"`，同时处理 `distutils.util.get_platform`（部分构建后端仍通过 distutils 调用）。
- 桩代码仅通过修改生成的 Python 脚本字符串注入，不修改任何文件系统上的 Python 安装或 venv 内容，不依赖 `sitecustomize.py` 或 `.pth` 文件。
- 此改动仅影响 OHOS 平台，其他平台（Linux、macOS、Windows）的构建行为完全不变。

## Capabilities

### New Capabilities
- `ohos-build-platform-stub`: 在 OHOS 平台上，为 PEP 517 构建后端自动注入平台兼容性桩，使 `sysconfig.get_platform()` 返回 `"linux"` 而非 `"harmonyos"`，从而让 setuptools 等构建后端正常工作。

### Modified Capabilities

## Impact

- **代码**: `crates/uv-build-frontend/src/lib.rs` — 在 `pep517_build()` 方法生成的 Python 脚本中注入平台桩代码，用 `cfg(target_env = "ohos")` 保护。
- **影响平台**: 仅 OHOS（`aarch64-unknown-linux-ohos`）。Linux、macOS、Windows 不受影响。
- **向后兼容**: 完全兼容。桩代码仅在 OHOS 编译时注入，非 OHOS 构建的 uv 二进制不会包含此代码。
- **测试验证**: 在 OHOS 设备上运行 `uv build --sdist`、`uv build --wheel`、`uv build` 验证 G1/G2/G3 从失败变为通过。
