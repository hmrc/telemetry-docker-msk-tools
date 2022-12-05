#!/bin/sh

# Update the package listing, so we know what package exist:
apk update

# Install security updates:
apk upgrade

# Install packages required by Fargate to enable AWS ECS Exec:
apk add --no-cache coreutils util-linux

# Delete cached files we don't need anymore:
rm -rf /var/cache/apk/*
