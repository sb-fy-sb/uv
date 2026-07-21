## 1. 功能验证测试设计文档

- [x] 1.1 创建 `ohos/OHOS_uv_功能验证测试设计文档.md`，包含：测试概述、预置条件、验证用例清单（含每个用例的主命令、验证命令、预期输出）、执行流程、报告格式说明
- [x] 1.2 编写 Group B（Python 管理）5 个验证用例的详细验证命令和预期匹配模式
- [x] 1.3 编写 Group C（虚拟环境 + pip）16 个验证用例的详细验证命令和预期匹配模式
- [x] 1.4 编写 Group D（项目管理）14 个验证用例的详细验证命令和预期匹配模式
- [x] 1.5 编写 Group E（Tool 管理）5 个验证用例的详细验证命令和预期匹配模式
- [x] 1.6 编写 Group G（Build）3 个验证用例的详细验证命令和预期匹配模式

## 2. 验证脚本基础框架

- [x] 2.1 创建 `ohos/verify-uv-ohos.sh` 脚本框架：参数解析（--uv-path、--hdc、--timeout）、MSYS2 路径处理、统计变量、RESULTS 数组
- [x] 2.2 实现 `run_verify` 核心函数：执行主命令 → 检查退出码 → 执行验证命令 → 判定 PASS/PARTIAL/FAIL
- [x] 2.3 实现 `skip_verify` 跳过函数和 `log_partial` 日志输出（黄色 ⚠️ 标记）
- [x] 2.4 实现前置检查：hdc 连接检查、uv 可用性检查、环境清理

## 3. 验证脚本环境准备

- [x] 3.1 实现 Group B 环境准备：安装 Python 3.12、记录安装路径
- [x] 3.2 实现 Group C 环境准备：创建 testvenv、testvenv_seed、testproj_lib（editable 测试用）
- [x] 3.3 实现 Group D 环境准备：init 项目、init --lib、init --script
- [x] 3.4 实现 Group G 环境准备：创建 test_build 项目（setuptools 构建）

## 4. 验证脚本各组实现

- [x] 4.1 实现 Group B 验证：B2（Python 可执行）、B3（find 路径可用）、B5（pin 文件验证）、B9（重装后可执行）、B4（卸载后不可执行）
- [x] 4.2 实现 Group C 验证：C1（venv Python 可用）、C10/C11（seed venv pip 可用）、C2/C3（import requests）、C8/C8b（uninstall 后 import 失败）、C21（editable 路径验证）、C22（批量卸载验证）等
- [x] 4.3 实现 Group D 验证：D1（pyproject.toml 存在）、D2（uv.lock 存在）、D4/D6（依赖增删 pyproject.toml 变化）、D10/D11（PEP 723 metadata）、D17（editable 依赖写入）等
- [x] 4.4 实现 Group E 验证：E1（ruff 可执行）、E2（tool list 包含 ruff）、E4（uninstall 后不在列表）、E5（black 可执行）
- [x] 4.5 实现 Group G 验证：G1（sdist tar 包含 pyproject.toml）、G2（wheel 可安装且可 import）、G3（两种格式产物都存在）

## 5. 验证脚本清理与报告

- [x] 5.1 实现测试清理：卸载 Python 3.12、删除所有测试目录
- [x] 5.2 实现 Markdown 报告生成：包含 PASS/PARTIAL/FAIL/SKIP 统计、PARTIAL 用例诊断详情（主命令输出 + 验证命令 + 验证输出）、全部用例详细记录
- [x] 5.3 实现终端摘要输出和退出码逻辑（有 FAIL 或 PARTIAL 时返回非 0）
