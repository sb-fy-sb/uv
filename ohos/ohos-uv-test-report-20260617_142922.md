# uv 测试报告

## 测试摘要

| 指标 | 数值 |
|------|------|
| 测试时间 | 2026-06-17 14:29:22 |
| uv 版本 | 0.11.18 |
| uv 路径 | uv |
| 超时设置 | 60s |
| 快速模式 | 否 |
| 总用例 | 107 |
| 通过 | 72 |
| 失败 | 7 |
| 跳过 | 28 |
| 通过率 | **91.1%** |

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
| B1 | Python 列表 | ✅ | 0.6s |
| B2 | 检查 Python 3.12 | ✅ | 0.6s |
| B3 | 查找 Python | ❌ | 0.4s |
| B5 | Python pin | ❌ | 0.3s |
| B6 | 仅列出已安装 | ✅ | 0.6s |
| B7 | Python 列表 --all-versions | ✅ | 0.6s |
| B8 | Python 列表 JSON | ✅ | 0.6s |
| B9 | Python 重装 | ⏭️ | - |
| C1 | 创建虚拟环境 | ❌ | 0.4s |
| C10 |  | ⏭️ | - |
| C11 |  | ⏭️ | - |
| C12 |  | ⏭️ | - |
| C13 |  | ⏭️ | - |
| C14 |  | ⏭️ | - |
| C15 |  | ⏭️ | - |
| C16 |  | ⏭️ | - |
| C17 |  | ⏭️ | - |
| C2 |  | ⏭️ | - |
| C3 |  | ⏭️ | - |
| C3b |  | ⏭️ | - |
| C4 |  | ⏭️ | - |
| C5 |  | ⏭️ | - |
| C6 |  | ⏭️ | - |
| C7 |  | ⏭️ | - |
| C2b |  | ⏭️ | - |
| C3c |  | ⏭️ | - |
| C8 |  | ⏭️ | - |
| C8b |  | ⏭️ | - |
| C9 |  | ⏭️ | - |
| C9b |  | ⏭️ | - |
| C18 |  | ⏭️ | - |
| C19 |  | ⏭️ | - |
| C20 |  | ⏭️ | - |
| C21 |  | ⏭️ | - |
| C22 |  | ⏭️ | - |
| D1 | init 项目 | ✅ | 0.1s |
| D2 | lock | ✅ | 0.3s |
| D3 | sync | ✅ | 0.4s |
| D4 | add 依赖 | ✅ | 4.6s |
| D5 | tree | ✅ | 0.3s |
| D5b | project version | ✅ | 0.1s |
| D4b | add --dev | ✅ | 4.5s |
| D6b | remove --dev | ✅ | 0.4s |
| D6 | remove 依赖 | ✅ | 0.3s |
| D7 | run | ✅ | 0.4s |
| D8 | export | ✅ | 0.3s |
| D7b | run --with | ✅ | 2.2s |
| D2b | lock --upgrade | ✅ | 0.3s |
| D3b | sync --frozen | ✅ | 0.3s |
| D9 | init --lib | ✅ | 0.1s |
| D10 | init --script | ✅ | 0.3s |
| D11 | add --script | ✅ | 0.3s |
| D12 | run script.py | ✅ | 0.4s |
| D13 | run -m module | ✅ | 0.4s |
| D14 | init --app | ✅ | 0.1s |
| D15 | add --optional | ✅ | 2.1s |
| D16 | add --group | ✅ | 17.4s |
| D17 | add --editable | ✅ | 0.3s |
| D18 | sync --no-dev | ✅ | 0.4s |
| D19 | export pylock.toml | ✅ | 0.3s |
| D20 | export cyclonedx1.5 | ✅ | 0.3s |
| D21 | format | ❌ | 13.2s |
| D22 | add --raw | ✅ | 2.3s |
| E1 | tool install ruff | ✅ | 11.6s |
| E2 | tool list | ✅ | 0.3s |
| E3 | tool run ruff | ❌ | 0.4s |
| E4 | tool uninstall ruff | ✅ | 0.1s |
| E5 | tool install black | ✅ | 3.0s |
| E5b | tool upgrade black | ✅ | 0.6s |
| E5c | tool uninstall black | ✅ | 0.2s |
| E6 | tool dir --bin | ✅ | 0.1s |
| E7 | tool run 指定版本 | ❌ | 11.2s |
| E8 | tool install --from | ✅ | 0.3s |
| E9 | tool upgrade --all | ✅ | 0.1s |
| E10 | tool list --show-paths | ✅ | 0.1s |
| F1 | cache prune | ✅ | 0.1s |
| F2 | cache clean | ✅ | 0.2s |
| G1 | build sdist | ✅ | 0.2s |
| G2 | build wheel | ✅ | 0.2s |
| G3 | build (all) | ✅ | 0.2s |
| H1 | auth login 帮助 | ✅ | 0.1s |
| H2 | auth logout 帮助 | ✅ | 0.1s |
| H3 | auth token 帮助 | ✅ | 0.1s |
| I1 | workspace dir | ✅ | 0.1s |
| I2 | workspace list | ✅ | 0.1s |
| I3 | workspace metadata | ✅ | 0.1s |
| J1 | publish 帮助 | ✅ | 0.1s |
| B4 | 卸载 Python | ⏭️ | - |
