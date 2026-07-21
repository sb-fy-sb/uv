# uv OHOS 仓库说明

## 分支说明

| 分支 | 用途 | 触发流水线 |
|------|------|-----------|
| `main` | 主开发分支，日常提交 | OHOS Build |
| `ohos-release` | 发布分支，稳定版本代码 | OHOS Build |

---

## 流水线说明

### 1. OHOS Build（日常构建）

- **文件**: `.github/workflows/ohos-build.yml`
- **触发**: push 到 `main`、`ohos-release`、`ohos-aarch64`、`claude/ohos-*` 分支，且代码文件有变更
- **功能**: 交叉编译 OHOS aarch64 二进制，验证 ELF，打包
- **产物**: GitHub Actions Artifacts（保留 30 天）
- **用途**: 验证代码能否正常编译

### 2. OHOS Release（正式发版）

- **文件**: `.github/workflows/ohos-release.yml`
- **触发**: 推送 `ohos-v*` 格式的 tag（如 `ohos-v0.1.4`）
- **功能**: 编译 → 签名 → 创建 GitHub Release → 上传产物
- **产物**:
  - `uv-ohos-aarch64` — 裸二进制（安装脚本用）
  - `uv-ohos-aarch64-ohos-v*.tar.gz` — 归档包
  - `install-uv-ohos.sh` — 一键安装脚本
- **自动维护两个 Release**:
  - **版本 Release**（如 `ohos-v0.1.4`）— 每个版本一个，永久保留
  - **`ohos-latest`** — 滚动更新，始终指向最新构建

---

## 版本管理

### 发版流程

```bash
# 1. 在 ohos-release 分支上确保代码稳定
git checkout ohos-release
git pull origin ohos-release

# 2. 打 tag
git tag ohos-v0.2.0

# 3. 推送 tag 触发发版
git push origin ohos-v0.2.0
```

### 版本号规范

| 格式 | 说明 | 示例 |
|------|------|------|
| `ohos-vX.Y.Z` | 正式发布 | `ohos-v0.1.4`、`ohos-v1.0.0` |
| `ohos-latest` | 自动维护的滚动 tag | 无需手动操作 |

### 安装脚本

设备上执行一行命令即可安装（自动下载二进制、配置 PATH、安装 Python）：

```bash
# 国内镜像
curl -fsSL https://ghfast.top/https://github.com/sb-fy-sb/uv/releases/download/ohos-latest/install-uv-ohos.sh | sh

# 直连 GitHub
curl -fsSL https://github.com/sb-fy-sb/uv/releases/download/ohos-latest/install-uv-ohos.sh | sh
```

安装脚本会自动：

1. 下载 `uv-ohos-aarch64` 二进制
2. 安装到 `/storage/Users/currentUser/usr/uv/`
3. 配置 `~/.zshrc` 永久 PATH
4. 检测 Python，未安装则自动安装 3.12.9
5. 对 ELF 二进制签名（如设备有签名工具）
