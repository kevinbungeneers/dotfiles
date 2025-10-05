#! /usr/bin/env sh
#
# batt.sh - Install or upgrades batt on macOS.

set -eu
( set -o pipefail ) >/dev/null 2>&1 && set -o pipefail || true

INSTALL_SCRIPT=$(mktemp)
INSTALL_SCRIPT_URL="https://github.com/charlie0129/batt/raw/master/hack/install.sh"

# Requirements
for cmd in curl bash; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "[ERROR] Required command not found: ${cmd}"
    exit 1
  fi
done

cleanup() {
  if [ -n "${INSTALL_SCRIPT:-}" ] && [ -f "$INSTALL_SCRIPT" ]; then
    echo "[INFO] Removing ${INSTALL_SCRIPT}..."
    rm -rf "$INSTALL_SCRIPT" >/dev/null 2>&1 || true
  fi
}
trap 'cleanup' EXIT INT TERM HUP

# Download
echo "[INFO] Downloading ${INSTALL_SCRIPT_URL}"
if ! curl --fail --location --silent --show-error -o "${INSTALL_SCRIPT}" "${INSTALL_SCRIPT_URL}"; then
  echo "[ERROR] Failed to download: ${INSTALL_SCRIPT_URL}"
  exit 1
fi

# Execute the downloaded script.
bash "$INSTALL_SCRIPT"
