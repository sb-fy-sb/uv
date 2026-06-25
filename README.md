# uv — OpenHarmony (OHOS) 移植版

[![OHOS Build](https://github.com/sb-fy-sb/uv/actions/workflows/ohos-build.yml/badge.svg?branch=ohos-aarch64)](https://github.com/sb-fy-sb/uv/actions/workflows/ohos-build.yml)
[![上游项目](https://img.shields.io/badge/upstream-astral--sh%2Fuv-blue)](https://github.com/astral-sh/uv)
[![License](https://img.shields.io/badge/license-Apache--2.0%20OR%20MIT-blue.svg)](LICENSE)

> 本项目是 [astral-sh/uv](https://github.com/astral-sh/uv) 的 OpenHarmony (OHOS) aarch64 平台移植分支。uv 是一个极快的 Python 包和项目管理器，用 Rust 编写。本分支在保留上游全部功能的基础上，完成了 OHOS 平台的代码适配、CI/CD 自动化构建和功能验证测试。

---

## 目录

- [OHOS 适配概述](#ohos-适配概述)
- [CI/CD 流水线](#cicd-流水线)
- [快速开始](#快速开始)
  - [一键安装（在 OHOS 设备上直接运行）](#一键安装在-ohos-设备上直接运行)
  - [从源码构建](#从源码构建)
- [部署到 OHOS 设备](#部署到-ohos-设备)
- [测试结果](#测试结果)
- [已知问题与限制](#已知问题与限制)
- [项目结构](#项目结构)
- [致谢](#致谢)
- [许可证](#许可证)

---

## OHOS 适配概述

本分支针对 OHOS 平台（`aarch64-unknown-linux-ohos`，musl libc）完成了以下适配：

| 适配项 | 说明 | 涉及文件 |
|--------|------|----------|
| **默认存储路径重定向** | OHOS 根文件系统只读，启动时自动将 `HOME` 设为 uv 可执行文件所在目录，使缓存/数据路径指向可写分区；预设 `UV_LIBC=musl` 绕过沙盒环境下的 libc 检测；Python 安装路径重定向到 `/data/local/tmp` | `crates/uv/src/lib.rs` |
| **PEP 517 平台兼容性桩** | `uv build` 时自动注入 Python 桩代码，将 `sysconfig.get_platform()` 返回值从 `harmonyos` 映射为 `linux`，使 setuptools 等构建后端正常工作 | `crates/uv-build-frontend/src/lib.rs` |
| **CI/CD 自动化构建** | GitHub Actions workflow 在 Windows 自托管 Runner 上交叉编译 OHOS aarch64 二进制，含 ELF 产物验证和 Artifacts 上传 | `.github/workflows/ohos-build.yml` |
| **功能验证测试** | 107 个测试用例覆盖全部核心模块，含独立的功能验证脚本（PARTIAL 状态检测） | `ohos/test-uv-ohos.sh`、`ohos/verify-uv-ohos.sh` |

### 技术要点

- **目标平台**: `aarch64-unknown-linux-ohos`（ARM64，musl libc，Linux 内核）
- **编译方式**: OHOS SDK（LLVM 工具链 + musl sysroot）交叉编译
- **动态依赖**: 仅 `libc.so`（OHOS musl 动态库），无额外运行时依赖
- **产物格式**: ELF 64-bit LSB PIE executable，约 48MB（release，stripped）

---

## CI/CD 流水线

本项目使用 GitHub Actions 实现 OHOS aarch64 二进制的自动化构建，分为两条分支：

| 分支 | 用途 | 产出 |
|------|------|------|
| `ohos-aarch64` | CI 构建验证 | 上传到 GitHub Actions Artifacts（30 天） |
| `ohos-release` | 发布版本 | 上传到 GitHub Release（版本化 + 滚动更新） |

### 触发条件

| 触发方式 | 条件 |
|----------|------|
| **Push** | 推送到 `ohos-aarch64`、`ohos-release` 或 `claude/ohos-*` 分支，且变更涉及 Rust 源码、Cargo 配置或 workflow 文件 |
| **手动触发** | 通过 GitHub Actions 页面点击 "Run workflow" |

### 构建流程

```
源码检出 → 环境检查 → OHOS 交叉编译环境配置 → 缓存恢复 → cargo build → ELF 产物验证 → 打包上传
```

### Runner 环境要求

- Windows x86_64 自托管 Runner
- OHOS SDK（含 LLVM 工具链 + musl sysroot）
- Rust stable 工具链 + `aarch64-unknown-linux-ohos` target
- cmake、ninja

### 构建产物

**CI 构建**（`ohos-aarch64` 分支）：每次构建生成 Artifacts（保留 30 天）

| Artifact | 内容 |
|----------|------|
| `uv-ohos-aarch64-<commit>-<date>.tar.gz` | 打包的 uv 二进制 + README |
| `uv-ohos-aarch64-<commit>-<date>-raw` | 原始 ELF 二进制文件 |

**Release 构建**（`ohos-release` 分支）：上传到 GitHub Release

| Release Tag | 说明 |
|-------------|------|
| `ohos-YYYYMMDD` | 版本化 Release，每次推送创建新的 |
| `ohos-latest` | 滚动 Release，始终指向最新版本（用于一键安装） |

可在 [GitHub Actions](https://github.com/sb-fy-sb/uv/actions/workflows/ohos-build.yml) 页面下载 CI 产物，或在 [GitHub Releases](https://github.com/sb-fy-sb/uv/releases) 页面下载 Release 版本。

### 发布新版本

将已验证的代码从 `ohos-aarch64` 合并到 `ohos-release` 分支即可触发发布：

```bash
git checkout ohos-release
git merge ohos-aarch64
git push origin ohos-release
```

CI 会自动构建、验证、并创建版本化 Release（`ohos-YYYYMMDD`），同时更新 `ohos-latest` 滚动标签。

---

## 快速开始

### 一键安装（在 OHOS 设备上直接运行）

无需 Windows 电脑，在 OHOS 设备终端中直接执行：

```sh
/bin/sh -c "$(curl -fsSL https://github.com/sb-fy-sb/uv/releases/download/ohos-latest/install-uv-ohos.sh)"
```

脚本会自动下载最新构建的 uv 二进制并安装到 `/data/local/tmp/uv`。

安装后验证：

```sh
/data/local/tmp/uv --version
```

> 也可自定义安装目录：`INSTALL_DIR=/your/path /bin/sh -c "$(curl -fsSL ...)"`

#### 手动下载安装

如果不方便使用一键安装脚本，也可手动下载：

```sh
curl -fSL -o /data/local/tmp/uv https://github.com/sb-fy-sb/uv/releases/download/ohos-latest/uv-ohos-aarch64
chmod +x /data/local/tmp/uv
/data/local/tmp/uv --version
```

---

### 从源码构建

#### 环境要求

| 工具 | 最低版本 | 说明 |
|------|---------|------|
| **OHOS SDK** | DevEco Studio 自带 | 含 LLVM 工具链、musl sysroot、cmake、ninja |
| **Rust** | stable | 需安装 `aarch64-unknown-linux-ohos` target |
| **cmake** | 3.x | aws-lc-rs 依赖需要 |
| **ninja** | 1.x | CMake 构建后端 |

#### 交叉编译（Windows → OHOS aarch64）

##### 1. 创建 SDK 路径链接（避免空格问题）

OHOS SDK 默认路径含空格（`C:\Program Files\...`），需创建无空格的 Junction：

```powershell
powershell -Command "New-Item -ItemType Junction -Path 'C:\ohos\sdk' -Target 'C:\Program Files\Huawei\DevEco Studio\sdk\default\openharmony\native' -Force"
```

##### 2. 安装 Rust target

```bash
rustup target add aarch64-unknown-linux-ohos --toolchain stable
```

> 国内用户如遇下载慢，可设置清华镜像：
> ```bash
> export RUSTUP_DIST_SERVER="https://mirrors.tuna.tsinghua.edu.cn/rustup"
> ```

##### 3. 配置交叉编译环境

创建 `.cargo/config.toml`（OHOS 交叉编译配置）：

```toml
[source.crates-io]
replace-with = 'ustc'

[source.ustc]
registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"

[target.aarch64-unknown-linux-ohos]
linker = "C:/ohos/sdk/llvm/bin/clang.exe"
ar = "C:/ohos/sdk/llvm/bin/llvm-ar.exe"
rustflags = ["-C", "link-arg=--target=aarch64-linux-ohos", "-C", "link-arg=--sysroot=C:/ohos/sdk/sysroot"]

[env]
OHOS_SYSROOT = "C:/ohos/sdk/sysroot"
CC_aarch64_unknown_linux_ohos = "C:/ohos/sdk/llvm/bin/clang.exe"
CFLAGS_aarch64_unknown_linux_ohos = "--target=aarch64-linux-ohos --sysroot=C:/ohos/sdk/sysroot -D__MUSL__"
CXX_aarch64_unknown_linux_ohos = "C:/ohos/sdk/llvm/bin/clang++.exe"
CXXFLAGS_aarch64_unknown_linux_ohos = "--target=aarch64-linux-ohos --sysroot=C:/ohos/sdk/sysroot -D__MUSL__"
AR_aarch64_unknown_linux_ohos = "C:/ohos/sdk/llvm/bin/llvm-ar.exe"
CARGO_TARGET_AARCH64_UNKNOWN_LINUX_OHOS_LINKER = "C:/ohos/sdk/llvm/bin/clang.exe"
CMAKE_GENERATOR_aarch64_unknown_linux_ohos = "Ninja"
CMAKE_MAKE_PROGRAM_aarch64_unknown_linux_ohos = "C:/ohos/sdk/build-tools/cmake/bin/ninja.exe"
```

创建 `ohos-toolchain.cmake`（CMake 交叉编译工具链文件）：

```cmake
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(OHOS_SDK "C:/ohos/sdk")
set(CMAKE_C_COMPILER "${OHOS_SDK}/llvm/bin/clang.exe")
set(CMAKE_CXX_COMPILER "${OHOS_SDK}/llvm/bin/clang++.exe")
set(CMAKE_AR "${OHOS_SDK}/llvm/bin/llvm-ar.exe" CACHE FILEPATH "ar" FORCE)
set(CMAKE_RANLIB "${OHOS_SDK}/llvm/bin/llvm-ranlib.exe" CACHE FILEPATH "ranlib" FORCE)
set(CMAKE_C_COMPILER_TARGET "aarch64-linux-ohos")
set(CMAKE_CXX_COMPILER_TARGET "aarch64-linux-ohos")
set(CMAKE_SYSROOT "${OHOS_SDK}/sysroot")
set(CMAKE_MAKE_PROGRAM "${OHOS_SDK}/build-tools/cmake/bin/ninja.exe" CACHE FILEPATH "ninja" FORCE)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D__MUSL__" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D__MUSL__" CACHE STRING "" FORCE)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
```

##### 4. 执行构建

```bash
# 设置无空格的输出目录
export CARGO_TARGET_DIR="C:/uv-target"
export PATH="/c/ohos/sdk/build-tools/cmake/bin:$PATH"

# Release 构建（推荐，约 48MB）
cargo build --release --target aarch64-unknown-linux-ohos -p uv \
  --no-default-features --features "uv-distribution/static,test-defaults"

# 裁剪二进制
C:/ohos/sdk/llvm/bin/llvm-strip.exe "$CARGO_TARGET_DIR/aarch64-unknown-linux-ohos/release/uv"
```

构建产物位于：`C:\uv-target\aarch64-unknown-linux-ohos\release\uv`

#### 设备端原生编译

也可以直接在 OHOS 设备上编译（需要在设备上安装 Rust 工具链）：

```bash
# 在 OHOS 设备上执行
export PATH="/storage/Users/currentUser/usr/rust-1.95.0-aarch64-unknown-linux-ohos/bin:$PATH"
cd /storage/Users/currentUser/uv/uv
cargo build --release --target aarch64-unknown-linux-ohos -p uv \
  --no-default-features --features "uv-distribution/static,test-defaults"
```

> 详细步骤请参考 `ohos/ohos-cross-compile.md`。

---

## 部署到 OHOS 设备

使用 `hdc`（HarmonyOS Device Connector）将构建产物推送到 OHOS 设备：

```bash
# 发送二进制到设备（推荐放在 /data/local/tmp，该目录可读写）
hdc file send uv /data/local/tmp/uv

# 设置可执行权限
hdc shell chmod +x /data/local/tmp/uv

# 验证
hdc shell /data/local/tmp/uv --version
```

> **注意**: 使用 Git Bash (MSYS2) 时，需设置 `MSYS_NO_PATHCONV=1` 防止路径转换问题。

### 使用 uv

部署后即可正常使用 uv 的全部功能。OHOS 适配会自动处理存储路径和环境变量：

```bash
# uv 自动将 HOME 重定向到可执行文件所在目录，无需手动设置环境变量
hdc shell /data/local/tmp/uv python install 3.12
hdc shell /data/local/tmp/uv venv /data/local/tmp/myenv
hdc shell /data/local/tmp/uv pip install requests
```

---

## 测试结果

基于 OHOS 设备端实际运行的测试套件，覆盖 uv 全部核心功能模块：

### 统计概览

| 指标 | 数据 |
|------|------|
| **测试用例总数** | 107 |
| **通过** | 106 |
| **未通过** | 1（`uv self update`，预期行为） |
| **通过率** | **99.1%** |

### 模块覆盖

| 模块 | 用例数 | 通过 | 说明 |
|------|--------|------|------|
| A. 基础命令 | 19 | 18 | `uv self update` 不支持外部部署 |
| B. Python 管理 | 9 | 9 | 安装/卸载/查找/固定 Python |
| C. 虚拟环境 + pip | 27 | 27 | venv 创建、pip install/uninstall/compile/sync |
| D. 项目管理 | 28 | 28 | init/lock/sync/add/remove/run/export |
| E. Tool 管理 | 12 | 12 | install/list/run/uninstall/upgrade |
| F. Cache 管理 | 2 | 2 | prune/clean |
| G. Build | 3 | 3 | sdist/wheel/完整构建 |
| H. Auth 管理 | 3 | 3 | login/logout/token |
| I. Workspace 管理 | 3 | 3 | dir/list/metadata |
| J. Publish | 1 | 1 | publish --help |

> 详细的测试设计文档和验证报告见 `ohos/` 目录。

---

## 已知问题与限制

| 问题 | 原因 | 状态 |
|------|------|------|
| `uv self update` 不可用 | uv 通过外部方式（hdc）部署到 OHOS，不支持自更新机制 | 已知限制 |
| Python 安装路径固定为 `/data/local/tmp` | OHOS 沙盒应用对用户存储目录中的 ELF shared object 有执行限制（`Permission denied`） | 已适配 |
| `uv python pin` 写入失败（若部署在只读分区） | OHOS 根文件系统只读 | 需将 uv 部署在可写目录 |

---

## 项目结构

```
├── .cargo/config.toml              # OHOS 交叉编译配置
├── .github/workflows/
│   └── ohos-build.yml              # OHOS CI/CD 构建流水线
├── ohos/                           # OHOS 相关文档和测试脚本
│   ├── install-uv-ohos.sh          # 一键安装脚本（设备端 curl | sh）
│   ├── ohos-cross-compile.md       # 交叉编译详细指南
│   ├── test-uv-ohos.sh             # 功能测试脚本（107 用例）
│   ├── verify-uv-ohos.sh           # 功能验证测试脚本
│   └── OHOS_uv_测试设计文档.md      # 测试设计文档
├── ohos-toolchain.cmake            # CMake 交叉编译工具链文件
├── cmake-wrapper.bat               # CMake 包装脚本（注入 Ninja）
├── build_ohos.sh                   # OHOS 设备端原生编译脚本
├── openspec/changes/               # OpenSpec 变更记录
│   ├── add-ohos-readme/            # OHOS README 文档设计
│   ├── ohos-ci-build-pipeline/     # CI/CD 流水线设计
│   ├── ohos-default-storage-path/  # 存储路径重定向设计
│   └── archive/                    # 已归档的适配变更
└── README.md                       # 本文件
```

---

## 致谢

- **[astral-sh/uv](https://github.com/astral-sh/uv)** — 上游项目，极快的 Python 包和项目管理器
- **[OpenHarmonyPCDeveloper](https://gitcode.com/OpenHarmonyPCDeveloper)** — OpenHarmony PC 开发者社区，提供 Rust 工具链移植参考
- **[Rust on OpenHarmony](https://doc.rust-lang.org/rustc/platform-support/openharmony.html)** — Rust 官方 OpenHarmony 平台支持文档

---

## 许可证

本项目与上游 uv 保持一致，采用双许可证：

- **Apache License 2.0** ([LICENSE-APACHE](LICENSE-APACHE))
- **MIT License** ([LICENSE-MIT](LICENSE-MIT))

您可以选择其中任一许可证使用本项目。
