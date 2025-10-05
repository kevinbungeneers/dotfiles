#! /usr/bin/env sh
#
# 1password.sh - Install the latest version of 1Password on macOS.

set -eu
( set -o pipefail ) >/dev/null 2>&1 && set -o pipefail || true

APP_NAME="1Password"
APP_PATH="/Applications/${APP_NAME}.app"
ZIP_URL="https://downloads.1password.com/mac/${APP_NAME}.zip"

# Exit early if already installed
if [ -d "${APP_PATH}" ]; then
  echo "[INFO] ${APP_NAME} is already installed. Nothing to do."
  exit 0
fi

# Requirements
for cmd in curl unzip open; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "[ERROR] Required command not found: ${cmd}"
    exit 1
  fi
done

# Setup cleanup trap
WD=""
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
echo "[INFO] Unzipping"
if ! unzip -q "${ZIP_PATH}" -d "${WD}"; then
  echo "[ERROR] Failed to unzip: ${ZIP_PATH}"
  exit 1
fi

# Find installer app
INSTALLER_PATH="${WD}/${APP_NAME} Installer.app"
if [ -z "${INSTALLER_PATH}" ] || [ ! -d "${INSTALLER_PATH}" ]; then
  echo "[ERROR] Installer app not found after unzip."
  exit 1
fi

# Launch installer and wait
echo "[INFO] Launching installer: ${INSTALLER_PATH}"
echo "[INFO] Waiting for the installer to quit; temporary files will be cleaned up afterward."
open -W "${INSTALLER_PATH}" || true

# Post-install check
if [ -d "${APP_PATH}" ]; then
  echo "[INFO] ${APP_NAME} installed."
else
  echo "[WARN] ${APP_NAME} not detected in /Applications after installer closed."
fi
