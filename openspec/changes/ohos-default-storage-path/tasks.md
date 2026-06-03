## 1. OHOS HOME 重定向

- [x] 1.1 在 `crates/uv/src/lib.rs` 的 `main()` 函数中添加 OHOS 的 `HOME` 重定向逻辑，放在 Windows 异常处理设置之后、`UV` 环境变量赋值之前。使用 `cfg!(target_env = "ohos")` 保护。
- [x] 1.2 实现可写性检查：仅在当前 `HOME` 未设置或指向不可写目录时才设置 `HOME=/data/local/tmp`。通过尝试创建目录来检测可写性。

## 2. 测试验证

- [x] 2.1 交叉编译 uv 到 `aarch64-unknown-linux-ohos` 并部署到 OHOS 设备。
- [x] 2.2 验证 `uv cache dir` 在不手动设置环境变量的情况下输出 `/data/local/tmp/.cache/uv`。
- [x] 2.3 验证 `uv python list` 不再报 `Read-only file system` 错误。
- [x] 2.4 验证 `UV_CACHE_DIR` 覆盖仍然优先于基于 `HOME` 的默认值。
- [x] 2.5 通过在宿主机上运行 `cargo check` 验证对标准 Linux/macOS/Windows 构建无影响。

## 3. 文档

- [x] 3.1 在代码中添加注释，说明 OHOS `HOME` 重定向的原因（只读根文件系统限制）。
- [x] 3.2 更新 `OHOS_uv_测试设计文档.md`，说明此修复后不再需要手动设置环境变量。
