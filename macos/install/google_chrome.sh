#! /usr/bin/env sh
#
# google_chrome.sh - Install Google Chrome on macOS.

set -eu
( set -o pipefail ) >/dev/null 2>&1 && set -o pipefail || true

APP_NAME="Google Chrome"
APP_PATH="/Applications/${APP_NAME}.app"
DMG_URL="https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"

# Exit early if already installed
if [ -d "${APP_PATH}" ]; then
  echo "[INFO] ${APP_NAME} is already installed. Nothing to do."
  exit 0
fi

# Requirements
for cmd in curl hdiutil ditto; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "[ERROR] Required command not found: ${cmd}"
    exit 1
  fi
done

# Setup cleanup
WD="" # Workdir
MP="" # Mountpoint

detach_mp() {
  # retry a few times in case Finder or Spotlight has a transient handle
  local mp="$1"
  for i in 1 2 3 4 5; do
    if hdiutil detach "$mp" -quiet >/dev/null 2>&1; then
      echo "[INFO] Detached ${MP}"
      return 0
    fi
    sleep 1
  done
  echo "[WARN] Failed to detach ${mp} after retries"
  return 1
}

cleanup() {
  if [ -n "${MP:-}" ]; then
      detach_mp "$MP" || true
  fi

  if [ -n "${WD:-}" ] && [ -d "$WD" ]; then
    echo "[INFO] Removing ${WD}..."
    rm -rf "$WD" >/dev/null 2>&1 || true
  fi
}
trap 'cleanup' EXIT INT TERM HUP

# Temp workspace
WD="$(mktemp -d)"
DMG_PATH="${WD}/${APP_NAME}.dmg"
echo "[INFO] Working in ${WD}"

# Download
echo "[INFO] Downloading ${DMG_URL}"
if ! curl --fail --location --silent --show-error -o "${DMG_PATH}" "${DMG_URL}"; then
  echo "[ERROR] Failed to download: ${DMG_URL}"
  exit 1
fi

# Mount DMG
MP="${WD}/mountpoint"
mkdir -p "${MP}"
if ! hdiutil attach "$DMG_PATH" -nobrowse -mountpoint "${MP}" >/dev/null; then
  echo "[ERROR] Failed to attach DMG: $DMG_PATH"
  exit 1
fi

echo "[INFO] Attached DMG at ${MP}"

# Copy to /Applications
echo "[INFO] Installing ${APP_NAME}..."
ditto --noqtn "${MP}/${APP_NAME}.app" "${APP_PATH}"

# Post-install check
if [ -d "${APP_PATH}" ]; then
  echo "[INFO] ${APP_NAME} installed."
else
  echo "[WARN] ${APP_NAME} not detected in /Applications."
fi
