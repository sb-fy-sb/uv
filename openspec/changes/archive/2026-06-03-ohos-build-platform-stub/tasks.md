## 1. 桩代码注入

- [x] 1.1 在 `crates/uv-build-frontend/src/lib.rs` 的 `Pep517Backend::backend_import()` 方法中，使用 `#[cfg(target_env = "ohos")]` 条件编译，在返回的 import 语句前拼接平台兼容性桩代码（桩 `sysconfig.get_platform` 和 `distutils.util.get_platform`，将 `"harmonyos"` 替换为 `"linux"`）
- [x] 1.2 确保桩代码在所有 4 个脚本生成点（`get_requires_for_build_*`、`prepare_metadata_for_build_*`、`build_sdist`、`build_wheel`）都生效，因为桩注入在 `backend_import()` 返回值中，所有调用点自动覆盖

## 2. 编译验证

- [x] 2.1 在非 OHOS 目标上运行 `cargo clippy` 确认无警告，验证 `#[cfg(target_env = "ohos")]` 保护的代码在非 OHOS 编译时完全被排除
- [x] 2.2 使用 `cargo xwin clippy` 验证 Windows 交叉编译无警告（项目规范要求）（跳过：cargo-xwin 未安装，且改动无 Windows 特定行为）
- [x] 2.3 运行 `cargo clippy --target aarch64-unknown-linux-ohos` 验证 OHOS 目标编译通过（如果本地环境支持）

## 3. 测试

- [x] 3.1 交叉编译 OHOS 二进制并部署到 OHOS 设备
- [x] 3.2 在 OHOS 设备上运行 `uv build --sdist`，验证 G1 从失败变为通过
- [x] 3.3 在 OHOS 设备上运行 `uv build --wheel`，验证 G2 从失败变为通过
- [x] 3.4 在 OHOS 设备上运行 `uv build`，验证 G3 从失败变为通过
- [x] 3.5 运行完整的 OHOS 测试套件（`test-uv-ohos.sh`），确认 103 个已有通过的用例不受影响（无回归）

## 4. 文档与收尾

- [x] 4.1 在 `ohos/OHOS_uv_已支持指令列表.txt` 中更新 G1/G2/G3 状态为已通过
- [x] 4.2 在 `ohos/OHOS_uv_测试设计文档.md` 的已知问题表中更新 build 相关条目
