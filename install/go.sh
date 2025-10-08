#! /usr/bin/env sh

set -eu
( set -o pipefail ) >/dev/null 2>&1 && set -o pipefail || true

# Check if 'mise' is installed
if [ -z "$(command -v mise)" ]; then
    echo "'mise' is not installed. Please install it before running this script."
    exit 1
fi

# Install the latest version of Go
mise use -g go@latest

GOPATH="${HOME}/Developer/.go"

# Make sure our $GOPATH exists
mkdir -p "${GOPATH}"

# Set Go env variables; we're using mise exec because the go binary hasn't been added to the $PATH yet.
mise exec -- go env -w GOPATH=$GOPATH
mise exec -- go env -w CGO_ENABLED=0
mise exec -- go env -w GOTOOLCHAIN=local
