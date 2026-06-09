#!/bin/bash
# Deploy uv_release.zip to OHOS device and configure PATH

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ZIP_SRC="${SCRIPT_DIR}/uv_release.zip"
DEST_DIR="/storage/Users/currentUser"

# 1. Move zip to target directory
echo "Moving uv_release.zip to ${DEST_DIR} ..."
mv "${ZIP_SRC}" "${DEST_DIR}/"

# 2. Extract
echo "Extracting ..."
cd "${DEST_DIR}" || exit 1
unzip -o uv_release.zip

# 3. Append PATH config to ~/.zshrc (idempotent — skip if already present)
if ! grep -q 'uv_release' ~/.zshrc 2>/dev/null; then
    cat >> ~/.zshrc << EOF

#uvPython环境
export PATH="${SCRIPT_DIR}/uv_release:\$PATH"
EOF
    echo "~/.zshrc updated."
else
    echo "~/.zshrc already contains uv_release, skipping."
fi

echo "Done. Run 'source ~/.zshrc' to apply."
