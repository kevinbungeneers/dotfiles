#! /usr/bin/env sh
#
# sublime_text.sh - Install Sublime Text on macOS.

set -eu
( set -o pipefail ) >/dev/null 2>&1 && set -o pipefail || true

APP_NAME="Sublime Text"
APP_PATH="/Applications/${APP_NAME}.app"
BUILD_VERSION="4200" # No way to automatically determine the latest version, check https://www.sublimetext.com/download
ZIP_URL="https://download.sublimetext.com/sublime_text_build_${BUILD_VERSION}_mac.zip"

# Exit early if already installed
if [ -d "${APP_PATH}" ]; then
  echo "[INFO] ${APP_NAME} is already installed. Nothing to do."
  exit 0
fi

# Requirements
for cmd in curl unzip ditto; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "[ERROR] Required command not found: ${cmd}"
    exit 1
  fi
done

# Setup cleanup trap
WD="" # Workdir
cleanup() {
  if [ -n "${WD:-}" ] && [ -d "$WD" ]; then
    echo "[INFO] Removing ${WD}..."
    rm -rf "$WD" >/dev/null 2>&1 || true
  fi
}
trap 'cleanup' EXIT INT TERM HUP

# Temp workspace
WD="$(mktemp -d)"
ZIP_PATH="${WD}/${APP_NAME}.zip"
echo "[INFO] Working in ${WD}"

# Download
echo "[INFO] Downloading ${ZIP_URL}"
if ! curl --fail --location --silent --show-error -o "${ZIP_PATH}" "${ZIP_URL}"; then
  echo "[ERROR] Failed to download: ${ZIP_URL}"
  exit 1
fi

# Unzip
if ! unzip -q "${ZIP_PATH}" -d "${WD}"; then
    echo "[ERROR] Failed to unzip: ${ZIP_PATH}"
    exit 1
fi

# Install application
ditto --noqtn "${WD}/${APP_NAME}.app" "/Applications/"

# Post-install check
if [ -d "${APP_PATH}" ]; then
  echo "[INFO] ${APP_NAME} installed."
else
  echo "[WARN] ${APP_NAME} not detected in /Applications."
fi
