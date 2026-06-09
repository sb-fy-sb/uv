## 背景

uv 通过 XDG 基础目录规范来确定默认存储路径，具体逻辑在 `crates/uv-dirs/src/lib.rs` 中。函数 `user_cache_dir()`、`user_state_dir()` 和 `user_executable_directory()` 使用 `etcetera` crate 的 `choose_base_strategy()`，会根据 `$HOME` 解析出以下路径：

- **缓存目录**：`$HOME/.cache/uv`（在 OHOS 上即 `/root/.cache/uv`）
- **数据目录**：`$HOME/.local/share/uv`（在 OHOS 上即 `/root/.local/share/uv`）
- **可执行文件目录**：`$HOME/.local/bin`

在 OHOS 上，`$HOME=/root`，而根文件系统（`/`）是只读的，所有目录创建操作都会失败。uv 二进制文件通常部署在 `/data/local/tmp/uv`，该目录在 OHOS 上是可读写的数据分区，uv 运行时本身就依赖该路径可写。

目前，用户必须每次手动设置 `UV_CACHE_DIR`、`UV_DATA_DIR` 等环境变量。测试脚本通过 shell 级别的环境变量来规避这个问题。

## 目标 / 不做的事

**目标：**

- uv 在 OHOS 上开箱即用，不需要用户设置任何环境变量。
- 默认存储路径解析到 uv 可执行文件所在目录（即 uv 在 OHOS 设备上的当前存储位置），该位置默认保证可读写，不需要额外的可写性判断。
- 现有的环境变量覆盖（`UV_CACHE_DIR`、`UV_DATA_DIR`、`XDG_CACHE_HOME` 等）仍然优先。
- 对非 OHOS 平台（Linux、macOS、Windows）零影响。

**不做的事：**

- 修复 `uv build` 失败（setuptools 平台检测是独立问题）。
- 修复 `uv python pin`（写入只读根文件系统，独立问题）。
- 实现通用的 OHOS 平台抽象层（不只是路径重定向）。
- 修改 `uv-dirs` crate 本身的路径解析逻辑。

## 技术决策

### 决策 1：在启动时将 `HOME` 设置为 uv 可执行文件所在目录

**选择**：在 `main()` 中、任何目录初始化之前，通过 `std::env::current_exe()` 获取 uv 二进制文件路径，将其父目录设置为 `HOME`。例如，当 uv 位于 `/data/local/tmp/uv` 时，`HOME` 将被设置为 `/data/local/tmp`。

**对比过的方案**：

| 方案 | 优点 | 缺点 |
|------|------|------|
| **A. 设置 HOME 为可执行文件所在目录**（选中） | 动态适应 uv 部署位置；无需硬编码路径；无需可写性检测（部署位置默认可写）；所有 XDG 路径自动生效 | `$HOME` 会传递给子进程 |
| **B. 硬编码 HOME=/data/local/tmp** | 简单直接 | 路径硬编码，不灵活；若 uv 部署到其他可写目录则失效；需要额外的可写性检查 |
| **C. 修改 `uv-dirs` 函数** | 精确控制，只影响 uv 自身路径 | 需要修改 5+ 个函数；可能遗漏使用 `$HOME` 的第三方 crate；维护成本高 |
| **D. 设置 `XDG_*` 环境变量** | 比直接改 HOME 更显式 | 需要设置 3+ 个变量（`XDG_CACHE_HOME`、`XDG_DATA_HOME`、`XDG_BIN_HOME`）；容易遗漏 |

**理由**：方案 A 通过 `current_exe().parent()` 动态获取 uv 所在目录，既与 ohos-node（华为官方 Node.js OHOS 移植版）在 `src/node.cc` 中通过 `setenv()` 设置 `HOME` 的做法一致，又避免了硬编码路径。uv 运行时本身就依赖其所在目录可写（用于存放二进制文件），因此无需额外的可写性检测。`$HOME` 传递给子进程反而是优点：`uv run` 启动的 Python 脚本也会使用可写路径。

### 决策 2：使用 `cfg!(target_env = "ohos")` 做编译时保护

**选择**：用 `cfg!(target_env = "ohos")` 在编译时检测 OHOS。

**理由**：OHOS 的 target triple 是 `aarch64-unknown-linux-ohos`，其中 `target_env = "ohos"`。这是编译时常量，在非 OHOS 平台上零运行时开销。

### 决策 3：不需要可写性检查

**选择**：直接将 `HOME` 设置为 uv 可执行文件所在目录，不需要检测当前 `HOME` 是否可写。

**理由**：uv 可执行文件所在目录（如 `/data/local/tmp/`）在 OHOS 上是可读写的数据分区，uv 二进制文件本身就存储在此处，默认保证可读写。无需通过尝试创建探测目录来判断可写性，简化了代码逻辑。

### 决策 4：代码放在 `lib.rs` 的 main 入口

**选择**：在 `crates/uv/src/lib.rs` 的 `main()` 函数中添加重定向逻辑，放在 Windows 异常处理设置之后、`UV` 环境变量设置之前。

**理由**：这是 uv 执行过程中最早可以安全设置环境变量的位置（函数标记为 `unsafe` 就是为了这个目的）。它在任何 clap 参数解析或缓存初始化之前运行。

### 决策 5：在 OHOS 上预设 `UV_LIBC=musl`

**选择**：在 `main()` 中，当 `UV_LIBC` 未设置时，将其设为 `musl`。

**理由**：OHOS 始终使用 musl libc（`/lib/ld-musl-aarch64.so.1`）。uv 的 libc 检测通过读取 `/bin/sh` 的 ELF 头来查找动态链接器，但在 OHOS 终端等沙盒环境中，可能无法读取系统路径下的二进制文件，导致检测失败并报错 `Could not detect either glibc version nor musl libc version`。预设 `UV_LIBC=musl` 绕过了文件系统检测。仅在用户未手动设置时生效，保留了覆盖能力。

### 决策 6：将 Python 安装路径重定向到 `/data/local/tmp`

**选择**：在 `main()` 中，当 `UV_PYTHON_INSTALL_DIR` 未设置时，将其设为 `/data/local/tmp/.local/share/uv/python`。

**理由**：OHOS 沙盒应用（如终端应用 `com.huawei.hmos.hishell`）对用户存储目录（如 `/storage/Users/currentUser/`）中的 ELF shared object 执行有额外限制。python-build-standalone 提供的 Python 是 ELF shared object（非 PIE 可执行文件），从用户存储目录执行时会报 `Permission denied`。而 `/data/local/tmp` 没有此限制。

**权衡**：
- 缓存/数据目录仍跟随 uv 所在目录（`HOME` 指向 uv 的父目录）
- 只有 Python 安装路径固定到 `/data/local/tmp`，因为 Python 二进制必须可执行
- 这导致路径分离：uv 缓存可能在用户存储目录，而 Python 在 `/data/local/tmp`
- 用户可通过手动设置 `UV_PYTHON_INSTALL_DIR` 覆盖此行为

## 风险 / 权衡

- **[风险] `$HOME` 会影响子进程** → 这其实是优点：`uv run` 启动的 Python 脚本所在环境中 `~` 能正确解析。pip 等工具也会使用可写路径。
- **[权衡] 用 `target_env` 还是 `target_os` 检测** → OHOS 报告为 `target_os = "linux"` + `target_env = "ohos"`。使用 `target_env` 更精确，不会影响普通 Linux 构建。
- **[优点] 动态路径而非硬编码** → 通过 `current_exe().parent()` 获取路径，uv 部署到任何可写目录都能自动适配，无需修改代码。
