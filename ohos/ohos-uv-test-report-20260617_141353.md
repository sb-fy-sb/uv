# OHOS uv 测试报告

## 测试摘要

| 指标 | 数值 |
|------|------|
| 测试时间 | 2026-06-17 14:13:53 |
| uv 版本 | 0.11.18 |
| uv 路径 | uv |
| 超时设置 | 60s |
| 快速模式 | 否 |
| 总用例 | 107 |
| 通过 | 38 |
| 失败 | 11 |
| 跳过 | 58 |
| 通过率 | **77.6%** |

## 失败用例详情

### A11: self update --dry-run

- **命令**: `uv self update --dry-run`
- **错误**: OHOS 环境限制：不支持自更新
- **耗时**: 0.1s
- **输出** (前 20 行):
```
error: uv was installed through an external package manager and cannot update itself.

hint: Please use your package manager to update uv
```

### B5: Python pin

- **命令**: `uv python pin 3.12`
- **错误**: 
- **耗时**: 0.2s
- **输出** (前 20 行):
```
error: The requested Python version `3.12` is incompatible with the project `requires-python` value of `==3.12.9`.
```

### C1: 创建虚拟环境

- **命令**: `uv venv /tmp/testvenv`
- **错误**: 
- **耗时**: 0.2s
- **输出** (前 20 行):
```
Using CPython 3.12.9
Creating virtual environment at: /tmp/testvenv
error: Failed to create virtual environment
  Caused by: failed to create directory `/tmp/testvenv`: Read-only file system (os error 30)
```

### D1: init 项目

- **命令**: `uv init /tmp/testproj`
- **错误**: 
- **耗时**: 0.2s
- **输出** (前 20 行):
```
error: failed to create directory `/tmp/testproj`: Read-only file system (os error 30)
```

### E3: tool run ruff

- **命令**: `uv tool run ruff --version`
- **错误**: 
- **耗时**: 0.4s
- **输出** (前 20 行):
```
error: Failed to spawn: `ruff`
  Caused by: Permission denied (os error 13)
```

### E7: tool run 指定版本

- **命令**: `uv tool run ruff@0.3.0 --version`
- **错误**: 
- **耗时**: 1.0s
- **输出** (前 20 行):
```
error: Failed to spawn: `ruff`
  Caused by: Permission denied (os error 13)
```

### F1: cache prune

- **命令**: `uv cache prune`
- **错误**: 
- **耗时**: 60.0s
- **输出** (前 20 行):
```
[TIMEOUT after 60s]
```

### F2: cache clean

- **命令**: `uv cache clean`
- **错误**: 
- **耗时**: 60.0s
- **输出** (前 20 行):
```
[TIMEOUT after 60s]
```

### G1: build sdist

- **命令**: `uv build --sdist /tmp/testproj_lib --out-dir /tmp/build_out`
- **错误**: 
- **耗时**: 0.1s
- **输出** (前 20 行):
```
error: Source `/tmp/testproj_lib` does not exist
```

### G2: build wheel

- **命令**: `uv build --wheel /tmp/testproj_lib --out-dir /tmp/build_out`
- **错误**: 
- **耗时**: 0.1s
- **输出** (前 20 行):
```
error: Source `/tmp/testproj_lib` does not exist
```

### G3: build (all)

- **命令**: `uv build /tmp/testproj_lib --out-dir /tmp/build_out`
- **错误**: 
- **耗时**: 0.1s
- **输出** (前 20 行):
```
error: Source `/tmp/testproj_lib` does not exist
```

## 跳过用例列表

| ID | 名称 | 原因 |
|----|------|------|
| B9 | Python 重装 | 不再主动安装/重装 Python |
| C10 | venv --seed | C1 失败，跳过后续 |
| C11 | 验证 seed 安装 | C1 失败，跳过后续 |
| C12 | venv --python 3.12 | C1 失败，跳过后续 |
| C13 | venv --clear | C1 失败，跳过后续 |
| C14 | venv --allow-existing | C1 失败，跳过后续 |
| C15 | venv --no-project | C1 失败，跳过后续 |
| C16 | venv --system-site-packages | C1 失败，跳过后续 |
| C17 | venv --prompt | C1 失败，跳过后续 |
| C2 | pip install requests | C1 失败，跳过后续 |
| C3 | pip list | C1 失败，跳过后续 |
| C3b | pip list --format json | C1 失败，跳过后续 |
| C4 | pip show requests | C1 失败，跳过后续 |
| C5 | pip freeze | C1 失败，跳过后续 |
| C6 | pip check | C1 失败，跳过后续 |
| C7 | pip tree | C1 失败，跳过后续 |
| C2b | pip install urllib3 | C1 失败，跳过后续 |
| C3c | pip list --outdated | C1 失败，跳过后续 |
| C8 | pip uninstall urllib3 | C1 失败，跳过后续 |
| C8b | pip uninstall requests | C1 失败，跳过后续 |
| C9 | pip compile | C1 失败，跳过后续 |
| C9b | pip sync | C1 失败，跳过后续 |
| C18 | pip install -r | C1 失败，跳过后续 |
| C19 | pip install --upgrade | C1 失败，跳过后续 |
| C20 | pip install --no-deps | C1 失败，跳过后续 |
| C21 | pip install -e | C1 失败，跳过后续 |
| C22 | pip uninstall -r | C1 失败，跳过后续 |
| D2 | lock | D1 失败，跳过后续 |
| D3 | sync | D1 失败，跳过后续 |
| D4 | add 依赖 | D1 失败，跳过后续 |
| D5 | tree | D1 失败，跳过后续 |
| D5b | project version | D1 失败，跳过后续 |
| D4b | add --dev 依赖 | D1 失败，跳过后续 |
| D6b | remove --dev 依赖 | D1 失败，跳过后续 |
| D6 | remove 依赖 | D1 失败，跳过后续 |
| D7 | run | D1 失败，跳过后续 |
| D8 | export | D1 失败，跳过后续 |
| D7b | run --with | D1 失败，跳过后续 |
| D2b | lock --upgrade | D1 失败，跳过后续 |
| D3b | sync --frozen | D1 失败，跳过后续 |
| D9 | init --lib | D1 失败，跳过后续 |
| D10 | init --script | D1 失败，跳过后续 |
| D11 | add --script | D1 失败，跳过后续 |
| D12 | run script.py | D1 失败，跳过后续 |
| D13 | run -m module | D1 失败，跳过后续 |
| D14 | init --app | D1 失败，跳过后续 |
| D15 | add --optional | D1 失败，跳过后续 |
| D16 | add --group | D1 失败，跳过后续 |
| D17 | add --editable | D1 失败，跳过后续 |
| D18 | sync --no-dev | D1 失败，跳过后续 |
| D19 | export --format pylock.toml | D1 失败，跳过后续 |
| D20 | export --format cyclonedx1.5 | D1 失败，跳过后续 |
| D21 | format | D1 失败，跳过后续 |
| D22 | add --raw | D1 失败，跳过后续 |
| I1 | workspace dir | D1 失败，跳过 I 组 |
| I2 | workspace list | D1 失败，跳过 I 组 |
| I3 | workspace metadata | D1 失败，跳过 I 组 |
| B4 | 卸载 Python 3.12 | 不再主动安装，跳过卸载 |

## 完整结果表格

| ID | 测试用例 | 状态 | 耗时 |
|----|---------|------|------|
| A1 | 版本号 | ✅ | 0.0s |
| A2 | 帮助信息 | ✅ | 0.1s |
| A3a | pip 帮助 | ✅ | 0.0s |
| A3b | python 帮助 | ✅ | 0.0s |
| A3c | tool 帮助 | ✅ | 0.0s |
| A3d | cache 帮助 | ✅ | 0.0s |
| A3e | venv 帮助 | ✅ | 0.0s |
| A3f | build 帮助 | ✅ | 0.0s |
| A3g | self 帮助 | ✅ | 0.0s |
| A3h | workspace 帮助 | ✅ | 0.0s |
| A3i | auth 帮助 | ✅ | 0.1s |
| A4 | Cache 目录 | ✅ | 0.0s |
| A5 | Cache 大小 | ✅ | 0.1s |
| A6 | Tool 目录 | ✅ | 0.1s |
| A7 | Python 目录 | ✅ | 0.0s |
| A8 | pip debug | ✅ | 0.1s |
| A9 | auth dir | ✅ | 0.1s |
| A10 | self version | ✅ | 0.0s |
| A11 | self update --dry-run | ❌ | 0.1s |
| B1 | Python 列表 | ✅ | 1.0s |
| B2 | 检查 Python 3.12 | ✅ | 1.0s |
| B3 | 查找 Python | ✅ | 0.2s |
| B5 | Python pin | ❌ | 0.2s |
| B6 | 仅列出已安装 | ✅ | 1.0s |
| B7 | Python 列表 --all-versions | ✅ | 1.0s |
| B8 | Python 列表 JSON 格式 | ✅ | 1.0s |
| B9 | Python 重装 | ⏭️ | - |
| C1 | 创建虚拟环境 | ❌ | 0.2s |
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
| D1 | init 项目 | ❌ | 0.2s |
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
| E1 | tool install ruff | ✅ | 1.2s |
| E2 | tool list | ✅ | 0.2s |
| E3 | tool run ruff | ❌ | 0.4s |
| E4 | tool uninstall ruff | ✅ | 0.1s |
| E5 | tool install black | ✅ | 0.7s |
| E5b | tool upgrade black | ✅ | 0.5s |
| E5c | tool uninstall black | ✅ | 0.1s |
| E6 | tool dir --bin | ✅ | 0.1s |
| E7 | tool run 指定版本 | ❌ | 1.0s |
| E8 | tool install --from | ✅ | 0.3s |
| E9 | tool upgrade --all | ✅ | 0.0s |
| E10 | tool list --show-paths | ✅ | 0.0s |
| F1 | cache prune | ❌ | 60.0s |
| F2 | cache clean | ❌ | 60.0s |
| G1 | build sdist | ❌ | 0.1s |
| G2 | build wheel | ❌ | 0.1s |
| G3 | build (all) | ❌ | 0.1s |
| H1 | auth login 帮助 | ✅ | 0.0s |
| H2 | auth logout 帮助 | ✅ | 0.0s |
| H3 | auth token 帮助 | ✅ | 0.0s |
| I1 | workspace dir | ⏭️ | - |
| I2 | workspace list | ⏭️ | - |
| I3 | workspace metadata | ⏭️ | - |
| J1 | publish 帮助 | ✅ | 0.0s |
| B4 | 卸载 Python 3.12 | ⏭️ | - |
