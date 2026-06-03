## 为什么要改

在鸿蒙（OHOS）设备上，根文件系统是只读的。uv 启动时尝试创建默认存储目录（`/root/.cache/uv`、`/root/.local/share/uv`）会失败，报错 `Read-only file system (os error 30)`。用户每次使用都必须手动设置环境变量（`UV_CACHE_DIR`、`UV_DATA_DIR`），这对一个命令行工具来说太不合理。其他已适配 OHOS 的项目（如 ohos-node）通过在启动时重定向 `HOME` 环境变量解决了同样的问题。

## 改了什么

- 在 uv 启动时，检测是否为 OHOS 平台（`target_env = "ohos"`），在任何目录初始化之前执行。
- 当运行在 OHOS 上且 `HOME` 指向不可写路径时，将 `HOME` 设置为 `/data/local/tmp`，这样所有 XDG 默认路径（`~/.cache/uv`、`~/.local/share/uv`、`~/.local/bin`）都自动指向可写分区。
- 这个改动是透明的：已经配置了 `UV_CACHE_DIR` 或 `UV_DATA_DIR` 的用户不受影响，非 OHOS 平台的行为完全不变。

## 功能能力

### 新增能力

- `ohos-storage-redirect`：在 OHOS 设备上，通过在进程启动时设置 `HOME=/data/local/tmp`，自动将 uv 的默认存储路径重定向到可写目录。

### 修改的能力

（无）

## 影响范围

- **代码**：`crates/uv/src/lib.rs` — 在 `main()` 函数中添加 `HOME` 重定向逻辑，用 `cfg!(target_env = "ohos")` 保护。
- **影响平台**：仅 OHOS（`aarch64-unknown-linux-ohos`）。Linux、macOS、Windows 不受影响。
- **向后兼容**：完全兼容。现有的环境变量覆盖（`UV_CACHE_DIR`、`UV_DATA_DIR`、`XDG_CACHE_HOME` 等）仍然优先。
- **测试验证**：可以在 OHOS 设备上运行 `uv cache dir` 和 `uv python install 3.12` 验证，不需要手动设置环境变量。
