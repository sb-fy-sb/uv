#!/bin/sh
# uv for HarmonyOS (OHOS) 一键安装脚本
# 用法: /bin/sh -c "$(curl -fsSL https://github.com/sb-fy-sb/uv/releases/latest/download/install-uv-ohos.sh)"
#
# 支持自定义安装目录:
#   INSTALL_DIR=/path/to/dir /bin/sh -c "$(curl -fsSL ...)"

set -e

# ── 配置 ──────────────────────────────────────────────
REPO="sb-fy-sb/uv"
BINARY_NAME="uv-ohos-aarch64"
INSTALL_DIR="${INSTALL_DIR:-/data/local/tmp}"
RELEASE_API="https://api.github.com/repos/${REPO}/releases/latest"

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
        fail "请通过 INSTALL_DIR 环境变量指定可写目录，例如："
        fail "  INSTALL_DIR=/data/local/tmp /bin/sh -c \"\$(curl -fsSL ...)\""
        exit 1
    }
}

# ── 获取最新版本 ──────────────────────────────────────
get_latest_version() {
    info "查询最新版本..."

    # 尝试带证书请求
    release_json=""
    if [ -f "$CACERT" ]; then
        release_json=$(curl -fsSL --cacert "$CACERT" "$RELEASE_API" 2>/dev/null) || true
    fi

    # 回退：跳过证书验证
    if [ -z "$release_json" ]; then
        release_json=$(curl -fsSL -k "$RELEASE_API" 2>/dev/null) || true
    fi

    if [ -z "$release_json" ]; then
        fail "无法获取版本信息，请检查网络连接"
        fail "或手动下载: https://github.com/${REPO}/releases"
        exit 1
    fi

    # 提取 tag_name
    TAG=$(echo "$release_json" | grep -m1 '"tag_name"' | sed 's/.*"tag_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

    if [ -z "$TAG" ]; then
        fail "无法解析版本号"
        exit 1
    fi

    ok "最新版本: $TAG"
}

# ── 下载 ──────────────────────────────────────────────
download() {
    download_url="https://github.com/${REPO}/releases/download/${TAG}/${BINARY_NAME}"
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

    info "下载 uv ${TAG} (OHOS aarch64)..."

    # 下载到临时文件
    tmp_file="${INSTALL_DIR}/.uv_downloading"

    if [ -f "$CACERT" ]; then
        if curl -fSL --cacert "$CACERT" --retry 3 --connect-timeout 30 -o "$tmp_file" "$download_url"; then
            ok "下载完成"
        else
            warn "首次下载失败，尝试跳过证书验证..."
            curl -fSL -k --retry 3 --connect-timeout 30 -o "$tmp_file" "$download_url" || {
                rm -f "$tmp_file"
                fail "下载失败"
                fail "  URL: $download_url"
                fail "请检查网络或手动下载"
                exit 1
            }
            ok "下载完成"
        fi
    else
        curl -fSL -k --retry 3 --connect-timeout 30 -o "$tmp_file" "$download_url" || {
            rm -f "$tmp_file"
            fail "下载失败"
            fail "  URL: $download_url"
            exit 1
        }
        ok "下载完成"
    fi

    # 移动到最终位置
    mv "$tmp_file" "$target_path"
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

    # 如果不在 PATH 中，提示创建符号链接或添加 PATH
    if ! command -v uv >/dev/null 2>&1; then
        printf "  ${BOLD}添加到 PATH（可选）：${NC}\n"
        echo ""
        printf "    ${YELLOW}export PATH=\"${INSTALL_DIR}:\$PATH\"${NC}\n"
        echo ""
        printf "  或创建符号链接：\n"
        echo ""
        printf "    ${YELLOW}ln -sf ${target_path} /data/local/tmp/bin/uv${NC}\n"
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
