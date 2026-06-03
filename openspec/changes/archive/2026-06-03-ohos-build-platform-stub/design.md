## Context

uv 在 OHOS 设备上已完成交叉编译和部署，107 个测试用例中 103 个通过（96.3%）。剩余 4 个失败中，3 个是 `uv build`（G1/G2/G3），原因是 PEP 517 构建后端（setuptools）不识别 OHOS 的 `"harmonyos"` 平台标识。

当前 uv 的 PEP 517 构建流程（`crates/uv-build-frontend/src/lib.rs`）：
1. 创建临时隔离 venv（`uv_virtualenv::create_venv`）
2. 安装构建依赖（如 setuptools）到隔离 venv
3. 生成 Python 脚本字符串，内容类似：`import setuptools.build_meta as backend; backend.build_wheel(...)`
4. 通过 `python -c <script>` 在隔离 venv 中执行

setuptools 在执行 `build_wheel()` / `build_sdist()` 时，内部调用 `sysconfig.get_platform()` 获取平台信息。OHOS 的 Python 返回 `"harmonyos"` 而非 `"linux"`，setuptools 的平台标签生成逻辑不认识这个值，导致构建失败。

uv 已在 `crates/uv-python/python/get_interpreter_info.py` 中做了同样的映射（`"harmonyos"` → `"linux"`），证明了此方案的可行性。

## Goals / Non-Goals

**Goals:**
- 在 OHOS 平台上使 `uv build --sdist`、`uv build --wheel`、`uv build` 正常工作（G1/G2/G3 通过）
- 桩代码对构建后端透明，兼容 setuptools、hatchling、flit-core 等所有 PEP 517 后端
- 改动仅在 OHOS 编译时生效，不影响其他平台
- 不修改任何磁盘上的 Python 文件或 venv 内容

**Non-Goals:**
- 不修复 setuptools 上游（应由 setuptools 项目自行修复）
- 不处理 `uv build` 以外的构建场景（如 `uv pip install` 从源码构建 sdist，那是独立的问题）
- 不替换或修改构建后端本身

## Decisions

### 决策 1: 桩注入方式 — 内联到生成的 Python 脚本中

**选择**: 在 `pep517_build()` 生成的 Python 脚本字符串开头注入桩代码，放在 `import backend` 之前。

**备选方案**:
- **方案 B: `sitecustomize.py` 文件** — 在隔离 venv 的 site-packages 里写入 `sitecustomize.py`。缺点：需要在 venv 创建后、build 执行前写入文件，增加了文件系统操作；且 sitecustomize 加载时机在 Python 初始化时，可能被某些构建后端绕过。
- **方案 C: `.pth` 文件** — 在 site-packages 里写入 `.pth` 文件。缺点：`.pth` 文件中的 import 语句行为在不同 Python 版本间有差异。
- **方案 D: 环境变量 `PYTHONSTARTUP`** — 通过环境变量加载脚本。缺点：`PYTHONSTARTUP` 仅在交互式模式下生效，`python -c` 不执行。

**理由**: 内联注入最简单可靠——不需要修改文件系统，不需要处理 Python 的模块加载顺序，桩代码在任何 `import` 之前执行，100% 覆盖所有构建后端。且由于 uv 的构建脚本本身就是字符串拼接生成的，注入点天然存在。

### 决策 2: 桩代码覆盖范围 — `sysconfig.get_platform` + `distutils.util.get_platform`

**选择**: 同时桩 `sysconfig.get_platform` 和 `distutils.util.get_platform`（如果存在）。

**理由**: 虽然 Python 3.12+ 已弃用 distutils，但 setuptools 内部仍通过 `setuptools._distutils` 或 `setuptools.extern` 访问 distutils 的 `get_platform`。部分旧版构建后端可能直接 `from distutils.util import get_platform`。两个都桩确保覆盖完整。

### 决策 3: 平台映射 — `"harmonyos"` → `"linux"`，而非删除或替换为其他值

**选择**: 将 `get_platform()` 返回值中的 `"harmonyos"` 替换为 `"linux"`。

**理由**: OHOS 是 Linux-based + musl libc，与 `linux-aarch64` 在 ABI 层面兼容。wheel 标签 `linux_aarch64` 能正确匹配 OHOS 上安装的 Python 环境。这与 uv 在 `get_interpreter_info.py` 中已有的处理方式一致。

### 决策 4: 编译时条件 — `#[cfg(target_env = "ohos")]`

**选择**: 使用 `cfg(target_env = "ohos")` 保护桩代码注入，仅 OHOS 编译的 uv 二进制包含此逻辑。

**理由**: 避免对非 OHOS 平台的构建流程产生任何影响。与 `lib.rs` 中已有的 OHOS HOME 重定向保持一致的 cfg 模式。

## Risks / Trade-offs

- **[风险] setuptools 未来版本改变平台检测调用链** → 桩代码覆盖了 `sysconfig.get_platform` 和 `distutils.util.get_platform` 两个主要入口，且使用 monkey-patch 方式在运行时拦截，不依赖具体调用链。如果 setuptools 引入全新的平台检测函数，可能需要更新桩代码。缓解：桩代码简单，维护成本低。
- **[风险] 其他构建后端不使用 `get_platform()`** → 如果某个构建后端使用 `sys.platform` 或 `platform.system()` 做检测，当前桩可能不够。缓解：当前 OHOS 上的 Python 的 `sys.platform` 返回 `"linux"`（OHOS 基于 Linux 内核），大多数构建后端已经能正常工作。仅在 setuptools 的 `get_platform()` 路径上观察到问题。
- **[Trade-off] OHOS-specific hack 增加代码复杂度** → 改动局限在一个 `cfg` 块内，约 10 行 Python 字符串，对整体代码可读性影响极小。如果上游 setuptools 未来修复了 OHOS 支持，可以安全移除此桩代码。
