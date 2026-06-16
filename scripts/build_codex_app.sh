#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_BUNDLE="${AGENT_WORKBENCH_APP_BUNDLE:-${CODEX_WORKBENCH_APP_BUNDLE:-$HOME/Applications/Local Agent Workbench.app}}"
SCRIPT_PATH="$ROOT_DIR/scripts/launch_codex_tmux.applescript"
ICON_NAME="CodexCLI9Panes"
ICON_FILE="$ROOT_DIR/Assets/$ICON_NAME.icns"

clear_app_xattrs() {
  local bundle_path="$1"
  if command -v xattr >/dev/null 2>&1; then
    /usr/bin/xattr -cr "$bundle_path"
    find "$bundle_path" -print0 | xargs -0 -n1 /usr/bin/xattr -c 2>/dev/null || true
    while IFS= read -r -d '' path; do
      /usr/bin/xattr -c "$path" 2>/dev/null || true
      /usr/bin/xattr -d com.apple.FinderInfo "$path" 2>/dev/null || true
      /usr/bin/xattr -d 'com.apple.fileprovider.fpfs#P' "$path" 2>/dev/null || true
      /usr/bin/xattr -d com.apple.macl "$path" 2>/dev/null || true
    done < <(find "$bundle_path" -print0)
  fi
}

sign_app() {
  local bundle_path="$1"
  if command -v codesign >/dev/null 2>&1; then
    rm -rf "$bundle_path/Contents/_CodeSignature"
    clear_app_xattrs "$bundle_path"
    codesign --force --deep --sign - "$bundle_path" >/dev/null
  fi
}

rm -rf "$APP_BUNDLE"
mkdir -p "$(dirname "$APP_BUNDLE")"
python3 "$ROOT_DIR/scripts/create_codex_icon.py" >/dev/null
iconutil -c icns "$ROOT_DIR/Assets/$ICON_NAME.iconset" -o "$ICON_FILE"
osacompile -o "$APP_BUNDLE" "$SCRIPT_PATH"
cp "$ICON_FILE" "$APP_BUNDLE/Contents/Resources/$ICON_NAME.icns"
/usr/libexec/PlistBuddy -c "Set :CFBundleName Local Agent Workbench" "$APP_BUNDLE/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName Local Agent Workbench" "$APP_BUNDLE/Contents/Info.plist" 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Set :CFBundleIconFile $ICON_NAME" "$APP_BUNDLE/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleIconName $ICON_NAME" "$APP_BUNDLE/Contents/Info.plist" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :CFBundleIconName string $ICON_NAME" "$APP_BUNDLE/Contents/Info.plist" 2>/dev/null || true
touch "$APP_BUNDLE"
clear_app_xattrs "$APP_BUNDLE"
sign_app "$APP_BUNDLE"

echo "$APP_BUNDLE"
