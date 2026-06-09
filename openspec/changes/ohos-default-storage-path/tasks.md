## 1. OHOS HOME 重定向

- [x] 1.1 在 `crates/uv/src/lib.rs` 的 `main()` 函数中添加 OHOS 的 `HOME` 重定向逻辑，放在 Windows 异常处理设置之后、`UV` 环境变量赋值之前。通过 `std::env::current_exe().parent()` 获取 uv 可执行文件所在目录并设置为 `HOME`，使用 `#[cfg(target_env = "ohos")]` 保护。不需要额外的可写性判断，uv 所在目录默认可写。
- [x] 1.2 移除旧的可写性探测逻辑（创建 `.uv_probe` 目录的代码），简化为直接使用 `current_exe().parent()`。
- [x] 1.3 在 `main()` 中添加 OHOS 的 `UV_LIBC` 预设逻辑。当 `UV_LIBC` 未设置时设为 `musl`，绕过沙盒环境下的文件系统 libc 检测。
- [x] 1.4 在 `main()` 中添加 OHOS 的 `UV_PYTHON_INSTALL_DIR` 重定向逻辑。当 `UV_PYTHON_INSTALL_DIR` 未设置时设为 `/data/local/tmp/.local/share/uv/python`，绕过沙盒对 ELF shared object 的执行限制。

## 2. 测试验证

- [x] 2.1 交叉编译 uv 到 `aarch64-unknown-linux-ohos` 并部署到 OHOS 设备。
- [x] 2.2 验证 `uv cache dir` 在不手动设置环境变量的情况下输出正确路径（基于可执行文件所在目录动态解析）。
- [x] 2.3 验证 `uv python list` 不再报 `Read-only file system` 错误。
- [x] 2.4 验证 `UV_CACHE_DIR` 覆盖仍然优先于基于 `HOME` 的默认值。
- [x] 2.5 通过在宿主机上运行 `cargo check` 验证对标准 Linux/macOS/Windows 构建无影响。
- [x] 2.6 验证 uv 在 OHOS 终端沙盒中执行 `uv run` 脚本（包括 Python 执行）正常工作。
- [x] 2.7 验证 Python 安装在 `/data/local/tmp/.local/share/uv/python/` 后可正常执行。

## 3. 文档

- [x] 3.1 在代码中添加注释，说明 OHOS `HOME` 重定向的原因（只读根文件系统限制）。
- [x] 3.2 更新 `OHOS_uv_测试设计文档.md`，说明此修复后不再需要手动设置环境变量。
- [x] 3.3 更新 `design.md`，添加决策 5（UV_LIBC 预设）和决策 6（UV_PYTHON_INSTALL_DIR 重定向）的说明。
