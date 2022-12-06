#!/bin/bash

set -euo pipefail

# Tell apt-get we're never going to be able to give manual feedback:
export DEBIAN_FRONTEND=noninteractive

# Install a new package, without unnecessary recommended packages:
apt-get -y install --no-install-recommends tini

# Delete cached files we don't need anymore:
apt-get clean
rm -rf /var/lib/apt/lists/*
