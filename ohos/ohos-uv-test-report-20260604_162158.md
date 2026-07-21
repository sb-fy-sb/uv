# OHOS uv 功能验证测试报告

## 测试概览

| 项目 | 值 |
|------|-----|
| 测试时间 | 2026-06-04 16:25:14 |
| uv 版本 | uv 0.11.18 (501e53d52 2026-06-02 aarch64-unknown-linux-ohos) |
| 设备 | 3QC0124C03000579 |
| 总计 | 107 |
| 通过 | 79 |
| 失败 | 2 |
| 跳过 | 26 |

## ❌ 失败用例详情 (2 个)

### A11: self update --dry-run

**失败原因**: 退出码不匹配 (期望=0, 实际=2)

**输入命令**:
```bash
/data/local/tmp/uv self update --dry-run
```

**实际输出**:
```
error: uv was installed through an external package manager and cannot update itself.
```

---

### D1: init 项目

**失败原因**: 退出码不匹配 (期望=0, 实际=2)

**输入命令**:
```bash
/data/local/tmp/uv init /data/local/tmp/testproj
```

**实际输出**:
```
error: Project is already initialized in `/data/local/tmp/testproj` (`pyproject.toml` file exists)
```

---

## ⏭️ 跳过的用例 (26 个)

| ID | 测试用例 | 跳过原因 |
|----|---------|---------|
| D2 | lock | init 失败 |
| D3 | sync | init 失败 |
| D4 | add | init 失败 |
| D5 | tree | init 失败 |
| D5b | version | init 失败 |
| D4b | add --dev | init 失败 |
| D6b | remove --dev | init 失败 |
| D6 | remove | init 失败 |
| D7 | run | init 失败 |
| D8 | export | init 失败 |
| D7b | run --with | init 失败 |
| D2b | lock --upgrade | init 失败 |
| D3b | sync --frozen | init 失败 |
| D13 | run -m | init 失败 |
| D15 | add --optional | init 失败 |
| D16 | add --group | init 失败 |
| D9 | init --lib | init 失败 |
| D17 | add --editable | init 失败 |
| D18 | sync --no-dev | init 失败 |
| D19 | export pylock | init 失败 |
| D20 | export cyclonedx | init 失败 |
| D21 | format | init 失败 |
| D22 | add --raw | init 失败 |
| I1 | workspace dir | 项目未创建 |
| I2 | workspace list | 项目未创建 |
| I3 | workspace metadata | 项目未创建 |

## ✅ 通过的用例 (79 个)

| ID | 测试用例 |
|----|---------|
| A1 | 版本号 |
| A2 | 帮助信息 |
| A3a | pip 帮助 |
| A3b | python 帮助 |
| A3c | tool 帮助 |
| A3d | cache 帮助 |
| A3e | venv 帮助 |
| A3f | build 帮助 |
| A3g | self 帮助 |
| A3h | workspace 帮助 |
| A3i | auth 帮助 |
| A4 | Cache 目录 |
| A5 | Cache 大小 |
| A6 | Tool 目录 |
| A7 | Python 目录 |
| A8 | pip debug (unsupported) |
| A9 | auth dir |
| A10 | self version |
| B1 | Python 列表 |
| B2 | 安装 Python 3.12 |
| B3 | 查找 Python |
| B5 | Python pin |
| B6 | Python 列表 --only-installed |
| B7 | Python 列表 --all-versions |
| B8 | Python 列表 JSON 格式 |
| B9 | Python 重装 |
| C1 | 创建虚拟环境 |
| C10 | venv --seed |
| C11 | 验证 seed 安装 pip |
| C12 | venv --python 3.12 |
| C13 | venv --clear |
| C14 | venv --allow-existing |
| C15 | venv --no-project |
| C16 | venv --system-site-packages |
| C17 | venv --prompt |
| C2 | pip install requests |
| C3 | pip list |
| C3b | pip list --format json |
| C4 | pip show requests |
| C5 | pip freeze |
| C6 | pip check |
| C7 | pip tree |
| C2b | pip install urllib3 |
| C3c | pip list --outdated |
| C8 | pip uninstall urllib3 |
| C8b | pip uninstall requests |
| C9 | pip compile |
| C9b | pip sync |
| C18 | pip install -r |
| C19 | pip install --upgrade |
| C20 | pip install --no-deps |
| C21 | pip install -e |
| C22 | pip uninstall -r |
| D10 | init --script |
| D11 | add --script |
| D12 | run script.py |
| D14 | init --app |
| E1 | tool install ruff |
| E2 | tool list |
| E3 | tool run ruff |
| E4 | tool uninstall ruff |
| E5 | tool install black |
| E5b | tool upgrade black |
| E5c | tool uninstall black |
| E6 | tool dir --bin |
| E7 | tool run 指定版本 |
| E8 | tool install --from |
| E9 | tool upgrade --all |
| E10 | tool list --show-paths |
| F1 | cache prune |
| F2 | cache clean |
| G1 | build sdist |
| G2 | build wheel |
| G3 | build (all) |
| H1 | auth login 帮助 |
| H2 | auth logout 帮助 |
| H3 | auth token 帮助 |
| J1 | publish 帮助 |
| B4 | 卸载 Python 3.12 |

## 全部测试详细记录

### 1. [✅] A1: 版本号

**输入命令**:
```bash
/data/local/tmp/uv --version
```

**输出**:
```
uv 0.11.18 (501e53d52 2026-06-02 aarch64-unknown-linux-ohos)
```

---

### 2. [✅] A2: 帮助信息

**输入命令**:
```bash
/data/local/tmp/uv --help
```

**输出**:
```
An extremely fast Python package manager.
```

---

### 3. [✅] A3a: pip 帮助

**输入命令**:
```bash
/data/local/tmp/uv pip --help
```

**输出**:
```
Manage Python packages with a pip-compatible interface
```

---

### 4. [✅] A3b: python 帮助

**输入命令**:
```bash
/data/local/tmp/uv python --help
```

**输出**:
```
Manage Python versions and installations
```

---

### 5. [✅] A3c: tool 帮助

**输入命令**:
```bash
/data/local/tmp/uv tool --help
```

**输出**:
```
Run and install commands provided by Python packages
```

---

### 6. [✅] A3d: cache 帮助

**输入命令**:
```bash
/data/local/tmp/uv cache --help
```

**输出**:
```
Manage uv's cache
```

---

### 7. [✅] A3e: venv 帮助

**输入命令**:
```bash
/data/local/tmp/uv venv --help
```

**输出**:
```
Create a virtual environment
```

---

### 8. [✅] A3f: build 帮助

**输入命令**:
```bash
/data/local/tmp/uv build --help
```

**输出**:
```
Build Python packages into source distributions and wheels
```

---

### 9. [✅] A3g: self 帮助

**输入命令**:
```bash
/data/local/tmp/uv self --help
```

**输出**:
```
Manage the uv executable
```

---

### 10. [✅] A3h: workspace 帮助

**输入命令**:
```bash
/data/local/tmp/uv workspace --help
```

**输出**:
```
Inspect uv workspaces
```

---

### 11. [✅] A3i: auth 帮助

**输入命令**:
```bash
/data/local/tmp/uv auth --help
```

**输出**:
```
Manage authentication
```

---

### 12. [✅] A4: Cache 目录

**输入命令**:
```bash
/data/local/tmp/uv cache dir
```

**输出**:
```
/data/local/tmp/.cache/uv
```

---

### 13. [✅] A5: Cache 大小

**输入命令**:
```bash
/data/local/tmp/uv cache size
```

**输出**:
```
warning: `uv cache size` is experimental and may change without warning. Pass `--preview-features cache-size` to disable this warning.
```

---

### 14. [✅] A6: Tool 目录

**输入命令**:
```bash
/data/local/tmp/uv tool dir
```

**输出**:
```
/data/local/tmp/.local/share/uv/tools
```

---

### 15. [✅] A7: Python 目录

**输入命令**:
```bash
/data/local/tmp/uv python dir
```

**输出**:
```
/data/local/tmp/.local/share/uv/python
```

---

### 16. [✅] A8: pip debug (unsupported)

**输入命令**:
```bash
/data/local/tmp/uv pip debug
```

**输出**:
```
error: pip's `debug` is unsupported (consider using `uvx pip debug` instead)
```

---

### 17. [✅] A9: auth dir

**输入命令**:
```bash
/data/local/tmp/uv auth dir
```

**输出**:
```
/data/local/tmp/.local/share/uv/credentials
```

---

### 18. [✅] A10: self version

**输入命令**:
```bash
/data/local/tmp/uv self version
```

**输出**:
```
uv 0.11.18 (501e53d52 2026-06-02 aarch64-unknown-linux-ohos)
```

---

### 19. [❌] A11: self update --dry-run

**说明**: 退出码不匹配 (期望=0, 实际=2)

**输入命令**:
```bash
/data/local/tmp/uv self update --dry-run
```

**输出**:
```
error: uv was installed through an external package manager and cannot update itself.
```

---

### 20. [✅] B1: Python 列表

**输入命令**:
```bash
/data/local/tmp/uv python list
```

**输出**:
```
cpython-3.15.0b1-linux-aarch64-musl                 <download available>
```

---

### 21. [✅] B2: 安装 Python 3.12

**输入命令**:
```bash
/data/local/tmp/uv python install 3.12
```

**输出**:
```
Downloading cpython-3.12.13-linux-aarch64-musl (download) (27.2MiB)
```

---

### 22. [✅] B3: 查找 Python

**输入命令**:
```bash
/data/local/tmp/uv python find
```

**输出**:
```
/data/local/tmp/.local/share/uv/python/cpython-3.12-linux-aarch64-musl/bin/python3.12
```

---

### 23. [✅] B5: Python pin

**输入命令**:
```bash
/data/local/tmp/uv python pin 3.12 --project /data/local/tmp
```

**输出**:
```
Pinned `/data/local/tmp/.python-version` to `3.12`
```

---

### 24. [✅] B6: Python 列表 --only-installed

**输入命令**:
```bash
/data/local/tmp/uv python list --only-installed
```

**输出**:
```
cpython-3.12.13-linux-aarch64-musl    /data/local/tmp/.local/share/uv/python/cpython-3.12-linux-aarch64-musl/bin/python3.12
```

---

### 25. [✅] B7: Python 列表 --all-versions

**输入命令**:
```bash
/data/local/tmp/uv python list --all-versions
```

**输出**:
```
cpython-3.15.0b1-linux-aarch64-musl                 <download available>
```

---

### 26. [✅] B8: Python 列表 JSON 格式

**输入命令**:
```bash
/data/local/tmp/uv python list --only-installed --output-format json
```

**输出**:
```
[{"key":"cpython-3.12.13-linux-aarch64-musl","version":"3.12.13","version_parts":{"major":3,"minor":12,"patch":13},"path":"/data/local/tmp/.local/share/uv/python/cpython-3.12-linux-aarch64-musl/bin/python3.12","symlink":null,"url":null,"os":"linux","variant":"default","implementation":"cpython","arch":"aarch64","libc":"musl"}]
```

---

### 27. [✅] B9: Python 重装

**输入命令**:
```bash
/data/local/tmp/uv python install --reinstall 3.12
```

**输出**:
```
Downloading cpython-3.12.13-linux-aarch64-musl (download) (27.2MiB)
```

---

### 28. [✅] C1: 创建虚拟环境

**输入命令**:
```bash
/data/local/tmp/uv venv /data/local/tmp/testvenv
```

**输出**:
```
Using CPython 3.12.13
```

---

### 29. [✅] C10: venv --seed

**输入命令**:
```bash
/data/local/tmp/uv venv --seed /data/local/tmp/testvenv_seed
```

**输出**:
```
Using CPython 3.12.13
```

---

### 30. [✅] C11: 验证 seed 安装 pip

**输入命令**:
```bash
/data/local/tmp/uv pip list --python /data/local/tmp/testvenv_seed/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv_seed
```

---

### 31. [✅] C12: venv --python 3.12

**输入命令**:
```bash
/data/local/tmp/uv venv --python 3.12 /data/local/tmp/testvenv_py
```

**输出**:
```
Using CPython 3.12.13
```

---

### 32. [✅] C13: venv --clear

**输入命令**:
```bash
/data/local/tmp/uv venv --clear /data/local/tmp/testvenv
```

**输出**:
```
Using CPython 3.12.13
```

---

### 33. [✅] C14: venv --allow-existing

**输入命令**:
```bash
/data/local/tmp/uv venv --allow-existing /data/local/tmp/testvenv
```

**输出**:
```
Using CPython 3.12.13
```

---

### 34. [✅] C15: venv --no-project

**输入命令**:
```bash
/data/local/tmp/uv venv --no-project /data/local/tmp/testvenv2
```

**输出**:
```
Using CPython 3.12.13
```

---

### 35. [✅] C16: venv --system-site-packages

**输入命令**:
```bash
/data/local/tmp/uv venv --system-site-packages /data/local/tmp/testvenv_sys
```

**输出**:
```
Using CPython 3.12.13
```

---

### 36. [✅] C17: venv --prompt

**输入命令**:
```bash
/data/local/tmp/uv venv --prompt myenv /data/local/tmp/testvenv_prompt
```

**输出**:
```
Using CPython 3.12.13
```

---

### 37. [✅] C2: pip install requests

**输入命令**:
```bash
/data/local/tmp/uv pip install requests --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 38. [✅] C3: pip list

**输入命令**:
```bash
/data/local/tmp/uv pip list --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 39. [✅] C3b: pip list --format json

**输入命令**:
```bash
/data/local/tmp/uv pip list --python /data/local/tmp/testvenv/bin/python --format json
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 40. [✅] C4: pip show requests

**输入命令**:
```bash
/data/local/tmp/uv pip show requests --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 41. [✅] C5: pip freeze

**输入命令**:
```bash
/data/local/tmp/uv pip freeze --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 42. [✅] C6: pip check

**输入命令**:
```bash
/data/local/tmp/uv pip check --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 43. [✅] C7: pip tree

**输入命令**:
```bash
/data/local/tmp/uv pip tree --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 44. [✅] C2b: pip install urllib3

**输入命令**:
```bash
/data/local/tmp/uv pip install urllib3 --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 45. [✅] C3c: pip list --outdated

**输入命令**:
```bash
/data/local/tmp/uv pip list --python /data/local/tmp/testvenv/bin/python --outdated
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 46. [✅] C8: pip uninstall urllib3

**输入命令**:
```bash
/data/local/tmp/uv pip uninstall urllib3 --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 47. [✅] C8b: pip uninstall requests

**输入命令**:
```bash
/data/local/tmp/uv pip uninstall requests --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 48. [✅] C9: pip compile

**输入命令**:
```bash
/data/local/tmp/uv pip compile /data/local/tmp/requirements.in -o /data/local/tmp/requirements.txt
```

**输出**:
```
Resolved 5 packages in 11ms
```

---

### 49. [✅] C9b: pip sync

**输入命令**:
```bash
/data/local/tmp/uv pip sync /data/local/tmp/requirements.txt --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 50. [✅] C18: pip install -r

**输入命令**:
```bash
/data/local/tmp/uv pip install -r /data/local/tmp/requirements_install.txt --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 51. [✅] C19: pip install --upgrade

**输入命令**:
```bash
/data/local/tmp/uv pip install --upgrade requests --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 52. [✅] C20: pip install --no-deps

**输入命令**:
```bash
/data/local/tmp/uv pip install --no-deps idna --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 53. [✅] C21: pip install -e

**输入命令**:
```bash
/data/local/tmp/uv pip install -e /data/local/tmp/testproj_lib --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 54. [✅] C22: pip uninstall -r

**输入命令**:
```bash
/data/local/tmp/uv pip uninstall -r /data/local/tmp/requirements_install.txt --python /data/local/tmp/testvenv/bin/python
```

**输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 55. [❌] D1: init 项目

**说明**: 退出码不匹配 (期望=0, 实际=2)

**输入命令**:
```bash
/data/local/tmp/uv init /data/local/tmp/testproj
```

**输出**:
```
error: Project is already initialized in `/data/local/tmp/testproj` (`pyproject.toml` file exists)
```

---

### 56. [⏭️] D2: lock

**说明**: init 失败

---

### 57. [⏭️] D3: sync

**说明**: init 失败

---

### 58. [⏭️] D4: add

**说明**: init 失败

---

### 59. [⏭️] D5: tree

**说明**: init 失败

---

### 60. [⏭️] D5b: version

**说明**: init 失败

---

### 61. [⏭️] D4b: add --dev

**说明**: init 失败

---

### 62. [⏭️] D6b: remove --dev

**说明**: init 失败

---

### 63. [⏭️] D6: remove

**说明**: init 失败

---

### 64. [⏭️] D7: run

**说明**: init 失败

---

### 65. [⏭️] D8: export

**说明**: init 失败

---

### 66. [⏭️] D7b: run --with

**说明**: init 失败

---

### 67. [⏭️] D2b: lock --upgrade

**说明**: init 失败

---

### 68. [⏭️] D3b: sync --frozen

**说明**: init 失败

---

### 69. [⏭️] D13: run -m

**说明**: init 失败

---

### 70. [⏭️] D15: add --optional

**说明**: init 失败

---

### 71. [⏭️] D16: add --group

**说明**: init 失败

---

### 72. [⏭️] D9: init --lib

**说明**: init 失败

---

### 73. [⏭️] D17: add --editable

**说明**: init 失败

---

### 74. [⏭️] D18: sync --no-dev

**说明**: init 失败

---

### 75. [⏭️] D19: export pylock

**说明**: init 失败

---

### 76. [⏭️] D20: export cyclonedx

**说明**: init 失败

---

### 77. [⏭️] D21: format

**说明**: init 失败

---

### 78. [⏭️] D22: add --raw

**说明**: init 失败

---

### 79. [✅] D10: init --script

**输入命令**:
```bash
/data/local/tmp/uv init --script /data/local/tmp/test_script.py
```

**输出**:
```
Initialized script at `/data/local/tmp/test_script.py`
```

---

### 80. [✅] D11: add --script

**输入命令**:
```bash
/data/local/tmp/uv add --script /data/local/tmp/test_script.py requests
```

**输出**:
```
warning: Indexes specified via `--index-url` will not be persisted to the script; use `--default-index` instead.
```

---

### 81. [✅] D12: run script.py

**输入命令**:
```bash
/data/local/tmp/uv run /data/local/tmp/test_script.py
```

**输出**:
```
Installed 5 packages in 12ms
```

---

### 82. [✅] D14: init --app

**输入命令**:
```bash
/data/local/tmp/uv init --app /data/local/tmp/testproj_app
```

**输出**:
```
Initialized project `testproj-app` at `/data/local/tmp/testproj_app`
```

---

### 83. [✅] E1: tool install ruff

**输入命令**:
```bash
/data/local/tmp/uv tool install ruff
```

**输出**:
```
Resolved 1 package in 3.37s
```

---

### 84. [✅] E2: tool list

**输入命令**:
```bash
/data/local/tmp/uv tool list
```

**输出**:
```
ruff v0.15.15
```

---

### 85. [✅] E3: tool run ruff

**输入命令**:
```bash
/data/local/tmp/uv tool run ruff --version
```

**输出**:
```
ruff 0.15.15
```

---

### 86. [✅] E4: tool uninstall ruff

**输入命令**:
```bash
/data/local/tmp/uv tool uninstall ruff
```

**输出**:
```
Uninstalled 1 executable: ruff
```

---

### 87. [✅] E5: tool install black

**输入命令**:
```bash
/data/local/tmp/uv tool install black
```

**输出**:
```
Resolved 7 packages in 3.62s
```

---

### 88. [✅] E5b: tool upgrade black

**输入命令**:
```bash
/data/local/tmp/uv tool upgrade black
```

**输出**:
```
Nothing to upgrade
```

---

### 89. [✅] E5c: tool uninstall black

**输入命令**:
```bash
/data/local/tmp/uv tool uninstall black
```

**输出**:
```
Uninstalled 2 executables: black, blackd
```

---

### 90. [✅] E6: tool dir --bin

**输入命令**:
```bash
/data/local/tmp/uv tool dir --bin
```

**输出**:
```
/data/local/tmp/.local/bin
```

---

### 91. [✅] E7: tool run 指定版本

**输入命令**:
```bash
/data/local/tmp/uv tool run ruff@0.3.0 --version
```

**输出**:
```
Downloading ruff (6.9MiB)
```

---

### 92. [✅] E8: tool install --from

**输入命令**:
```bash
/data/local/tmp/uv tool install --from ruff ruff
```

**输出**:
```
Resolved 1 package in 16ms
```

---

### 93. [✅] E9: tool upgrade --all

**输入命令**:
```bash
/data/local/tmp/uv tool upgrade --all
```

**输出**:
```
Nothing to upgrade
```

---

### 94. [✅] E10: tool list --show-paths

**输入命令**:
```bash
/data/local/tmp/uv tool list --show-paths
```

**输出**:
```
No tools installed
```

---

### 95. [✅] F1: cache prune

**输入命令**:
```bash
/data/local/tmp/uv cache prune
```

**输出**:
```
Pruning cache at: /data/local/tmp/.cache/uv
```

---

### 96. [✅] F2: cache clean

**输入命令**:
```bash
/data/local/tmp/uv cache clean
```

**输出**:
```
Clearing cache at: /data/local/tmp/.cache/uv
```

---

### 97. [✅] G1: build sdist

**输入命令**:
```bash
/data/local/tmp/uv build --sdist /data/local/tmp/test_build --out-dir /data/local/tmp/build_out
```

**输出**:
```
Building source distribution...
```

---

### 98. [✅] G2: build wheel

**输入命令**:
```bash
/data/local/tmp/uv build --wheel /data/local/tmp/test_build --out-dir /data/local/tmp/build_out
```

**输出**:
```
Building wheel...
```

---

### 99. [✅] G3: build (all)

**输入命令**:
```bash
/data/local/tmp/uv build /data/local/tmp/test_build --out-dir /data/local/tmp/build_out2
```

**输出**:
```
Building source distribution...
```

---

### 100. [✅] H1: auth login 帮助

**输入命令**:
```bash
/data/local/tmp/uv auth login --help
```

**输出**:
```
Login to a service
```

---

### 101. [✅] H2: auth logout 帮助

**输入命令**:
```bash
/data/local/tmp/uv auth logout --help
```

**输出**:
```
Logout of a service
```

---

### 102. [✅] H3: auth token 帮助

**输入命令**:
```bash
/data/local/tmp/uv auth token --help
```

**输出**:
```
Show the authentication token for a service
```

---

### 103. [⏭️] I1: workspace dir

**说明**: 项目未创建

---

### 104. [⏭️] I2: workspace list

**说明**: 项目未创建

---

### 105. [⏭️] I3: workspace metadata

**说明**: 项目未创建

---

### 106. [✅] J1: publish 帮助

**输入命令**:
```bash
/data/local/tmp/uv publish --help
```

**输出**:
```
Upload distributions to an index
```

---

### 107. [✅] B4: 卸载 Python 3.12

**输入命令**:
```bash
/data/local/tmp/uv python uninstall 3.12
```

**输出**:
```
Searching for Python versions matching: Python 3.12
```

---


*报告由 test-uv-ohos.sh 自动生成*
