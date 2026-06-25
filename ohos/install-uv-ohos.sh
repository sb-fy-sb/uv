#!/bin/sh
# uv for HarmonyOS (OHOS) 一键安装脚本
#
# 用法（国内镜像）:
#   /bin/sh -c "$(curl -fsSL https://mirror.ghproxy.com/https://github.com/sb-fy-sb/uv/releases/download/ohos-latest/install-uv-ohos.sh)"
#
# 用法（直连 GitHub）:
#   /bin/sh -c "$(curl -fsSL https://github.com/sb-fy-sb/uv/releases/download/ohos-latest/install-uv-ohos.sh)"
#
# 自定义安装目录:
#   INSTALL_DIR=/your/path /bin/sh -c "$(curl -fsSL ...)"

set -e

# ── 配置 ──────────────────────────────────────────────
REPO="sb-fy-sb/uv"
BINARY_NAME="uv-ohos-aarch64"
INSTALL_DIR="${INSTALL_DIR:-/storage/Users/currentUser/usr/uv}"
RELEASE_TAG="ohos-latest"

# GitHub 直连地址
GITHUB_BASE="https://github.com/${REPO}/releases/download/${RELEASE_TAG}"
GITHUB_API="https://api.github.com/repos/${REPO}/releases/tags/${RELEASE_TAG}"

# 国内镜像代理（按优先级排列）
MIRRORS="
https://mirror.ghproxy.com/
https://ghproxy.net/
"

CACERT="/etc/ssl/certs/cacert.pem"

# ── 颜色 ──────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

info()  { printf "${CYAN}==> ${NC}%s\n" "$1"; }
warn()  { printf "${YELLOW}==> ${NC}%s\n" "$1"; }
ok()    { printf "${GREEN}==> ${NC}%s\n" "$1"; }
fail()  { printf "${RED}==> ${NC}%s\n" "$1"; }

# ── 网络请求封装 ──────────────────────────────────────
# 尝试 curl，自动处理证书问题
_do_curl() {
    url="$1"
    output="$2"  # 可选：输出文件路径

    if [ -n "$output" ]; then
        if [ -f "$CACERT" ]; then
            curl -fSL --cacert "$CACERT" --retry 2 --connect-timeout 15 -o "$output" "$url" 2>/dev/null && return 0
        fi
        curl -fSL -k --retry 2 --connect-timeout 15 -o "$output" "$url" 2>/dev/null && return 0
    else
        if [ -f "$CACERT" ]; then
            curl -fsSL --cacert "$CACERT" --connect-timeout 15 "$url" 2>/dev/null && return 0
        fi
        curl -fsSL -k --connect-timeout 15 "$url" 2>/dev/null && return 0
    fi
    return 1
}

# 带镜像回退的下载：先尝试镜像，最后回退到 GitHub 直连
download_with_fallback() {
    github_url="$1"
    output="$2"

    # 先尝试各镜像
    for mirror in $MIRRORS; do
        mirror_url="${mirror}${github_url}"
        info "尝试镜像: ${mirror%%/}"
        if _do_curl "$mirror_url" "$output"; then
            ok "镜像下载成功"
            return 0
        fi
        warn "镜像失败: ${mirror%%/}"
    done

    # 回退到 GitHub 直连
    info "尝试 GitHub 直连..."
    if _do_curl "$github_url" "$output"; then
        ok "直连下载成功"
        return 0
    fi

    return 1
}

# 获取文本内容（用于 API 调用），带镜像回退
fetch_text_with_fallback() {
    github_url="$1"

    # 先尝试 GitHub 直连（API 不一定有镜像）
    result=$(_do_curl "$github_url" "") && { echo "$result"; return 0; }

    # 尝试镜像代理
    for mirror in $MIRRORS; do
        mirror_url="${mirror}${github_url}"
        result=$(_do_curl "$mirror_url" "") && { echo "$result"; return 0; }
    done

    return 1
}

# ── 前置检查 ──────────────────────────────────────────
check_prereqs() {
    if ! command -v curl >/dev/null 2>&1; then
        fail "需要 curl，请先安装"
        exit 1
    fi

    if [ "$(uname -m)" != "aarch64" ]; then
        fail "本包仅支持 aarch64 架构，当前: $(uname -m)"
        exit 1
    fi

    # 检查安装目录可写
    if [ ! -d "$INSTALL_DIR" ]; then
        info "创建安装目录: $INSTALL_DIR"
        mkdir -p "$INSTALL_DIR" 2>/dev/null || {
            fail "无法创建目录: $INSTALL_DIR"
            fail "请通过 INSTALL_DIR 环境变量指定可写目录"
            exit 1
        }
    fi

    touch "$INSTALL_DIR/.uv_write_test" 2>/dev/null && rm -f "$INSTALL_DIR/.uv_write_test" || {
        fail "安装目录不可写: $INSTALL_DIR"
        fail "请通过 INSTALL_DIR 环境变量指定可写目录"
        exit 1
    }
}

# ── 获取最新版本 ──────────────────────────────────────
get_latest_version() {
    info "查询最新版本..."

    release_json=$(fetch_text_with_fallback "$GITHUB_API") || {
        fail "无法获取版本信息，请检查网络连接"
        fail "或手动下载: https://github.com/${REPO}/releases"
        exit 1
    }

    # 提取 tag_name
    TAG=$(echo "$release_json" | grep -m1 '"tag_name"' | sed 's/.*"tag_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

    if [ -z "$TAG" ]; then
        # API 失败时使用默认 tag
        TAG="$RELEASE_TAG"
        warn "无法解析版本号，使用默认标签: $TAG"
    else
        ok "最新版本: $TAG"
    fi
}

# ── 下载 ──────────────────────────────────────────────
download() {
    download_url="${GITHUB_BASE}/${BINARY_NAME}"
    target_path="${INSTALL_DIR}/uv"

    # 检查是否已存在
    if [ -f "$target_path" ]; then
        existing_ver=$("$target_path" --version 2>/dev/null || echo "unknown")
        warn "已存在 uv: $existing_ver"
        printf "是否覆盖？[y/N] "
        read -r answer
        case "$answer" in
            y*|Y*) ;;
            *) ok "保留现有版本，跳过安装"; return 1 ;;
        esac
    fi

    info "下载 uv (OHOS aarch64)..."

    # 下载到临时文件
    tmp_file="${INSTALL_DIR}/.uv_downloading"

    if download_with_fallback "$download_url" "$tmp_file"; then
        mv "$tmp_file" "$target_path"
    else
        rm -f "$tmp_file"
        fail "下载失败，所有镜像和直连均不可用"
        fail "  URL: $download_url"
        fail ""
        fail "手动下载命令："
        fail "  curl -fSL -o ${target_path} https://mirror.ghproxy.com/${download_url}"
        exit 1
    fi
}

# ── 安装 ──────────────────────────────────────────────
install_binary() {
    target_path="${INSTALL_DIR}/uv"

    info "设置可执行权限..."
    chmod +x "$target_path"

    # 首次运行确认（OHOS ELF 签名机制可能需要）
    info "验证安装..."
    ver=$("$target_path" --version 2>&1) || {
        fail "uv 无法运行: $ver"
        fail "可能需要手动签名或检查权限"
        exit 1
    }

    ok "安装成功: $ver"
}

# ── 完成 ──────────────────────────────────────────────
print_success() {
    target_path="${INSTALL_DIR}/uv"
    echo ""
    printf "${GREEN}${BOLD}  ✅ uv 安装成功！${NC}\n"
    echo ""
    printf "  版本:      ${CYAN}${TAG}${NC}\n"
    printf "  安装位置:  ${CYAN}${target_path}${NC}\n"
    echo ""
    printf "  ${BOLD}使用方法：${NC}\n"
    echo ""
    printf "    ${YELLOW}${target_path} --version${NC}\n"
    printf "    ${YELLOW}${target_path} python install 3.12${NC}\n"
    printf "    ${YELLOW}${target_path} venv myenv${NC}\n"
    printf "    ${YELLOW}${target_path} pip install requests${NC}\n"
    echo ""

    # 如果不在 PATH 中，提示添加到 PATH
    if ! command -v uv >/dev/null 2>&1; then
        printf "  ${BOLD}添加到 PATH（可选）：${NC}\n"
        echo ""
        printf "    ${YELLOW}export PATH=\"${INSTALL_DIR}:\$PATH\"${NC}\n"
        echo ""
    fi

    printf "  ${BOLD}卸载：${NC}\n"
    echo ""
    printf "    ${YELLOW}rm ${target_path}${NC}\n"
    echo ""
}

# ── 主流程 ────────────────────────────────────────────
main() {
    echo ""
    printf "${CYAN}${BOLD}  📦 uv for HarmonyOS (OHOS) 安装程序${NC}\n"
    echo "  ----------------------------------------"
    echo ""

    check_prereqs
    get_latest_version

    if download; then
        install_binary
        print_success
    fi
}

main "$@"
