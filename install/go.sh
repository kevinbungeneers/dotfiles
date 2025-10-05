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

# Make sure our $GOPATH exists
mkdir -p $HOME/Developer/.go

go env -w GOPATH=$HOME/Developer/.go
go env -w CGO_ENABLED=0
go env -w GOTOOLCHAIN=local
