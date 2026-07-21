## ADDED Requirements

### Requirement: README 文件结构与位置

仓库根目录 SHALL 存在 `README_OHOS.md` 文件，使用中文编写，包含以下必要章节（按顺序）：
1. 标题与 CI/CD 状态徽章
2. 项目简介（与上游 astral-sh/uv 的关系说明）
3. OHOS 平台适配概述
4. CI/CD 流水线说明
5. 快速开始（构建与部署指南）
6. 测试结果统计
7. 已知问题与限制
8. 致谢与许可证

#### Scenario: README_OHOS.md 文件存在
- **WHEN** 用户访问 sb-fy-sb/uv 仓库
- **THEN** 仓库根目录 SHALL 存在 `README_OHOS.md` 文件

#### Scenario: README 使用中文编写
- **WHEN** 用户阅读 README_OHOS.md
- **THEN** 所有章节标题和内容 SHALL 使用中文编写（代码块和技术术语除外）

### Requirement: CI/CD 状态徽章

README_OHOS.md SHALL 在标题下方展示 GitHub Actions 构建状态徽章，指向 `ohos-build.yml` workflow。

#### Scenario: 徽章正确显示
- **WHEN** README_OHOS.md 被渲染
- **THEN** SHALL 显示 GitHub Actions workflow badge，链接格式为 `https://github.com/sb-fy-sb/uv/actions/workflows/ohos-build.yml/badge.svg?branch=ohos-aarch64`

#### Scenario: 徽章可点击跳转
- **WHEN** 用户点击构建状态徽章
- **THEN** SHALL 跳转到 GitHub Actions 的 OHOS Build workflow 页面

### Requirement: OHOS 适配概述章节

README_OHOS.md SHALL 包含 OHOS 平台适配概述，以表格或列表形式列出已完成的适配工作，包括：默认存储路径重定向、PEP 517 平台兼容性桩、CI/CD 自动化构建流水线、功能验证测试套件。

#### Scenario: 适配内容完整列出
- **WHEN** 用户阅读 OHOS 适配概述章节
- **THEN** SHALL 列出所有已完成的 OHOS 适配改动，每项包含简要描述

### Requirement: 构建指南章节

README_OHOS.md SHALL 包含从源码构建 uv OHOS 二进制的完整指南，涵盖环境要求、工具链配置、构建命令和产物验证。

#### Scenario: 构建步骤可执行
- **WHEN** 开发者按照 README 中的构建指南操作
- **THEN** 指南 SHALL 包含 OHOS SDK 安装、Rust target 添加、cargo build 命令等必要步骤

#### Scenario: 构建命令正确
- **WHEN** 开发者执行 README 中的构建命令
- **THEN** 命令 SHALL 为 `cargo build --release --target aarch64-unknown-linux-ohos -p uv`，并包含必要的 features 参数

### Requirement: 部署指南章节

README_OHOS.md SHALL 包含将构建产物部署到 OHOS 设备的步骤，使用 hdc 工具进行文件传输和权限设置。

#### Scenario: 部署命令完整
- **WHEN** 用户按照部署指南操作
- **THEN** 指南 SHALL 包含 `hdc file send`、`chmod +x`、`uv --version` 验证等完整步骤

### Requirement: 测试结果统计章节

README_OHOS.md SHALL 包含测试结果统计，展示测试用例总数、通过数、通过率和模块覆盖情况。

#### Scenario: 测试数据准确
- **WHEN** 用户查看测试结果统计
- **THEN** SHALL 显示 107 个测试用例、106 个通过、99.1% 通过率的数据

#### Scenario: 模块覆盖清晰
- **WHEN** 用户查看模块覆盖
- **THEN** SHALL 按模块（基础命令、Python 管理、虚拟环境、pip、项目管理、Tool 管理、Build 等）列出测试覆盖情况

### Requirement: 已知问题章节

README_OHOS.md SHALL 列出已知的 OHOS 平台限制和问题，包括 `uv self update` 不可用等。

#### Scenario: 已知问题列出
- **WHEN** 用户查看已知问题章节
- **THEN** SHALL 列出 `uv self update` 不支持等已知限制及其原因说明
