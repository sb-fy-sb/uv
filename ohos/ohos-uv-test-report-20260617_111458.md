# OHOS uv 测试报告

## 测试摘要

| 指标 | 数值 |
|------|------|
| 测试时间 | 2026-06-17 11:14:58 |
| uv 版本 | 未知 |
| uv 路径 | /data/local/tmp/uv |
| 超时设置 | 60s |
| 快速模式 | 否 |
| 总用例 | 107 |
| 通过 | 0 |
| 失败 | 35 |
| 跳过 | 72 |
| 通过率 | **0.0%** |

## 失败用例详情

### A1: 版本号

- **命令**: `uv --version`
- **错误**: 输出不包含 uv 版本号
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A2: 帮助信息

- **命令**: `uv --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A3a: pip 帮助

- **命令**: `uv pip --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A3b: python 帮助

- **命令**: `uv python --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A3c: tool 帮助

- **命令**: `uv tool --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A3d: cache 帮助

- **命令**: `uv cache --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A3e: venv 帮助

- **命令**: `uv venv --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A3f: build 帮助

- **命令**: `uv build --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A3g: self 帮助

- **命令**: `uv self --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A3h: workspace 帮助

- **命令**: `uv workspace --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A3i: auth 帮助

- **命令**: `uv auth --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A4: Cache 目录

- **命令**: `uv cache dir`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A5: Cache 大小

- **命令**: `uv cache size`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A6: Tool 目录

- **命令**: `uv tool dir`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A7: Python 目录

- **命令**: `uv python dir`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A8: pip debug

- **命令**: `uv pip debug`
- **错误**: 退出码 127
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A9: auth dir

- **命令**: `uv auth dir`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A10: self version

- **命令**: `uv self version`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### A11: self update --dry-run

- **命令**: `uv self update --dry-run`
- **错误**: OHOS 环境限制：不支持自更新
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### B1: Python 列表

- **命令**: `uv python list`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### B2: 安装 Python 3.12

- **命令**: `uv python install 3.12`
- **错误**: 安装失败，C/D/G 组将被跳过
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### B3: 查找 Python

- **命令**: `uv python find`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### B5: Python pin

- **命令**: `uv python pin 3.12`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### B6: 仅列出已安装

- **命令**: `uv python list --only-installed`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### B7: Python 列表 --all-versions

- **命令**: `uv python list --all-versions`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### B8: Python 列表 JSON 格式

- **命令**: `uv python list --only-installed --output-format json`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### B9: Python 重装

- **命令**: `uv python install --reinstall 3.12`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### E1: tool install ruff

- **命令**: `uv tool install ruff`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### F1: cache prune

- **命令**: `uv cache prune`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### F2: cache clean

- **命令**: `uv cache clean`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### H1: auth login 帮助

- **命令**: `uv auth login --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### H2: auth logout 帮助

- **命令**: `uv auth logout --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### H3: auth token 帮助

- **命令**: `uv auth token --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### J1: publish 帮助

- **命令**: `uv publish --help`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

### B4: 卸载 Python 3.12

- **命令**: `uv python uninstall 3.12`
- **错误**: 
- **耗时**: 0.0s
- **输出** (前 20 行):
```
[ERROR] hdc not found: hdc
```

## 跳过用例列表

| ID | 名称 | 原因 |
|----|------|------|
| C1 | 创建虚拟环境 | B2 失败，跳过 C 组 |
| C10 | venv --seed | B2 失败，跳过 C 组 |
| C11 | 验证 seed 安装 | B2 失败，跳过 C 组 |
| C12 | venv --python 3.12 | B2 失败，跳过 C 组 |
| C13 | venv --clear | B2 失败，跳过 C 组 |
| C14 | venv --allow-existing | B2 失败，跳过 C 组 |
| C15 | venv --no-project | B2 失败，跳过 C 组 |
| C16 | venv --system-site-packages | B2 失败，跳过 C 组 |
| C17 | venv --prompt | B2 失败，跳过 C 组 |
| C2 | pip install requests | B2 失败，跳过 C 组 |
| C3 | pip list | B2 失败，跳过 C 组 |
| C3b | pip list --format json | B2 失败，跳过 C 组 |
| C4 | pip show requests | B2 失败，跳过 C 组 |
| C5 | pip freeze | B2 失败，跳过 C 组 |
| C6 | pip check | B2 失败，跳过 C 组 |
| C7 | pip tree | B2 失败，跳过 C 组 |
| C2b | pip install urllib3 | B2 失败，跳过 C 组 |
| C3c | pip list --outdated | B2 失败，跳过 C 组 |
| C8 | pip uninstall urllib3 | B2 失败，跳过 C 组 |
| C8b | pip uninstall requests | B2 失败，跳过 C 组 |
| C9 | pip compile | B2 失败，跳过 C 组 |
| C9b | pip sync | B2 失败，跳过 C 组 |
| C18 | pip install -r | B2 失败，跳过 C 组 |
| C19 | pip install --upgrade | B2 失败，跳过 C 组 |
| C20 | pip install --no-deps | B2 失败，跳过 C 组 |
| C21 | pip install -e | B2 失败，跳过 C 组 |
| C22 | pip uninstall -r | B2 失败，跳过 C 组 |
| D1 | init 项目 | B2 失败，跳过 D 组 |
| D2 | lock | B2 失败，跳过 D 组 |
| D3 | sync | B2 失败，跳过 D 组 |
| D4 | add 依赖 | B2 失败，跳过 D 组 |
| D5 | tree | B2 失败，跳过 D 组 |
| D5b | project version | B2 失败，跳过 D 组 |
| D4b | add --dev 依赖 | B2 失败，跳过 D 组 |
| D6b | remove --dev 依赖 | B2 失败，跳过 D 组 |
| D6 | remove 依赖 | B2 失败，跳过 D 组 |
| D7 | run | B2 失败，跳过 D 组 |
| D8 | export | B2 失败，跳过 D 组 |
| D7b | run --with | B2 失败，跳过 D 组 |
| D2b | lock --upgrade | B2 失败，跳过 D 组 |
| D3b | sync --frozen | B2 失败，跳过 D 组 |
| D9 | init --lib | B2 失败，跳过 D 组 |
| D10 | init --script | B2 失败，跳过 D 组 |
| D11 | add --script | B2 失败，跳过 D 组 |
| D12 | run script.py | B2 失败，跳过 D 组 |
| D13 | run -m module | B2 失败，跳过 D 组 |
| D14 | init --app | B2 失败，跳过 D 组 |
| D15 | add --optional | B2 失败，跳过 D 组 |
| D16 | add --group | B2 失败，跳过 D 组 |
| D17 | add --editable | B2 失败，跳过 D 组 |
| D18 | sync --no-dev | B2 失败，跳过 D 组 |
| D19 | export --format pylock.toml | B2 失败，跳过 D 组 |
| D20 | export --format cyclonedx1.5 | B2 失败，跳过 D 组 |
| D21 | format | B2 失败，跳过 D 组 |
| D22 | add --raw | B2 失败，跳过 D 组 |
| E2 | tool list | E1 失败，跳过 E 组 |
| E3 | tool run ruff | E1 失败，跳过 E 组 |
| E4 | tool uninstall ruff | E1 失败，跳过 E 组 |
| E5 | tool install black | E1 失败，跳过 E 组 |
| E5b | tool upgrade black | E1 失败，跳过 E 组 |
| E5c | tool uninstall black | E1 失败，跳过 E 组 |
| E6 | tool dir --bin | E1 失败，跳过 E 组 |
| E7 | tool run 指定版本 | E1 失败，跳过 E 组 |
| E8 | tool install --from | E1 失败，跳过 E 组 |
| E9 | tool upgrade --all | E1 失败，跳过 E 组 |
| E10 | tool list --show-paths | E1 失败，跳过 E 组 |
| G1 | build sdist | B2 失败，跳过 G 组 |
| G2 | build wheel | B2 失败，跳过 G 组 |
| G3 | build (all) | B2 失败，跳过 G 组 |
| I1 | workspace dir | D1 失败，跳过 I 组 |
| I2 | workspace list | D1 失败，跳过 I 组 |
| I3 | workspace metadata | D1 失败，跳过 I 组 |

## 完整结果表格

| ID | 测试用例 | 状态 | 耗时 |
|----|---------|------|------|
| A1 | 版本号 | ❌ | 0.0s |
| A2 | 帮助信息 | ❌ | 0.0s |
| A3a | pip 帮助 | ❌ | 0.0s |
| A3b | python 帮助 | ❌ | 0.0s |
| A3c | tool 帮助 | ❌ | 0.0s |
| A3d | cache 帮助 | ❌ | 0.0s |
| A3e | venv 帮助 | ❌ | 0.0s |
| A3f | build 帮助 | ❌ | 0.0s |
| A3g | self 帮助 | ❌ | 0.0s |
| A3h | workspace 帮助 | ❌ | 0.0s |
| A3i | auth 帮助 | ❌ | 0.0s |
| A4 | Cache 目录 | ❌ | 0.0s |
| A5 | Cache 大小 | ❌ | 0.0s |
| A6 | Tool 目录 | ❌ | 0.0s |
| A7 | Python 目录 | ❌ | 0.0s |
| A8 | pip debug | ❌ | 0.0s |
| A9 | auth dir | ❌ | 0.0s |
| A10 | self version | ❌ | 0.0s |
| A11 | self update --dry-run | ❌ | 0.0s |
| B1 | Python 列表 | ❌ | 0.0s |
| B2 | 安装 Python 3.12 | ❌ | 0.0s |
| B3 | 查找 Python | ❌ | 0.0s |
| B5 | Python pin | ❌ | 0.0s |
| B6 | 仅列出已安装 | ❌ | 0.0s |
| B7 | Python 列表 --all-versions | ❌ | 0.0s |
| B8 | Python 列表 JSON 格式 | ❌ | 0.0s |
| B9 | Python 重装 | ❌ | 0.0s |
| C1 | 创建虚拟环境 | ⏭️ | - |
| C10 | venv --seed | ⏭️ | - |
| C11 | 验证 seed 安装 | ⏭️ | - |
| C12 | venv --python 3.12 | ⏭️ | - |
| C13 | venv --clear | ⏭️ | - |
| C14 | venv --allow-existing | ⏭️ | - |
| C15 | venv --no-project | ⏭️ | - |
| C16 | venv --system-site-packages | ⏭️ | - |
| C17 | venv --prompt | ⏭️ | - |
| C2 | pip install requests | ⏭️ | - |
| C3 | pip list | ⏭️ | - |
| C3b | pip list --format json | ⏭️ | - |
| C4 | pip show requests | ⏭️ | - |
| C5 | pip freeze | ⏭️ | - |
| C6 | pip check | ⏭️ | - |
| C7 | pip tree | ⏭️ | - |
| C2b | pip install urllib3 | ⏭️ | - |
| C3c | pip list --outdated | ⏭️ | - |
| C8 | pip uninstall urllib3 | ⏭️ | - |
| C8b | pip uninstall requests | ⏭️ | - |
| C9 | pip compile | ⏭️ | - |
| C9b | pip sync | ⏭️ | - |
| C18 | pip install -r | ⏭️ | - |
| C19 | pip install --upgrade | ⏭️ | - |
| C20 | pip install --no-deps | ⏭️ | - |
| C21 | pip install -e | ⏭️ | - |
| C22 | pip uninstall -r | ⏭️ | - |
| D1 | init 项目 | ⏭️ | - |
| D2 | lock | ⏭️ | - |
| D3 | sync | ⏭️ | - |
| D4 | add 依赖 | ⏭️ | - |
| D5 | tree | ⏭️ | - |
| D5b | project version | ⏭️ | - |
| D4b | add --dev 依赖 | ⏭️ | - |
| D6b | remove --dev 依赖 | ⏭️ | - |
| D6 | remove 依赖 | ⏭️ | - |
| D7 | run | ⏭️ | - |
| D8 | export | ⏭️ | - |
| D7b | run --with | ⏭️ | - |
| D2b | lock --upgrade | ⏭️ | - |
| D3b | sync --frozen | ⏭️ | - |
| D9 | init --lib | ⏭️ | - |
| D10 | init --script | ⏭️ | - |
| D11 | add --script | ⏭️ | - |
| D12 | run script.py | ⏭️ | - |
| D13 | run -m module | ⏭️ | - |
| D14 | init --app | ⏭️ | - |
| D15 | add --optional | ⏭️ | - |
| D16 | add --group | ⏭️ | - |
| D17 | add --editable | ⏭️ | - |
| D18 | sync --no-dev | ⏭️ | - |
| D19 | export --format pylock.toml | ⏭️ | - |
| D20 | export --format cyclonedx1.5 | ⏭️ | - |
| D21 | format | ⏭️ | - |
| D22 | add --raw | ⏭️ | - |
| E1 | tool install ruff | ❌ | 0.0s |
| E2 | tool list | ⏭️ | - |
| E3 | tool run ruff | ⏭️ | - |
| E4 | tool uninstall ruff | ⏭️ | - |
| E5 | tool install black | ⏭️ | - |
| E5b | tool upgrade black | ⏭️ | - |
| E5c | tool uninstall black | ⏭️ | - |
| E6 | tool dir --bin | ⏭️ | - |
| E7 | tool run 指定版本 | ⏭️ | - |
| E8 | tool install --from | ⏭️ | - |
| E9 | tool upgrade --all | ⏭️ | - |
| E10 | tool list --show-paths | ⏭️ | - |
| F1 | cache prune | ❌ | 0.0s |
| F2 | cache clean | ❌ | 0.0s |
| G1 | build sdist | ⏭️ | - |
| G2 | build wheel | ⏭️ | - |
| G3 | build (all) | ⏭️ | - |
| H1 | auth login 帮助 | ❌ | 0.0s |
| H2 | auth logout 帮助 | ❌ | 0.0s |
| H3 | auth token 帮助 | ❌ | 0.0s |
| I1 | workspace dir | ⏭️ | - |
| I2 | workspace list | ⏭️ | - |
| I3 | workspace metadata | ⏭️ | - |
| J1 | publish 帮助 | ❌ | 0.0s |
| B4 | 卸载 Python 3.12 | ❌ | 0.0s |
