## Context

sb-fy-sb/uv 是 astral-sh/uv（Python 包和项目管理工具）的 fork，已完成 OpenHarmony (OHOS) aarch64 平台的全面适配：

1. **代码适配**（已完成）：
   - OHOS 平台默认存储路径重定向（HOME → uv 可执行文件所在目录）
   - PEP 517 构建后端平台兼容性桩（sysconfig.get_platform harmonyos → linux）
   - UV_LIBC=musl 预设、Python 安装路径重定向到 /data/local/tmp

2. **CI/CD 流水线**（已完成）：
   - `.github/workflows/ohos-build.yml`：Windows 自托管 Runner 上交叉编译 OHOS aarch64 二进制
   - 支持 push 触发和手动触发，含 ELF 产物验证和 Artifacts 上传

3. **功能测试**（已完成）：
   - 107 个测试用例，106 个通过（99.1% 通过率）
   - 含功能验证测试脚本 verify-uv-ohos.sh

当前仓库 README 仍为上游 uv 原始内容，OHOS 用户无法快速了解该 fork 的移植价值和使用方法。

参考项目：OpenHarmonyPCDeveloper/rust（Rust 工具链 OHOS PC 移植），该项目 README 采用中文编写，包含项目简介、版本信息、构建状态、适配内容、使用方法等标准章节。

## Goals / Non-Goals

**Goals:**
- 编写一份完整的中文 README_OHOS.md，面向 OHOS 用户和开发者
- 包含 CI/CD 流水线状态徽章（GitHub Actions workflow badge）
- 清晰展示 OHOS 平台适配改动摘要
- 提供从源码构建和部署到设备的完整指南
- 展示测试结果统计数据

**Non-Goals:**
- 不替换上游 uv 的原始 README.md（使用独立的 README_OHOS.md）
- 不翻译上游 README 的内容
- 不包含上游 uv 的全部功能介绍（仅概述 + 链接到上游）
- 不编写英文版本（初期仅中文）

## Decisions

### Decision 1: 文件命名 — README_OHOS.md

**选择**: 在仓库根目录创建 `README_OHOS.md`，而非替换 `README.md`

**理由**: 保留上游 README.md 便于同步上游更新；OHOS 用户通过 README_OHOS.md 获取移植相关信息；GitHub 不会自动渲染 README_OHOS.md，但用户可从仓库首页直接点击进入

**替代方案**: 直接替换 README.md — 会与上游冲突，增加合并困难

### Decision 2: 语言 — 中文

**选择**: README 全文使用中文编写

**理由**: OHOS 生态主要面向中国开发者；参考项目 OpenHarmonyPCDeveloper/rust 使用中文；目标受众为中文用户

### Decision 3: README 结构 — 仿照 OpenHarmonyPCDeveloper/rust 风格

**选择**: 采用以下章节结构：
1. 标题 + 徽章
2. 项目简介（一句话说明 + 与上游关系）
3. OHOS 适配概述（适配内容摘要表格）
4. CI/CD 流水线（触发条件、Runner 环境、产物说明）
5. 快速开始（环境要求、构建命令、部署步骤）
6. 测试结果（通过率统计、模块覆盖）
7. 已知问题与限制
8. 致谢与许可证

**理由**: 与 OpenHarmonyPCDeveloper 生态项目保持一致的文档风格，降低 OHOS 用户的学习成本

### Decision 4: 徽章来源 — GitHub Actions

**选择**: 使用 GitHub Actions workflow status badge，指向 `ohos-build.yml`

**理由**: 该仓库的 CI/CD 流水线部署在 GitHub Actions 上；badge 格式为 `https://github.com/sb-fy-sb/uv/actions/workflows/ohos-build.yml/badge.svg`

### Decision 5: 内容深度 — 概览 + 链接

**选择**: 各章节提供概览信息，详细内容链接到 openspec/changes 下的设计文档和 ohos/ 目录下的测试文档

**理由**: README 应简洁易读；openspec 文档提供了完整的技术决策和风险分析；避免信息重复导致维护困难

## Risks / Trade-offs

- **[风险] 上游 README.md 更新后，README_OHOS.md 不同步** → README_OHOS.md 专注于 OHOS 移植内容，与上游 README 的职责分离，减少同步需求
- **[Trade-off] GitHub 不自动渲染 README_OHOS.md** → 用户需点击进入文件查看，但在 README_OHOS.md 开头添加返回上游 README 的链接
- **[风险] CI badge 在仓库为 private 时不显示** → badge 链接使用 `branch=ohos-aarch64` 参数，确保指向正确的分支
