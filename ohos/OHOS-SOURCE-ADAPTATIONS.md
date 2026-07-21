# uv OHOS 源码适配点清单

> 本文档列出 sb-fy-sb/uv 相对于上游 astral-sh/uv 的所有 Rust/Python 源码改动。
> 不含 CI workflow、安装脚本、文档等非源码文件。

---

## 1. OHOS 存储路径重定向

**文件**: `crates/uv/src/lib.rs`
**改动**: +32 行

在 `main()` 入口处（线程启动前）添加两段 `#[cfg(target_env = "ohos")]` 代码：

### 1.1 HOME 重定向
```rust
#[cfg(target_env = "ohos")]
if let Ok(exe) = std::env::current_exe() {
    if let Some(parent) = exe.parent() {
        unsafe { std::env::set_var(EnvVars::HOME, parent); }
    }
}
```
- **原因**: OHOS 根文件系统只读，默认 HOME（`/root`）不可写
- **效果**: 所有 XDG 路径（`~/.cache/uv`、`~/.local/share/uv`）解析到可执行文件目录

### 1.2 UV_LIBC 预设
```rust
#[cfg(target_env = "ohos")]
if std::env::var_os(EnvVars::UV_LIBC).is_none() {
    unsafe { std::env::set_var(EnvVars::UV_LIBC, "musl"); }
}
```
- **原因**: OHOS 沙盒环境下通过 ELF 头检测 libc 会失败
- **效果**: 跳过文件系统检测，直接认定为 musl

---

## 2. OHOS musl libc 版本检测

**文件**: `crates/uv-platform/src/libc.rs`
**改动**: +41 行

新增 `detect_ohos_musl_version()` 函数，从 OHOS 特有的版本文件读取 musl 版本：

```rust
fn detect_ohos_musl_version() -> Option<LibcVersion> {
    let version_files = [
        "/system/etc/MUSL/generic/version.txt",
        "/data/service/el0/public/for-all-app/musl_namespace_config/version.txt",
    ];
    // 读取文件，正则提取 major.minor
}
```
- **调用位置**: `detect_linux_libc()` 入口处（快速路径）和 `detect_musl_version()` 末尾（fallback）
- **原因**: OHOS 的 musl loader 不输出标准版本信息

---

## 3. ohos 平台标签兼容

### 3.1 PlatformTag::Ohos 变体

**文件**: `crates/uv-platform-tags/src/platform_tag.rs`
**改动**: +15 行

- 新增 `PlatformTag::Ohos { arch: Arch }` 枚举变体
- `pretty()` 返回 `"OHOS"`
- `Display` 输出 `ohos_{arch}`（如 `ohos_aarch64`）
- `FromStr` 解析 `ohos_` 前缀

### 3.2 兼容标签列表

**文件**: `crates/uv-platform-tags/src/tags.rs`
**改动**: +3 行

在 `compatible_tags()` 的 `Musllinux` 分支中加入：
```rust
platform_tags.push(PlatformTag::Ohos { arch });
```
- **效果**: `linux-aarch64-musl` Python 可以安装 `ohos_aarch64` 标签的 wheel

---

## 4. PEP 517 平台桩

**文件**: `crates/uv-build-frontend/src/lib.rs`
**改动**: +30 行

### 4.1 OHOS_PLATFORM_STUB 常量

```rust
#[cfg(target_env = "ohos")]
const OHOS_PLATFORM_STUB: &str = "\
import sysconfig as _sysconfig
_orig_get_platform = _sysconfig.get_platform
def _patched_get_platform():
    return _orig_get_platform().replace('harmonyos', 'linux')
_sysconfig.get_platform = _patched_get_platform
try:
    import distutils.util
    distutils.util.get_platform = _patched_get_platform
except (ImportError, ModuleNotFoundError):
    pass
";
```
- **注入位置**: `backend_import()` 生成的 Python 脚本中，在 build backend import 之前
- **效果**: setuptools 构建时 `sysconfig.get_platform()` 返回 `linux` 而非 `harmonyos`

### 4.2 构建子进程 Python 调用方式

```rust
// 原来:
let mut child = Command::new(venv.python_executable())
// 改为:
let mut child = uv_python::Interpreter::python_command_tokio(venv.python_executable())
```

---

## 5. Python 解释器调用适配

**文件**: `crates/uv-python/src/interpreter.rs`
**改动**: +31 行

新增 `python_command()` 和 `python_command_tokio()` 方法，统一 Python 子进程的启动方式：

```rust
pub fn python_command(interpreter: &Path) -> std::process::Command {
    Self::python_command_impl(interpreter)
}

pub fn python_command_tokio(interpreter: &Path) -> tokio::process::Command {
    Self::python_command_impl(interpreter)
}

fn python_command_impl<C: From<std::process::Command>>(interpreter: &Path) -> C {
    std::process::Command::new(interpreter).into()
}
```
- **预留扩展点**: OHOS 上如需通过动态链接器启动 Python，只需修改 `python_command_impl`
- **调用方**: `interpreter.rs`（get_interpreter_info）、`run.rs`（6 处）、`compile.rs`（1 处）、`lib.rs`（1 处）

---

## 6. uv run Python 调用统一

**文件**: `crates/uv/src/commands/project/run.rs`
**改动**: +22 行

将所有 `Command::new(interpreter.sys_executable())` 替换为 `Interpreter::python_command_tokio(interpreter.sys_executable())`，共 6 处：

- `Self::Python(args)` — 直接运行 python
- `Self::PythonFile / PythonModule` — 运行文件/模块
- `Self::PythonScript / PythonZipapp` — 运行脚本/zipapp
- `Self::PythonRemote` — 运行远程脚本
- `Self::PythonStdin` — 从 stdin 运行

---

## 7. 字节码编译 Python 调用统一

**文件**: `crates/uv-installer/src/compile.rs`
**改动**: 1 行

```rust
// 原来:
let mut bytecode_compiler = Command::new(interpreter)
// 改为:
let mut bytecode_compiler = uv_python::Interpreter::python_command_tokio(interpreter)
```

---

## 8. Python 解释器信息获取

**文件**: `crates/uv-python/python/get_interpreter_info.py`
**改动**: +9 行

### 8.1 OHOS 平台识别

```python
# 原来:
if operating_system == "linux":
# 改为:
if operating_system in ("linux", "harmonyos", "ohos"):
```
- **效果**: OHOS 的 `sys.platform` 返回 `ohos` 或 `harmonyos`，统一走 Linux 分支处理

### 8.2 跳过 glibc 检测

```python
# 原来:
glibc_version = _get_glibc_version()
# 改为:
glibc_version = _GLibCVersion(-1, -1) if musl_version else _get_glibc_version()
```
- **原因**: OHOS 上 glibc 检测会失败且不需要（OHOS 始终用 musl）

---

## 9. musl 版本检测 Python 脚本

**文件**: `crates/uv-python/python/packaging/_musllinux.py`
**改动**: +43 行

在 `_get_musl_version()` 中增加三层 fallback：

1. **直接调用 loader**（原有逻辑，加 timeout=5）
2. **读取版本文件**（OHOS 特有）:
   - `/system/etc/MUSL/generic/version.txt`
   - `/data/service/el0/public/for-all-app/musl_namespace_config/version.txt`
3. **从 loader 二进制提取版本字符串**（正则搜索 `musl.*Version X.Y`）
4. **默认 1.2**（兜底，覆盖所有现代 musl）

---

## 10. 禁用 jemalloc

**文件**: `crates/uv-performance-memory-allocator/Cargo.toml` + `src/lib.rs`
**改动**: 各 1-2 行

```toml
# Cargo.toml: 添加 not(target_env = "ohos") 排除条件
[target.'cfg(all(..., not(target_env = "ohos"), ...))'.dependencies]
tikv-jemallocator = { version = "0.6.0" }
```

```rust
// lib.rs: 添加 not(target_env = "ohos") 排除条件
#[cfg(all(
    not(target_os = "windows"),
    not(target_env = "ohos"),  // 新增
    ...
))]
static GLOBAL: tikv_jemallocator::Jemalloc = tikv_jemallocator::Jemalloc;
```
- **原因**: jemalloc 在 OHOS musl 环境下编译失败或运行异常
- **效果**: OHOS 上使用系统默认分配器

---

## 11. Python 下载元数据

**文件**: `crates/uv-python/download-metadata.json`
**改动**: 删除 4778 条上游条目，新增 1 条

```json
{
  "cpython-3.12.9-linux-aarch64-musl": {
    "name": "cpython",
    "arch": { "family": "aarch64" },
    "os": "linux",
    "libc": "musl",
    "major": 3, "minor": 12, "patch": 9,
    "url": "https://sb-fy-sb.github.io/python-build-mirror/...",
    "sha256": "c5985aba...",
    "build": "ohos"
  }
}
```

---

## 改动统计

| 文件 | 行数变化 | 类别 |
|------|---------|------|
| `crates/uv/src/lib.rs` | +32 | 存储路径 + libc 预设 |
| `crates/uv-platform/src/libc.rs` | +41 | musl 版本检测 |
| `crates/uv-platform-tags/src/platform_tag.rs` | +15 | Ohos 标签定义 |
| `crates/uv-platform-tags/src/tags.rs` | +3 | Ohos 兼容标签 |
| `crates/uv-build-frontend/src/lib.rs` | +30 | PEP 517 平台桩 |
| `crates/uv-python/src/interpreter.rs` | +31 | Python 调用适配 |
| `crates/uv/src/commands/project/run.rs` | +22 | uv run 统一调用 |
| `crates/uv-installer/src/compile.rs` | +1 | 字节码编译调用 |
| `crates/uv-python/python/get_interpreter_info.py` | +9 | 解释器信息获取 |
| `crates/uv-python/python/packaging/_musllinux.py` | +43 | musl 版本检测 |
| `crates/uv-performance-memory-allocator/` | +2 | 禁用 jemalloc |
| `crates/uv-python/download-metadata.json` | 重写 | Python 下载元数据 |
| **合计** | **~229 行** | |
