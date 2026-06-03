## ADDED Requirements

### Requirement: 功能验证测试脚本

系统 SHALL 提供一个独立的 Bash 测试脚本 `verify-uv-ohos.sh`，通过 `hdc shell` 在 OHOS 设备上对 uv 关键功能进行端到端验证。

#### Scenario: 脚本独立运行

- **WHEN** 用户执行 `bash verify-uv-ohos.sh`（无需先运行 `test-uv-ohos.sh`）
- **THEN** 脚本 SHALL 自行完成设备连接检查、uv 可用性检查、环境准备（安装 Python 3.12、创建 venv、创建项目等），然后依次执行各组功能验证

#### Scenario: 三种测试结果分类

- **WHEN** 某用例的主命令退出码为 0 且功能验证通过
- **THEN** 结果 SHALL 标记为 `PASS` ✅

- **WHEN** 某用例的主命令退出码为 0 但功能验证失败
- **THEN** 结果 SHALL 标记为 `PARTIAL` ⚠️

- **WHEN** 某用例的主命令退出码非 0
- **THEN** 结果 SHALL 标记为 `FAIL` ❌

#### Scenario: 前置条件不满足时跳过

- **WHEN** Python 3.12 安装失败
- **THEN** 所有依赖 Python 的验证用例（Group C/D/G）SHALL 标记为 `SKIP` ⏭️

### Requirement: Python 管理功能验证

脚本 SHALL 对 Python 安装、查找、pin、重装、卸载操作进行功能验证。

#### Scenario: Python 安装后可执行

- **WHEN** `uv python install 3.12` 命令成功（退出码 0）
- **THEN** 已安装的 Python 解释器 SHALL 能执行 `python3.12 -c "import sys; print(sys.version)"` 且输出包含 "3.12"

#### Scenario: Python 卸载后不可执行

- **WHEN** `uv python uninstall 3.12` 命令成功
- **THEN** `python3.12 --version` SHALL 返回非 0 退出码

#### Scenario: Python pin 写入版本文件

- **WHEN** `uv python pin 3.12` 命令成功
- **THEN** `.python-version` 文件 SHALL 存在且内容包含 "3.12"

### Requirement: 虚拟环境功能验证

脚本 SHALL 对 venv 创建的虚拟环境进行实际可用性验证。

#### Scenario: venv Python 可执行且前缀正确

- **WHEN** `uv venv /data/local/tmp/testvenv` 命令成功
- **THEN** `testvenv/bin/python` SHALL 可执行 `import sys; print(sys.prefix)` 且输出包含 "testvenv"

#### Scenario: --seed venv 中 pip 可用

- **WHEN** `uv venv --seed` 创建的虚拟环境
- **THEN** 该环境的 `bin/pip --version` SHALL 返回退出码 0

### Requirement: pip 安装卸载功能验证

脚本 SHALL 对 pip install/uninstall 的结果进行 import 级别的验证。

#### Scenario: pip install 后包可导入

- **WHEN** `uv pip install requests` 命令成功
- **THEN** venv 的 Python SHALL 能执行 `import requests; print(requests.__version__)` 且输出匹配版本号模式 `[0-9]+\.`

#### Scenario: pip uninstall 后包不可导入

- **WHEN** `uv pip uninstall urllib3` 命令成功
- **THEN** venv 的 Python 执行 `import urllib3` SHALL 返回非 0 退出码

#### Scenario: pip install -e 指向源码目录

- **WHEN** `uv pip install -e /data/local/tmp/testproj_lib` 命令成功
- **THEN** venv 的 Python 执行 `import test_ohos_lib; print(test_ohos_lib.__file__)` 的输出 SHALL 包含 "testproj_lib" 且不包含 "site-packages"（验证真正的 editable 链接）

#### Scenario: pip install --no-deps 仅安装包本身

- **WHEN** `uv pip install --no-deps idna` 命令成功
- **THEN** `import idna` SHALL 成功，但 `idna` 的子依赖（如有）SHALL 不在已安装列表中

#### Scenario: pip install -r 从文件安装后可导入

- **WHEN** `uv pip install -r requirements.txt` 命令成功
- **THEN** requirements.txt 中列出的包 SHALL 可被 import

#### Scenario: pip uninstall -r 批量卸载后不可导入

- **WHEN** `uv pip uninstall -r requirements.txt` 命令成功
- **THEN** requirements.txt 中列出的包 SHALL 无法被 import

### Requirement: 项目管理功能验证

脚本 SHALL 对 uv init/add/remove/run 等项目管理操作进行文件结构和功能验证。

#### Scenario: init 创建正确的项目结构

- **WHEN** `uv init /data/local/tmp/testproj` 命令成功
- **THEN** `/data/local/tmp/testproj/pyproject.toml` 文件 SHALL 存在

#### Scenario: lock 生成锁文件

- **WHEN** `uv lock` 命令成功
- **THEN** `uv.lock` 文件 SHALL 存在于项目目录

#### Scenario: add 依赖写入 pyproject.toml

- **WHEN** `uv add requests` 命令成功
- **THEN** `pyproject.toml` 的 dependencies 列表 SHALL 包含 "requests"

#### Scenario: remove 依赖从 pyproject.toml 移除

- **WHEN** `uv remove requests` 命令成功
- **THEN** `pyproject.toml` 的 dependencies 列表 SHALL 不包含 "requests"

#### Scenario: PEP 723 脚本包含内联 metadata

- **WHEN** `uv init --script` 创建的脚本文件
- **THEN** 文件头部 SHALL 包含 `# /// script` 格式的 PEP 723 metadata

#### Scenario: init --lib 创建库项目结构

- **WHEN** `uv init --lib` 命令成功
- **THEN** 项目目录 SHALL 包含 `pyproject.toml` 且包含 `[build-system]` 配置

### Requirement: Tool 管理功能验证

脚本 SHALL 对 tool install/uninstall 的结果进行可执行性验证。

#### Scenario: tool install 后工具可执行

- **WHEN** `uv tool install ruff` 命令成功
- **THEN** `$(uv tool dir --bin)/ruff --version` SHALL 返回退出码 0 并输出版本号

#### Scenario: tool uninstall 后工具不在列表中

- **WHEN** `uv tool uninstall ruff` 命令成功
- **THEN** `uv tool list` 输出 SHALL 不包含 "ruff"

### Requirement: Build 产物功能验证

脚本 SHALL 对 build 生成的 sdist/wheel 产物进行有效性验证。

#### Scenario: sdist 包含项目文件

- **WHEN** `uv build --sdist` 命令成功
- **THEN** 生成的 `.tar.gz` 文件 SHALL 能解压且包含 `pyproject.toml`

#### Scenario: wheel 可安装且可导入

- **WHEN** `uv build --wheel` 命令成功
- **THEN** 生成的 `.whl` 文件 SHALL 能通过 `uv pip install` 安装到 venv，且安装后 `import test_ohos_build` 成功

#### Scenario: build all 生成两种格式

- **WHEN** `uv build` (无 `--sdist`/`--wheel` 参数) 命令成功
- **THEN** 输出目录 SHALL 同时包含 `.tar.gz` 和 `.whl` 文件

### Requirement: 验证报告生成

脚本 SHALL 生成独立的 Markdown 格式验证报告。

#### Scenario: 报告包含 PARTIAL 统计

- **WHEN** 功能验证完成
- **THEN** 报告 SHALL 包含 PASS/PARTIAL/FAIL/SKIP 四种状态的统计和详情

#### Scenario: PARTIAL 用例包含诊断信息

- **WHEN** 某用例结果为 PARTIAL
- **THEN** 报告 SHALL 包含主命令输出、验证命令、验证命令输出，便于定位问题

### Requirement: 脚本参数与兼容性

脚本 SHALL 支持与原脚本一致的参数和运行环境。

#### Scenario: 参数兼容

- **WHEN** 用户传入 `--uv-path`、`--hdc`、`--timeout` 参数
- **THEN** 脚本 SHALL 使用指定值（默认值与原脚本一致）

#### Scenario: MSYS2 路径转换处理

- **WHEN** 在 Git Bash 环境下运行
- **THEN** 脚本 SHALL 设置 `MSYS_NO_PATHCONV=1` 防止路径自动转换
