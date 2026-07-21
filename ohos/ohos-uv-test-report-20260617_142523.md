# uv 测试报告

## 测试摘要

| 指标 | 数值 |
|------|------|
| 测试时间 | 2026-06-17 14:25:23 |
| uv 版本 | 0.11.18 |
| uv 路径 | uv |
| 超时设置 | 60s |
| 快速模式 | 否 |
| 总用例 | 107 |
| 通过 | 40 |
| 失败 | 9 |
| 跳过 | 58 |
| 通过率 | **81.6%** |

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
| B3 | 查找 Python | ✅ | 0.3s |
| B5 | Python pin | ❌ | 0.3s |
| B6 | 仅列出已安装 | ✅ | 0.6s |
| B7 | Python 列表 --all-versions | ✅ | 0.6s |
| B8 | Python 列表 JSON | ✅ | 0.6s |
| B9 | Python 重装 | ⏭️ | - |
| C1 | 创建虚拟环境 | ❌ | 0.2s |
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
| D1 | init 项目 | ❌ | 0.3s |
| D2 |  | ⏭️ | - |
| D3 |  | ⏭️ | - |
| D4 |  | ⏭️ | - |
| D5 |  | ⏭️ | - |
| D5b |  | ⏭️ | - |
| D4b |  | ⏭️ | - |
| D6b |  | ⏭️ | - |
| D6 |  | ⏭️ | - |
| D7 |  | ⏭️ | - |
| D8 |  | ⏭️ | - |
| D7b |  | ⏭️ | - |
| D2b |  | ⏭️ | - |
| D3b |  | ⏭️ | - |
| D9 |  | ⏭️ | - |
| D10 |  | ⏭️ | - |
| D11 |  | ⏭️ | - |
| D12 |  | ⏭️ | - |
| D13 |  | ⏭️ | - |
| D14 |  | ⏭️ | - |
| D15 |  | ⏭️ | - |
| D16 |  | ⏭️ | - |
| D17 |  | ⏭️ | - |
| D18 |  | ⏭️ | - |
| D19 |  | ⏭️ | - |
| D20 |  | ⏭️ | - |
| D21 |  | ⏭️ | - |
| D22 |  | ⏭️ | - |
| E1 | tool install ruff | ✅ | 2.9s |
| E2 | tool list | ✅ | 0.3s |
| E3 | tool run ruff | ❌ | 0.4s |
| E4 | tool uninstall ruff | ✅ | 0.1s |
| E5 | tool install black | ✅ | 0.8s |
| E5b | tool upgrade black | ✅ | 0.6s |
| E5c | tool uninstall black | ✅ | 0.2s |
| E6 | tool dir --bin | ✅ | 0.1s |
| E7 | tool run 指定版本 | ❌ | 1.3s |
| E8 | tool install --from | ✅ | 0.4s |
| E9 | tool upgrade --all | ✅ | 0.1s |
| E10 | tool list --show-paths | ✅ | 0.1s |
| F1 | cache prune | ✅ | 0.1s |
| F2 | cache clean | ✅ | 0.2s |
| G1 | build sdist | ❌ | 0.1s |
| G2 | build wheel | ❌ | 0.1s |
| G3 | build (all) | ❌ | 0.1s |
| H1 | auth login 帮助 | ✅ | 0.1s |
| H2 | auth logout 帮助 | ✅ | 0.1s |
| H3 | auth token 帮助 | ✅ | 0.1s |
| I1 |  | ⏭️ | - |
| I2 |  | ⏭️ | - |
| I3 |  | ⏭️ | - |
| J1 | publish 帮助 | ✅ | 0.1s |
| B4 | 卸载 Python | ⏭️ | - |
