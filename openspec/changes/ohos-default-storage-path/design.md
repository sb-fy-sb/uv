## 背景

uv 通过 XDG 基础目录规范来确定默认存储路径，具体逻辑在 `crates/uv-dirs/src/lib.rs` 中。函数 `user_cache_dir()`、`user_state_dir()` 和 `user_executable_directory()` 使用 `etcetera` crate 的 `choose_base_strategy()`，会根据 `$HOME` 解析出以下路径：

- **缓存目录**：`$HOME/.cache/uv`（在 OHOS 上即 `/root/.cache/uv`）
- **数据目录**：`$HOME/.local/share/uv`（在 OHOS 上即 `/root/.local/share/uv`）
- **可执行文件目录**：`$HOME/.local/bin`

在 OHOS 上，`$HOME=/root`，而根文件系统（`/`）是只读的，所有目录创建操作都会失败。OHOS 上唯一普遍可写的位置是 `/data/local/tmp/`。

目前，用户必须每次手动设置 `UV_CACHE_DIR`、`UV_DATA_DIR` 等环境变量。测试脚本通过 shell 级别的环境变量来规避这个问题。

## 目标 / 不做的事

**目标：**

- uv 在 OHOS 上开箱即用，不需要用户设置任何环境变量。
- 默认存储路径解析到 `/data/local/tmp/` 下的可写位置。
- 现有的环境变量覆盖（`UV_CACHE_DIR`、`UV_DATA_DIR`、`XDG_CACHE_HOME` 等）仍然优先。
- 对非 OHOS 平台（Linux、macOS、Windows）零影响。

**不做的事：**

- 修复 `uv build` 失败（setuptools 平台检测是独立问题）。
- 修复 `uv python pin`（写入只读根文件系统，独立问题）。
- 实现通用的 OHOS 平台抽象层（不只是路径重定向）。
- 修改 `uv-dirs` crate 本身的路径解析逻辑。

## 技术决策

### 决策 1：在启动时重定向 `HOME`（而非修改路径函数）

**选择**：在 `main()` 中、任何目录初始化之前设置 `HOME=/data/local/tmp`。

**对比过的方案**：

| 方案 | 优点 | 缺点 |
|------|------|------|
| **A. 设置 HOME 环境变量**（选中） | 改动极小（1 行代码）；所有路径自动生效；和 ohos-node 的做法一致 | `$HOME` 会传递给子进程 |
| **B. 修改 `uv-dirs` 函数** | 精确控制，只影响 uv 自身路径 | 需要修改 5+ 个函数；可能遗漏使用 `$HOME` 的第三方 crate；维护成本高 |
| **C. 设置 `XDG_*` 环境变量** | 比直接改 HOME 更显式 | 需要设置 3+ 个变量（`XDG_CACHE_HOME`、`XDG_DATA_HOME`、`XDG_BIN_HOME`）；容易遗漏 |

**理由**：方案 A 和 ohos-node（华为官方 Node.js OHOS 移植版）的做法一致 — 在 `src/node.cc` 中通过 `setenv()` 在启动时设置 `HOME`。这是经过社区验证的模式。`$HOME` 传递给子进程反而是优点：`uv run` 启动的 Python 脚本也会使用可写路径。

### 决策 2：使用 `cfg!(target_env = "ohos")` 做编译时保护

**选择**：用 `cfg!(target_env = "ohos")` 在编译时检测 OHOS。

**理由**：OHOS 的 target triple 是 `aarch64-unknown-linux-ohos`，其中 `target_env = "ohos"`。这是编译时常量，在非 OHOS 平台上零运行时开销。

### 决策 3：如果 HOME 已经可写就不覆盖

**选择**：仅在当前 `HOME` 指向不可写目录或未设置时才设置 `HOME`。

**理由**：如果用户或包装脚本已经把 `HOME` 设为了可写路径，应该尊重它。通过尝试创建 `$HOME/.cache` 目录来检测可写性。

### 决策 4：代码放在 `lib.rs` 的 main 入口

**选择**：在 `crates/uv/src/lib.rs` 的 `main()` 函数中添加重定向逻辑，放在 Windows 异常处理设置之后、`UV` 环境变量设置之前。

**理由**：这是 uv 执行过程中最早可以安全设置环境变量的位置（函数标记为 `unsafe` 就是为了这个目的）。它在任何 clap 参数解析或缓存初始化之前运行。

## 风险 / 权衡

- **[风险] `$HOME` 会影响子进程** → 这其实是优点：`uv run` 启动的 Python 脚本所在环境中 `~` 能正确解析。pip 等工具也会使用可写路径。
- **[风险] `/data/local/tmp` 在某些 OHOS 构建上可能不存在** → 缓解措施：如果目录不存在就创建它（不过 `/data/local/tmp` 是 OHOS 的标准路径，总是存在的）。
- **[权衡] 用 `target_env` 还是 `target_os` 检测** → OHOS 报告为 `target_os = "linux"` + `target_env = "ohos"`。使用 `target_env` 更精确，不会影响普通 Linux 构建。
