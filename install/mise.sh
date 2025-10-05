#! /usr/bin/env sh
#
# mise.sh - Install mise-en-place.

set -eu
( set -o pipefail ) >/dev/null 2>&1 && set -o pipefail || true

if command -v mise >/dev/null 2>&1; then
  echo "[INFO] mise already installed. Nothing to do."
  exit 0
fi

curl https://mise.run | sh
