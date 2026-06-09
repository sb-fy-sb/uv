# OHOS uv 功能验证测试报告

## 测试概览

| 项目 | 值 |
|------|-----|
| 测试时间 | 2026-06-03 16:51:50 |
| uv 版本 | uv 0.11.18 (501e53d52 2026-06-02 aarch64-unknown-linux-ohos) |
| 设备 | 3QC0124C03000579 |
| 总计 | 51 |
| ✅ 通过 | 42 |
| ⚠️ 部分通过 | 8 |
| ❌ 失败 | 1 |
| ⏭️ 跳过 | 0 |

## ⚠️ 部分通过的用例 (8 个)

> 命令执行成功但功能验证失败，可能表示功能在 OHOS 上存在兼容性问题

### C8: pip uninstall urllib3

**主命令**:
```bash
/data/local/tmp/uv pip uninstall urllib3 --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

**验证命令**:
```bash

```

**验证输出**:
```
(无输出)
```

---

### C8b: pip uninstall requests

**主命令**:
```bash
/data/local/tmp/uv pip uninstall requests --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

**验证命令**:
```bash

```

**验证输出**:
```
(无输出)
```

---

### C22: pip uninstall -r

**主命令**:
```bash
/data/local/tmp/uv pip uninstall -r /data/local/tmp/requirements_install.txt --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

**验证命令**:
```bash

```

**验证输出**:
```
(无输出)
```

---

### D6: remove requests

**主命令**:
```bash
/data/local/tmp/uv remove requests --project /data/local/tmp/testproj
```

**主命令输出**:
```
Resolved 1 package in 8ms
```

**验证命令**:
```bash

```

**验证输出**:
```
(无输出)
```

---

### D6b: remove --dev pytest

**主命令**:
```bash
/data/local/tmp/uv remove --dev pytest --project /data/local/tmp/testproj
```

**主命令输出**:
```
Resolved 1 package in 9ms
```

**验证命令**:
```bash

```

**验证输出**:
```
(无输出)
```

---

### E4: tool uninstall ruff

**主命令**:
```bash
/data/local/tmp/uv tool uninstall ruff
```

**主命令输出**:
```
Uninstalled 1 executable: ruff
```

**验证命令**:
```bash
UV_INDEX_URL=https://pypi.mirrors.ustc.edu.cn/simple/ UV_PYTHON_INSTALL_MIRROR=https://ghfast.top/https://github.com/indygreg/python-build-standalone/releases/download /data/local/tmp/uv tool list | grep ruff; echo $?
```

**验证输出**:
```
No tools installed
```

---

### E5c: tool uninstall black

**主命令**:
```bash
/data/local/tmp/uv tool uninstall black
```

**主命令输出**:
```
Uninstalled 2 executables: black, blackd
```

**验证命令**:
```bash
UV_INDEX_URL=https://pypi.mirrors.ustc.edu.cn/simple/ UV_PYTHON_INSTALL_MIRROR=https://ghfast.top/https://github.com/indygreg/python-build-standalone/releases/download /data/local/tmp/uv tool list | grep black; echo $?
```

**验证输出**:
```
No tools installed
```

---

### B4: 卸载 Python 3.12

**主命令**:
```bash
/data/local/tmp/uv python uninstall 3.12
```

**主命令输出**:
```
Searching for Python versions matching: Python 3.12
```

**验证命令**:
```bash

```

**验证输出**:
```
(无输出)
```

---

## ❌ 失败的用例 (1 个)

### D9: init --lib

**失败原因**: 主命令失败 (exit=2)

**输入命令**:
```bash
/data/local/tmp/uv init --lib /data/local/tmp/testproj_lib
```

**实际输出**:
```
error: Project is already initialized in `/data/local/tmp/testproj_lib` (`pyproject.toml` file exists)
```

---

## 全部测试详细记录

### 1. [✅] B2: 安装 Python 3.12

**主命令**:
```bash
/data/local/tmp/uv python install 3.12
```

**主命令输出**:
```
Installed Python 3.12.13 in 175ms
```

---

### 2. [✅] B2v: 验证 Python 3.12 可执行

**主命令**:
```bash
/data/local/tmp/uv python find 3.12
```

**主命令输出**:
```
/data/local/tmp/.local/share/uv/python/cpython-3.12-linux-aarch64-musl/bin/python3.12
```

**验证命令**:
```bash
/data/local/tmp/.local/share/uv/python/cpython-3.12-linux-aarch64-musl/bin/python3.12 -c "import sys; print(sys.version)"
```

**验证输出**:
```
3.12.13 (main, May 10 2026, 19:26:11) [Clang 22.1.3 ]
```

---

### 3. [✅] B3: 查找 Python

**主命令**:
```bash
/data/local/tmp/uv python find
```

**主命令输出**:
```
/data/local/tmp/.local/share/uv/python/cpython-3.12-linux-aarch64-musl/bin/python3.12
```

**验证命令**:
```bash
/data/local/tmp/.local/share/uv/python/cpython-3.12-linux-aarch64-musl/bin/python3.12 -c "print('hello')"
```

**验证输出**:
```
hello
```

---

### 4. [✅] B5: Python pin

**主命令**:
```bash
/data/local/tmp/uv python pin 3.12 --project /data/local/tmp
```

**主命令输出**:
```
Pinned `/data/local/tmp/.python-version` to `3.12`
```

**验证命令**:
```bash
cat /data/local/tmp/.python-version
```

**验证输出**:
```
3.12
```

---

### 5. [✅] B9: Python 重装

**主命令**:
```bash
/data/local/tmp/uv python install --reinstall 3.12
```

**主命令输出**:
```
Downloading cpython-3.12.13-linux-aarch64-musl (download) (27.2MiB)
```

---

### 6. [✅] C1: 创建虚拟环境

**主命令**:
```bash
/data/local/tmp/uv venv /data/local/tmp/testvenv
```

**主命令输出**:
```
Using CPython 3.12.13
```

---

### 7. [✅] C10: venv --seed

**主命令**:
```bash
/data/local/tmp/uv venv --seed /data/local/tmp/testvenv_seed
```

**主命令输出**:
```
Using CPython 3.12.13
```

---

### 8. [✅] C11: 验证 seed pip

**主命令**:
```bash
/data/local/tmp/uv pip list --python /data/local/tmp/testvenv_seed/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv_seed
```

---

### 9. [✅] C12: venv --python 3.12

**主命令**:
```bash
/data/local/tmp/uv venv --python 3.12 /data/local/tmp/testvenv_py
```

**主命令输出**:
```
Using CPython 3.12.13
```

---

### 10. [✅] C13: venv --clear

**主命令**:
```bash
/data/local/tmp/uv venv --clear /data/local/tmp/testvenv
```

**主命令输出**:
```
Using CPython 3.12.13
```

---

### 11. [✅] C14: venv --allow-existing

**主命令**:
```bash
/data/local/tmp/uv venv --allow-existing /data/local/tmp/testvenv
```

**主命令输出**:
```
Using CPython 3.12.13
```

---

### 12. [✅] C15: venv --no-project

**主命令**:
```bash
/data/local/tmp/uv venv --no-project /data/local/tmp/testvenv2
```

**主命令输出**:
```
Using CPython 3.12.13
```

---

### 13. [✅] C16: venv --system-site-packages

**主命令**:
```bash
/data/local/tmp/uv venv --system-site-packages /data/local/tmp/testvenv_sys
```

**主命令输出**:
```
Using CPython 3.12.13
```

---

### 14. [✅] C17: venv --prompt

**主命令**:
```bash
/data/local/tmp/uv venv --prompt myenv /data/local/tmp/testvenv_prompt
```

**主命令输出**:
```
Using CPython 3.12.13
```

---

### 15. [✅] C2: pip install requests

**主命令**:
```bash
/data/local/tmp/uv pip install requests --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 16. [✅] C3: pip list

**主命令**:
```bash
/data/local/tmp/uv pip list --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 17. [✅] C2b: pip install urllib3

**主命令**:
```bash
/data/local/tmp/uv pip install urllib3 --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 18. [⚠️] C8: pip uninstall urllib3

**说明**: 功能验证失败 (v_exit=0)

**主命令**:
```bash
/data/local/tmp/uv pip uninstall urllib3 --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 19. [⚠️] C8b: pip uninstall requests

**说明**: 功能验证失败 (v_exit=0)

**主命令**:
```bash
/data/local/tmp/uv pip uninstall requests --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 20. [✅] C9: pip compile

**主命令**:
```bash
/data/local/tmp/uv pip compile /data/local/tmp/requirements.in -o /data/local/tmp/requirements.txt
```

**主命令输出**:
```
Resolved 5 packages in 10ms
```

---

### 21. [✅] C9b: pip sync

**主命令**:
```bash
/data/local/tmp/uv pip sync /data/local/tmp/requirements.txt --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 22. [✅] C18: pip install -r

**主命令**:
```bash
/data/local/tmp/uv pip install -r /data/local/tmp/requirements_install.txt --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 23. [✅] C19: pip install --upgrade

**主命令**:
```bash
/data/local/tmp/uv pip install --upgrade requests --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 24. [✅] C20: pip install --no-deps

**主命令**:
```bash
/data/local/tmp/uv pip install --no-deps idna --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 25. [✅] C21: pip install -e (editable)

**主命令**:
```bash
/data/local/tmp/uv pip install -e /data/local/tmp/testproj_lib --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 26. [⚠️] C22: pip uninstall -r

**说明**: 功能验证失败 (v_exit=0)

**主命令**:
```bash
/data/local/tmp/uv pip uninstall -r /data/local/tmp/requirements_install.txt --python /data/local/tmp/testvenv/bin/python
```

**主命令输出**:
```
Using Python 3.12.13 environment at: /data/local/tmp/testvenv
```

---

### 27. [✅] D1: init 项目

**主命令**:
```bash
/data/local/tmp/uv init /data/local/tmp/testproj
```

**主命令输出**:
```
Initialized project `testproj` at `/data/local/tmp/testproj`
```

**验证命令**:
```bash
ls /data/local/tmp/testproj/pyproject.toml
```

**验证输出**:
```
/data/local/tmp/testproj/pyproject.toml
```

---

### 28. [✅] D2: lock

**主命令**:
```bash
/data/local/tmp/uv lock --project /data/local/tmp/testproj
```

**主命令输出**:
```
Using CPython 3.12.13
```

---

### 29. [✅] D4: add requests

**主命令**:
```bash
/data/local/tmp/uv add requests --project /data/local/tmp/testproj
```

**主命令输出**:
```
warning: Indexes specified via `--index-url` will not be persisted to the `pyproject.toml` file; use `--default-index` instead.
```

---

### 30. [⚠️] D6: remove requests

**说明**: 功能验证失败 (v_exit=0)

**主命令**:
```bash
/data/local/tmp/uv remove requests --project /data/local/tmp/testproj
```

**主命令输出**:
```
Resolved 1 package in 8ms
```

---

### 31. [✅] D4b: add --dev pytest

**主命令**:
```bash
/data/local/tmp/uv add --dev pytest --project /data/local/tmp/testproj
```

**主命令输出**:
```
warning: Indexes specified via `--index-url` will not be persisted to the `pyproject.toml` file; use `--default-index` instead.
```

---

### 32. [⚠️] D6b: remove --dev pytest

**说明**: 功能验证失败 (v_exit=0)

**主命令**:
```bash
/data/local/tmp/uv remove --dev pytest --project /data/local/tmp/testproj
```

**主命令输出**:
```
Resolved 1 package in 9ms
```

---

### 33. [✅] D5: tree

**主命令**:
```bash
/data/local/tmp/uv add requests --project /data/local/tmp/testproj
```

**主命令输出**:
```
warning: Indexes specified via `--index-url` will not be persisted to the `pyproject.toml` file; use `--default-index` instead.
```

---

### 34. [✅] D5b: version

**主命令**:
```bash
/data/local/tmp/uv version --project /data/local/tmp/testproj
```

**主命令输出**:
```
testproj 0.1.0
```

**验证命令**:
```bash
UV_INDEX_URL=https://pypi.mirrors.ustc.edu.cn/simple/ UV_PYTHON_INSTALL_MIRROR=https://ghfast.top/https://github.com/indygreg/python-build-standalone/releases/download /data/local/tmp/uv version --project /data/local/tmp/testproj
```

**验证输出**:
```
testproj 0.1.0
```

---

### 35. [✅] D7: run

**主命令**:
```bash
/data/local/tmp/uv run --project /data/local/tmp/testproj python -c "print('hello from ohos')"
```

**主命令输出**:
```
hello from ohos
```

---

### 36. [✅] D7b: run --with

**主命令**:
```bash
/data/local/tmp/uv run --with requests --project /data/local/tmp/testproj python -c "import requests; print(requests.__version__)"
```

**主命令输出**:
```
2.34.2
```

---

### 37. [❌] D9: init --lib

**说明**: 主命令失败 (exit=2)

**主命令**:
```bash
/data/local/tmp/uv init --lib /data/local/tmp/testproj_lib
```

**主命令输出**:
```
error: Project is already initialized in `/data/local/tmp/testproj_lib` (`pyproject.toml` file exists)
```

---

### 38. [✅] D10: init --script

**主命令**:
```bash
/data/local/tmp/uv init --script /data/local/tmp/test_script.py
```

**主命令输出**:
```
Initialized script at `/data/local/tmp/test_script.py`
```

**验证命令**:
```bash
head -5 /data/local/tmp/test_script.py
```

**验证输出**:
```
# /// script
```

---

### 39. [✅] D11: add --script

**主命令**:
```bash
/data/local/tmp/uv add --script /data/local/tmp/test_script.py requests
```

**主命令输出**:
```
warning: Indexes specified via `--index-url` will not be persisted to the script; use `--default-index` instead.
```

---

### 40. [✅] D14: init --app

**主命令**:
```bash
/data/local/tmp/uv init --app /data/local/tmp/testproj_app
```

**主命令输出**:
```
Initialized project `testproj-app` at `/data/local/tmp/testproj_app`
```

**验证命令**:
```bash
ls /data/local/tmp/testproj_app/pyproject.toml
```

**验证输出**:
```
/data/local/tmp/testproj_app/pyproject.toml
```

---

### 41. [✅] D15: add --optional

**主命令**:
```bash
/data/local/tmp/uv add --optional web flask --project /data/local/tmp/testproj
```

**主命令输出**:
```
warning: Indexes specified via `--index-url` will not be persisted to the `pyproject.toml` file; use `--default-index` instead.
```

---

### 42. [✅] D17: add --editable

**主命令**:
```bash
/data/local/tmp/uv add --editable /data/local/tmp/testproj_lib --project /data/local/tmp/testproj
```

**主命令输出**:
```
warning: Indexes specified via `--index-url` will not be persisted to the `pyproject.toml` file; use `--default-index` instead.
```

---

### 43. [✅] E1: tool install ruff

**主命令**:
```bash
/data/local/tmp/uv tool install ruff
```

**主命令输出**:
```
Resolved 1 package in 22.28s
```

---

### 44. [✅] E2: tool list

**主命令**:
```bash
/data/local/tmp/uv tool list
```

**主命令输出**:
```
ruff v0.15.15
```

---

### 45. [⚠️] E4: tool uninstall ruff

**说明**: 功能验证失败 (v_exit=0)

**主命令**:
```bash
/data/local/tmp/uv tool uninstall ruff
```

**主命令输出**:
```
Uninstalled 1 executable: ruff
```

**验证命令**:
```bash
UV_INDEX_URL=https://pypi.mirrors.ustc.edu.cn/simple/ UV_PYTHON_INSTALL_MIRROR=https://ghfast.top/https://github.com/indygreg/python-build-standalone/releases/download /data/local/tmp/uv tool list | grep ruff; echo $?
```

**验证输出**:
```
No tools installed
```

---

### 46. [✅] E5: tool install black

**主命令**:
```bash
/data/local/tmp/uv tool install black
```

**主命令输出**:
```
Resolved 7 packages in 39.58s
```

---

### 47. [⚠️] E5c: tool uninstall black

**说明**: 功能验证失败 (v_exit=0)

**主命令**:
```bash
/data/local/tmp/uv tool uninstall black
```

**主命令输出**:
```
Uninstalled 2 executables: black, blackd
```

**验证命令**:
```bash
UV_INDEX_URL=https://pypi.mirrors.ustc.edu.cn/simple/ UV_PYTHON_INSTALL_MIRROR=https://ghfast.top/https://github.com/indygreg/python-build-standalone/releases/download /data/local/tmp/uv tool list | grep black; echo $?
```

**验证输出**:
```
No tools installed
```

---

### 48. [✅] G1: build sdist

**主命令**:
```bash
/data/local/tmp/uv build --sdist /data/local/tmp/test_build --out-dir /data/local/tmp/build_out
```

**主命令输出**:
```
Building source distribution...
```

---

### 49. [✅] G2: build wheel

**主命令**:
```bash
/data/local/tmp/uv build --wheel /data/local/tmp/test_build --out-dir /data/local/tmp/build_out
```

**主命令输出**:
```
Building wheel...
```

---

### 50. [✅] G3: build (all)

**主命令**:
```bash
/data/local/tmp/uv build /data/local/tmp/test_build --out-dir /data/local/tmp/build_out2
```

**主命令输出**:
```
Building source distribution...
```

---

### 51. [⚠️] B4: 卸载 Python 3.12

**说明**: 功能验证失败 (v_exit=0)

**主命令**:
```bash
/data/local/tmp/uv python uninstall 3.12
```

**主命令输出**:
```
Searching for Python versions matching: Python 3.12
```

---


*报告由 verify-uv-ohos.sh 自动生成*
