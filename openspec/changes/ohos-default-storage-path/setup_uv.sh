#!/bin/bash
# Setup script for uv on OpenHarmony (ohos) terminal

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
UV_DIR="$SCRIPT_DIR"
ZSHRC="$HOME/.zshrc"
PATH_LINE="export PATH=\"$UV_DIR:\$PATH\""
COMMENT_LINE="# uv Python environment"

echo "Extracting uv_release.zip..."
if [ ! -f "$SCRIPT_DIR/uv_release.zip" ]; then
    echo "Error: $SCRIPT_DIR/uv_release.zip not found"
    exit 1
fi

unzip -o "$SCRIPT_DIR/uv_release.zip" -d "$SCRIPT_DIR"

if [ ! -d "$UV_DIR" ]; then
    echo "Error: Extraction completed but $UV_DIR directory not found"
    exit 1
fi

chmod +x "$UV_DIR"/* 2>/dev/null
echo "Extraction complete: $UV_DIR"

echo "Configuring ~/.zshrc..."

# Check if already configured
if [ -f "$ZSHRC" ] && grep -qF "$UV_DIR" "$ZSHRC"; then
    echo "PATH already configured in $ZSHRC, skipping"
else
    cat >> "$ZSHRC" << EOF

$COMMENT_LINE
$PATH_LINE
EOF
    echo "PATH added to $ZSHRC"
fi

echo ""
echo "Applying changes..."
source "$ZSHRC"
echo "Done! uv is now available in PATH."
read -rp "Press Enter to exit..."
exit 0
