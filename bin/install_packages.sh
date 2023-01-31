#!/bin/sh

# Tell apt-get we're never going to be able to give manual feedback:
export DEBIAN_FRONTEND=noninteractive

# Update the package listing, so we know what package exist:
apt-get update

# Install security updates:
apt-get -y upgrade

# Install packages required by Fargate to enable AWS ECS Exec:
apt-get -y install --no-install-recommends coreutils util-linux

# Delete cached files we don't need anymore:
apt-get clean
rm -rf /var/lib/apt/lists/*
