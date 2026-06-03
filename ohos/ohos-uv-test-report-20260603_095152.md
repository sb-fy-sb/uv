# OHOS uv 功能验证测试报告

## 测试概览

| 项目 | 值 |
|------|-----|
| 测试时间 | 2026-06-03 09:52:22 |
| uv 版本 | uv 0.11.18 (501e53d52 2026-06-02 aarch64-unknown-linux-ohos) |
| 设备 | 3QC0124C03000579 |
| 总计 | 100 |
| 通过 | 37 |
| 失败 | 2 |
| 跳过 | 61 |

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

### B2: 安装 Python 3.12

**失败原因**: 退出码不匹配 (期望=0, 实际=2)

**输入命令**:
```bash
/data/local/tmp/uv python install 3.12
```

**实际输出**:
```
error: Python installation is missing a `_sysconfigdata_` file
```

---

## ⏭️ 跳过的用例 (61 个)

| ID | 测试用例 | 跳过原因 |
|----|---------|---------|
| C1 | 创建虚拟环境 | Python 未安装 |
| C10 | venv --seed | Python 未安装 |
| C11 | 验证 seed | Python 未安装 |
| C12 | venv --python | Python 未安装 |
| C13 | venv --clear | Python 未安装 |
| C14 | venv --allow-existing | Python 未安装 |
| C15 | venv --no-project | Python 未安装 |
| C16 | venv --system-site-packages | Python 未安装 |
| C17 | venv --prompt | Python 未安装 |
| C2 | pip install | Python 未安装 |
| C3 | pip list | Python 未安装 |
| C3b | pip list json | Python 未安装 |
| C4 | pip show | Python 未安装 |
| C5 | pip freeze | Python 未安装 |
| C6 | pip check | Python 未安装 |
| C7 | pip tree | Python 未安装 |
| C2b | pip install urllib3 | Python 未安装 |
| C3c | pip list --outdated | Python 未安装 |
| C8 | pip uninstall urllib3 | Python 未安装 |
| C8b | pip uninstall requests | Python 未安装 |
| C9 | pip compile | Python 未安装 |
| C9b | pip sync | Python 未安装 |
| C18 | pip install -r | Python 未安装 |
| C19 | pip install --upgrade | Python 未安装 |
| C20 | pip install --no-deps | Python 未安装 |
| C21 | pip install -e | Python 未安装 |
| C22 | pip uninstall -r | Python 未安装 |
| D1 | init | Python 未安装 |
| D2 | lock | Python 未安装 |
| D3 | sync | Python 未安装 |
| D4 | add | Python 未安装 |
| D5 | tree | Python 未安装 |
| D5b | version | Python 未安装 |
| D4b | add --dev | Python 未安装 |
| D6b | remove --dev | Python 未安装 |
| D6 | remove | Python 未安装 |
| D7 | run | Python 未安装 |
| D8 | export | Python 未安装 |
| D7b | run --with | Python 未安装 |
| D2b | lock --upgrade | Python 未安装 |
| D3b | sync --frozen | Python 未安装 |
| D9 | init --lib | Python 未安装 |
| D10 | init --script | Python 未安装 |
| D11 | add --script | Python 未安装 |
| D12 | run script | Python 未安装 |
| D13 | run -m | Python 未安装 |
| D14 | init --app | Python 未安装 |
| D15 | add --optional | Python 未安装 |
| D16 | add --group | Python 未安装 |
| D17 | add --editable | Python 未安装 |
| D18 | sync --no-dev | Python 未安装 |
| D19 | export pylock | Python 未安装 |
| D20 | export cyclonedx | Python 未安装 |
| D21 | format | Python 未安装 |
| D22 | add --raw | Python 未安装 |
| G1 | build sdist | Python 未安装 |
| G2 | build wheel | Python 未安装 |
| G3 | build all | Python 未安装 |
| I1 | workspace dir | 项目未创建 |
| I2 | workspace list | 项目未创建 |
| I3 | workspace metadata | 项目未创建 |

## ✅ 通过的用例 (37 个)

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
| H1 | auth login 帮助 |
| H2 | auth logout 帮助 |
| H3 | auth token 帮助 |
| J1 | publish 帮助 |

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

### 21. [❌] B2: 安装 Python 3.12

**说明**: 退出码不匹配 (期望=0, 实际=2)

**输入命令**:
```bash
/data/local/tmp/uv python install 3.12
```

**输出**:
```
error: Python installation is missing a `_sysconfigdata_` file
```

---

### 22. [⏭️] C1: 创建虚拟环境

**说明**: Python 未安装

---

### 23. [⏭️] C10: venv --seed

**说明**: Python 未安装

---

### 24. [⏭️] C11: 验证 seed

**说明**: Python 未安装

---

### 25. [⏭️] C12: venv --python

**说明**: Python 未安装

---

### 26. [⏭️] C13: venv --clear

**说明**: Python 未安装

---

### 27. [⏭️] C14: venv --allow-existing

**说明**: Python 未安装

---

### 28. [⏭️] C15: venv --no-project

**说明**: Python 未安装

---

### 29. [⏭️] C16: venv --system-site-packages

**说明**: Python 未安装

---

### 30. [⏭️] C17: venv --prompt

**说明**: Python 未安装

---

### 31. [⏭️] C2: pip install

**说明**: Python 未安装

---

### 32. [⏭️] C3: pip list

**说明**: Python 未安装

---

### 33. [⏭️] C3b: pip list json

**说明**: Python 未安装

---

### 34. [⏭️] C4: pip show

**说明**: Python 未安装

---

### 35. [⏭️] C5: pip freeze

**说明**: Python 未安装

---

### 36. [⏭️] C6: pip check

**说明**: Python 未安装

---

### 37. [⏭️] C7: pip tree

**说明**: Python 未安装

---

### 38. [⏭️] C2b: pip install urllib3

**说明**: Python 未安装

---

### 39. [⏭️] C3c: pip list --outdated

**说明**: Python 未安装

---

### 40. [⏭️] C8: pip uninstall urllib3

**说明**: Python 未安装

---

### 41. [⏭️] C8b: pip uninstall requests

**说明**: Python 未安装

---

### 42. [⏭️] C9: pip compile

**说明**: Python 未安装

---

### 43. [⏭️] C9b: pip sync

**说明**: Python 未安装

---

### 44. [⏭️] C18: pip install -r

**说明**: Python 未安装

---

### 45. [⏭️] C19: pip install --upgrade

**说明**: Python 未安装

---

### 46. [⏭️] C20: pip install --no-deps

**说明**: Python 未安装

---

### 47. [⏭️] C21: pip install -e

**说明**: Python 未安装

---

### 48. [⏭️] C22: pip uninstall -r

**说明**: Python 未安装

---

### 49. [⏭️] D1: init

**说明**: Python 未安装

---

### 50. [⏭️] D2: lock

**说明**: Python 未安装

---

### 51. [⏭️] D3: sync

**说明**: Python 未安装

---

### 52. [⏭️] D4: add

**说明**: Python 未安装

---

### 53. [⏭️] D5: tree

**说明**: Python 未安装

---

### 54. [⏭️] D5b: version

**说明**: Python 未安装

---

### 55. [⏭️] D4b: add --dev

**说明**: Python 未安装

---

### 56. [⏭️] D6b: remove --dev

**说明**: Python 未安装

---

### 57. [⏭️] D6: remove

**说明**: Python 未安装

---

### 58. [⏭️] D7: run

**说明**: Python 未安装

---

### 59. [⏭️] D8: export

**说明**: Python 未安装

---

### 60. [⏭️] D7b: run --with

**说明**: Python 未安装

---

### 61. [⏭️] D2b: lock --upgrade

**说明**: Python 未安装

---

### 62. [⏭️] D3b: sync --frozen

**说明**: Python 未安装

---

### 63. [⏭️] D9: init --lib

**说明**: Python 未安装

---

### 64. [⏭️] D10: init --script

**说明**: Python 未安装

---

### 65. [⏭️] D11: add --script

**说明**: Python 未安装

---

### 66. [⏭️] D12: run script

**说明**: Python 未安装

---

### 67. [⏭️] D13: run -m

**说明**: Python 未安装

---

### 68. [⏭️] D14: init --app

**说明**: Python 未安装

---

### 69. [⏭️] D15: add --optional

**说明**: Python 未安装

---

### 70. [⏭️] D16: add --group

**说明**: Python 未安装

---

### 71. [⏭️] D17: add --editable

**说明**: Python 未安装

---

### 72. [⏭️] D18: sync --no-dev

**说明**: Python 未安装

---

### 73. [⏭️] D19: export pylock

**说明**: Python 未安装

---

### 74. [⏭️] D20: export cyclonedx

**说明**: Python 未安装

---

### 75. [⏭️] D21: format

**说明**: Python 未安装

---

### 76. [⏭️] D22: add --raw

**说明**: Python 未安装

---

### 77. [✅] E1: tool install ruff

**输入命令**:
```bash
/data/local/tmp/uv tool install ruff
```

**输出**:
```
Resolved 1 package in 1.44s
```

---

### 78. [✅] E2: tool list

**输入命令**:
```bash
/data/local/tmp/uv tool list
```

**输出**:
```
ruff v0.15.15
```

---

### 79. [✅] E3: tool run ruff

**输入命令**:
```bash
/data/local/tmp/uv tool run ruff --version
```

**输出**:
```
ruff 0.15.15
```

---

### 80. [✅] E4: tool uninstall ruff

**输入命令**:
```bash
/data/local/tmp/uv tool uninstall ruff
```

**输出**:
```
Uninstalled 1 executable: ruff
```

---

### 81. [✅] E5: tool install black

**输入命令**:
```bash
/data/local/tmp/uv tool install black
```

**输出**:
```
Resolved 7 packages in 920ms
```

---

### 82. [✅] E5b: tool upgrade black

**输入命令**:
```bash
/data/local/tmp/uv tool upgrade black
```

**输出**:
```
Nothing to upgrade
```

---

### 83. [✅] E5c: tool uninstall black

**输入命令**:
```bash
/data/local/tmp/uv tool uninstall black
```

**输出**:
```
Uninstalled 2 executables: black, blackd
```

---

### 84. [✅] E6: tool dir --bin

**输入命令**:
```bash
/data/local/tmp/uv tool dir --bin
```

**输出**:
```
/data/local/tmp/.local/bin
```

---

### 85. [✅] E7: tool run 指定版本

**输入命令**:
```bash
/data/local/tmp/uv tool run ruff@0.3.0 --version
```

**输出**:
```
Downloading ruff (6.9MiB)
```

---

### 86. [✅] E8: tool install --from

**输入命令**:
```bash
/data/local/tmp/uv tool install --from ruff ruff
```

**输出**:
```
Resolved 1 package in 18ms
```

---

### 87. [✅] E9: tool upgrade --all

**输入命令**:
```bash
/data/local/tmp/uv tool upgrade --all
```

**输出**:
```
Nothing to upgrade
```

---

### 88. [✅] E10: tool list --show-paths

**输入命令**:
```bash
/data/local/tmp/uv tool list --show-paths
```

**输出**:
```
No tools installed
```

---

### 89. [✅] F1: cache prune

**输入命令**:
```bash
/data/local/tmp/uv cache prune
```

**输出**:
```
Pruning cache at: /data/local/tmp/.cache/uv
```

---

### 90. [✅] F2: cache clean

**输入命令**:
```bash
/data/local/tmp/uv cache clean
```

**输出**:
```
Clearing cache at: /data/local/tmp/.cache/uv
```

---

### 91. [⏭️] G1: build sdist

**说明**: Python 未安装

---

### 92. [⏭️] G2: build wheel

**说明**: Python 未安装

---

### 93. [⏭️] G3: build all

**说明**: Python 未安装

---

### 94. [✅] H1: auth login 帮助

**输入命令**:
```bash
/data/local/tmp/uv auth login --help
```

**输出**:
```
Login to a service
```

---

### 95. [✅] H2: auth logout 帮助

**输入命令**:
```bash
/data/local/tmp/uv auth logout --help
```

**输出**:
```
Logout of a service
```

---

### 96. [✅] H3: auth token 帮助

**输入命令**:
```bash
/data/local/tmp/uv auth token --help
```

**输出**:
```
Show the authentication token for a service
```

---

### 97. [⏭️] I1: workspace dir

**说明**: 项目未创建

---

### 98. [⏭️] I2: workspace list

**说明**: 项目未创建

---

### 99. [⏭️] I3: workspace metadata

**说明**: 项目未创建

---

### 100. [✅] J1: publish 帮助

**输入命令**:
```bash
/data/local/tmp/uv publish --help
```

**输出**:
```
Upload distributions to an index
```

---


*报告由 test-uv-ohos.sh 自动生成*
