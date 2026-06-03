## Context

当前 OHOS uv 测试（`test-uv-ohos.sh`，107 个用例）仅通过退出码判断 PASS/FAIL。在 OHOS 这样的特殊平台上，退出码为 0 不代表功能真正可用：

- `.so` 扩展可能因 musl libc / OHOS 内核差异而无法加载
- Python 解释器可能安装了但二进制不能在 OHOS 上正常执行
- wheel 可能构建了但平台标签不正确
- editable 安装可能退化为普通安装

需要一个独立的功能验证测试脚本来补充现有测试，在不修改原有脚本的前提下，对关键用例进行端到端的功能验证。

### 约束

- 不修改 `test-uv-ohos.sh` 和 `OHOS_uv_测试设计文档.md`
- 功能验证脚本依赖原脚本已创建的环境（Python 3.12、testvenv、testproj 等）
- 通过 `hdc shell` 在 OHOS 设备上远程执行验证命令
- MSYS2 路径转换问题需同样处理

## Goals / Non-Goals

**Goals:**

- 为 107 个用例中**适合功能验证的用例**编写具体的验证命令
- 创建独立脚本 `verify-uv-ohos.sh`，可在原脚本后运行
- 引入 PARTIAL 状态：命令成功但功能不可用
- 生成独立的验证报告

**Non-Goals:**

- 不修改或替换原有测试脚本
- 不为不需要功能验证的用例（如 `--help`、`dir` 类纯信息命令）编写验证
- 不增加新的测试用例（仅对现有用例补充验证）

## Decisions

### D1: 脚本独立性

**选择**: 创建独立脚本 `verify-uv-ohos.sh`，不嵌入原脚本

**理由**:
- 原脚本已通过 106/107，功能验证是增量补充
- 独立脚本可单独运行、单独失败、单独报告
- 用户可选择性运行：`test-uv-ohos.sh && verify-uv-ohos.sh`

**替代方案**: 在 `run_test` 函数中增加 `verify_cmd` 参数 → 需要修改原脚本，违反约束

### D2: 前置条件复用

**选择**: verify 脚本自行完成环境准备（安装 Python、创建 venv、创建项目），不依赖原脚本的执行状态

**理由**:
- 用户可能只想跑功能验证
- 独立环境准备确保验证结果可复现
- 验证脚本内部按 Group 顺序执行，每个 Group 自行准备前置条件

### D3: 验证粒度

**选择**: 每个验证用例包含三层检查：

```
Layer 1: 命令退出码 (复用原脚本逻辑)
Layer 2: 功能验证命令 (新增)
Layer 3: 输出模式匹配 (可选)
```

结果映射：
| Layer 1 | Layer 2 | 结果 |
|---------|---------|------|
| 失败 | 不执行 | ❌ FAIL |
| 成功 | 不执行 (无需验证) | ✅ PASS |
| 成功 | 成功 | ✅ PASS |
| 成功 | 失败 | ⚠️ PARTIAL |

### D4: 验证用例筛选标准

不是所有 107 个用例都需要功能验证。筛选标准：

**需要验证的用例**（功能有副作用、有可观测状态变化）：
- pip install/uninstall → 包是否真的可用
- venv 创建 → Python 是否可执行
- python install → 解释器是否能运行
- project init → 文件结构是否正确
- tool install → 工具是否可执行
- build → 产物是否可安装
- run 类命令 → 本身已是功能验证，无需额外检查

**不需要验证的用例**（纯信息查询、帮助命令）：
- `--help`、`--version` 类
- `dir`、`cache dir` 等路径查询
- `pip list`、`pip show` 等纯展示命令
- `auth --help`、`publish --help` 等帮助信息

### D5: 功能验证命令编写原则

1. **使用设备上的 venv Python 执行** — 验证安装结果必须在目标 venv 的 Python 中 `import`
2. **验证正向和反向** — install 后验证 import 成功，uninstall 后验证 import 失败
3. **验证关键属性** — editable 安装验证 `__file__` 路径指向源码目录，不只是能 import
4. **超时保护** — 每个验证命令也有超时，避免 hang
5. **最小依赖** — 验证命令尽量不依赖额外包，用标准库 + 刚安装的包即可

## 需要功能验证的用例清单

### Group B: Python 管理（5 个）

| 用例 | 验证命令 | 验证逻辑 |
|------|---------|---------|
| B2 | `python3.12 -c "import sys; print(sys.version)"` | 输出包含 "3.12" |
| B3 | `$FOUND_PY -c "print('hello')"` | 退出码为 0，输出 "hello" |
| B5 | `cat .python-version` | 内容包含 "3.12" |
| B9 | `python3.12 -c "import sys; print(sys.version)"` | 重装后仍可执行 |
| B4 | `python3.12 --version` | 退出码非 0（已卸载） |

### Group C: 虚拟环境 + pip（16 个）

| 用例 | 验证命令 | 验证逻辑 |
|------|---------|---------|
| C1 | `testvenv/bin/python -c "import sys; print(sys.prefix)"` | 输出包含 "testvenv" |
| C10 | `testvenv_seed/bin/pip --version` | 退出码为 0 |
| C12 | `testvenv_py/bin/python -c "import sys; print(sys.version)"` | 输出包含 "3.12" |
| C13 | `testvenv/bin/python -c "import sys; print(sys.prefix)"` | --clear 后 venv 仍可用 |
| C2 | `testvenv/bin/python -c "import requests; print(requests.__version__)"` | 输出为版本号 |
| C3 | `testvenv/bin/python -c "import requests"` | 退出码为 0（与 list 交叉验证） |
| C4 | `testvenv/bin/python -c "import requests; print(requests.__version__)"` | show 输出与实际版本一致 |
| C8 | `testvenv/bin/python -c "import urllib3" 2>/dev/null; echo $?` | 退出码非 0（已卸载） |
| C8b | `testvenv/bin/python -c "import requests" 2>/dev/null; echo $?` | 退出码非 0（已卸载） |
| C9b | `testvenv/bin/python -c "import requests; print(requests.__version__)"` | sync 后包可用 |
| C18 | `testvenv/bin/python -c "import chardet; print(chardet.__version__)"` | 从文件安装后包可用 |
| C19 | `testvenv/bin/python -c "import requests; print(requests.__version__)"` | 升级后仍可 import |
| C20 | `testvenv/bin/python -c "import idna; print(idna.__version__)"` | --no-deps 安装后包本身可用 |
| C21 | `testvenv/bin/python -c "import test_ohos_lib; print(test_ohos_lib.__file__)"` | 路径包含 "testproj_lib"（非 site-packages） |
| C22 | `testvenv/bin/python -c "import chardet" 2>/dev/null; echo $?` | 退出码非 0（批量卸载成功） |
| C11 | `testvenv_seed/bin/python -c "import pip; print(pip.__version__)"` | seed venv 中 pip 可 import |

### Group D: 项目管理（14 个）

| 用例 | 验证命令 | 验证逻辑 |
|------|---------|---------|
| D1 | `ls /data/local/tmp/testproj/pyproject.toml` | 文件存在 |
| D2 | `ls /data/local/tmp/testproj/uv.lock` | lock 文件存在 |
| D4 | `grep "requests" testproj/pyproject.toml` | pyproject.toml 包含 requests |
| D7 | 已有 `print('hello from ohos')` 输出验证 | 输出包含 "hello from ohos" |
| D7b | 已有 `print(requests.__version__)` 输出验证 | 输出匹配版本号模式 |
| D4b | `grep "pytest" testproj/pyproject.toml` | dev 依赖写入正确 |
| D6 | `grep -v "requests" testproj/pyproject.toml` 或检查 dependency-groups | requests 不在主依赖中 |
| D6b | `grep -v "pytest" testproj/pyproject.toml` | pytest 不在 dev 依赖中 |
| D9 | `ls /data/local/tmp/testproj_lib/pyproject.toml` | lib 项目结构正确 |
| D10 | `head -5 /data/local/tmp/test_script.py` | 包含 PEP 723 metadata |
| D11 | `grep "requests" /data/local/tmp/test_script.py` | 脚本 metadata 包含 requests |
| D12 | `uv run /data/local/tmp/test_script.py` 输出 | 脚本执行成功（本身即验证） |
| D14 | `ls /data/local/tmp/testproj_app/pyproject.toml` | app 项目结构正确 |
| D17 | `grep "test-ohos-lib" testproj/pyproject.toml` | editable 依赖写入正确 |

### Group E: Tool 管理（5 个）

| 用例 | 验证命令 | 验证逻辑 |
|------|---------|---------|
| E1 | `$(uv tool dir --bin)/ruff --version` | ruff 可执行且输出版本 |
| E2 | `uv tool list \| grep "ruff"` | 列表包含 ruff |
| E3 | 已有 `--version` 输出验证 | 本身即功能验证 |
| E4 | `uv tool list \| grep -v "ruff"` 或检查退出码 | ruff 不在列表中 |
| E5 | `$(uv tool dir --bin)/black --version` | black 可执行 |

### Group G: Build（3 个）

| 用例 | 验证命令 | 验证逻辑 |
|------|---------|---------|
| G1 | `tar tzf build_out/*.tar.gz \| grep pyproject.toml` | sdist 包含项目文件 |
| G2 | `uv pip install build_out/*.whl` + `import test_ohos_build` | wheel 可安装且可 import |
| G3 | `ls build_out2/*.tar.gz build_out2/*.whl` | 两种格式产物都存在 |

## Risks / Trade-offs

**[Risk] 验证脚本环境准备失败** → 脚本内置与原脚本相同的环境准备逻辑（安装 Python、创建 venv），带完整错误处理和跳过策略

**[Risk] 验证命令本身有 bug 导致误报 PARTIAL** → 每个验证命令在设计文档中明确列出，可审查；验证失败时输出完整命令和输出便于调试

**[Risk] 额外执行时间** → 验证脚本预计增加 1-2 分钟（主要是重复安装步骤），但验证价值远大于时间成本

**[Trade-off] 独立脚本 vs 集成** → 选择独立脚本增加了代码重复（环境准备），但换取了不修改原脚本的约束满足和独立运行能力

**[Trade-off] 部分用例无法功能验证** → `--help`/`dir`/`list` 等纯信息命令无法做功能验证，这些用例保持原脚本的退出码验证即可，不影响整体覆盖率
