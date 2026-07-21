# uv 测试报告

## 测试摘要

| 指标 | 数值 |
|------|------|
| 测试时间 | 2026-06-17 14:51:24 |
| uv 版本 | 0.11.18 |
| uv 路径 | uv |
| 超时设置 | 60s |
| 快速模式 | 否 |
| 总用例 | 107 |
| 通过 | 79 |
| 失败 | 26 |
| 跳过 | 2 |
| 通过率 | **75.2%** |

## 完整结果表格

| ID | 测试用例 | 状态 | 耗时 |
|----|---------|------|------|
| A1 | 版本号 | ✅ | 0.1s |
| A2 | 帮助信息 | ✅ | 0.1s |
| A3a | pip 帮助 | ✅ | 0.1s |
| A3b | python 帮助 | ✅ | 0.1s |
| A3c | tool 帮助 | ✅ | 0.1s |
| A3d | cache 帮助 | ✅ | 0.1s |
| A3e | venv 帮助 | ✅ | 0.1s |
| A3f | build 帮助 | ✅ | 0.1s |
| A3g | self 帮助 | ✅ | 0.1s |
| A3h | workspace 帮助 | ✅ | 0.1s |
| A3i | auth 帮助 | ✅ | 0.1s |
| A4 | cache dir | ✅ | 0.1s |
| A5 | cache size | ✅ | 0.1s |
| A6 | tool dir | ✅ | 0.1s |
| A7 | python dir | ✅ | 0.1s |
| A9 | auth dir | ✅ | 0.1s |
| A10 | self version | ✅ | 0.1s |
| A8 | pip debug | ✅ | 0.1s |
| A11 | self update --dry-run | ❌ | 0.1s |
| B1 | Python 列表 | ✅ | 0.8s |
| B2 | 检查 Python 3.12 | ✅ | 0.8s |
| B3 | 查找 Python | ❌ | 0.1s |
| B5 | Python pin | ✅ | 0.5s |
| B6 | 仅列出已安装 | ✅ | 0.8s |
| B7 | Python 列表 --all-versions | ✅ | 0.8s |
| B8 | Python 列表 JSON | ✅ | 0.8s |
| B9 | Python 重装 | ⏭️ | - |
| C1 | 创建虚拟环境 | ✅ | 0.5s |
| C10 | venv --seed | ❌ | 19.0s |
| C11 | 验证 seed | ❌ | 0.1s |
| C12 | venv --python 3.12 | ✅ | 0.5s |
| C13 | venv --clear | ❌ | 0.4s |
| C14 | venv --allow-existing | ❌ | 0.4s |
| C15 | venv --no-project | ❌ | 0.3s |
| C16 | venv --system-site-packages | ❌ | 0.4s |
| C17 | venv --prompt | ❌ | 0.3s |
| C2 | pip install requests | ✅ | 2.1s |
| C3 | pip list | ✅ | 0.5s |
| C3b | pip list JSON | ✅ | 0.5s |
| C4 | pip show requests | ✅ | 0.5s |
| C5 | pip freeze | ✅ | 0.5s |
| C6 | pip check | ✅ | 0.5s |
| C7 | pip tree | ✅ | 0.5s |
| C2b | pip install urllib3 | ✅ | 0.5s |
| C3c | pip list --outdated | ✅ | 0.8s |
| C8 | pip uninstall urllib3 | ✅ | 0.5s |
| C8b | pip uninstall requests | ✅ | 0.5s |
| C9 | pip compile | ✅ | 0.5s |
| C9b | pip sync | ✅ | 0.5s |
| C18 | pip install -r | ✅ | 0.5s |
| C19 | pip install --upgrade | ✅ | 0.8s |
| C20 | pip install --no-deps | ✅ | 0.5s |
| C21 | pip install -e | ✅ | 0.5s |
| C22 | pip uninstall -r | ✅ | 0.5s |
| D1 | init 项目 | ✅ | 0.1s |
| D2 | lock | ✅ | 31.1s |
| D3 | sync | ❌ | 0.4s |
| D4 | add 依赖 | ❌ | 0.4s |
| D5 | tree | ✅ | 0.5s |
| D5b | project version | ✅ | 0.1s |
| D4b | add --dev | ❌ | 0.4s |
| D6b | remove --dev | ❌ | 0.1s |
| D6 | remove 依赖 | ❌ | 0.1s |
| D7 | run | ❌ | 0.4s |
| D8 | export | ✅ | 0.5s |
| D7b | run --with | ❌ | 0.4s |
| D2b | lock --upgrade | ✅ | 3.2s |
| D3b | sync --frozen | ❌ | 0.4s |
| D9 | init --lib | ❌ | 0.1s |
| D10 | init --script | ✅ | 0.5s |
| D11 | add --script | ✅ | 0.5s |
| D12 | run script.py | ✅ | 0.7s |
| D13 | run -m module | ✅ | 0.7s |
| D14 | init --app | ✅ | 0.1s |
| D15 | add --optional | ❌ | 0.6s |
| D16 | add --group | ❌ | 0.6s |
| D17 | add --editable | ❌ | 0.6s |
| D18 | sync --no-dev | ❌ | 0.6s |
| D19 | export pylock.toml | ✅ | 0.4s |
| D20 | export cyclonedx1.5 | ✅ | 0.4s |
| D21 | format | ❌ | 9.4s |
| D22 | add --raw | ❌ | 0.6s |
| E1 | tool install ruff | ✅ | 12.4s |
| E2 | tool list | ✅ | 0.3s |
| E3 | tool run ruff | ❌ | 0.5s |
| E4 | tool uninstall ruff | ✅ | 0.1s |
| E5 | tool install black | ✅ | 3.7s |
| E5b | tool upgrade black | ✅ | 0.6s |
| E5c | tool uninstall black | ✅ | 0.2s |
| E6 | tool dir --bin | ✅ | 0.1s |
| E7 | tool run 指定版本 | ❌ | 10.3s |
| E8 | tool install --from | ✅ | 0.4s |
| E9 | tool upgrade --all | ✅ | 0.1s |
| E10 | tool list --show-paths | ✅ | 0.1s |
| F1 | cache prune | ✅ | 0.1s |
| F2 | cache clean | ✅ | 0.2s |
| G1 | build sdist | ✅ | 0.3s |
| G2 | build wheel | ✅ | 0.3s |
| G3 | build (all) | ✅ | 0.3s |
| H1 | auth login 帮助 | ✅ | 0.1s |
| H2 | auth logout 帮助 | ✅ | 0.1s |
| H3 | auth token 帮助 | ✅ | 0.1s |
| I1 | workspace dir | ✅ | 0.1s |
| I2 | workspace list | ✅ | 0.1s |
| I3 | workspace metadata | ✅ | 0.1s |
| J1 | publish 帮助 | ✅ | 0.1s |
| B4 | 卸载 Python | ⏭️ | - |
