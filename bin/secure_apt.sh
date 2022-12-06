#!/bin/bash

# Force Debian to use HTTPS
cp /etc/apt/sources.list /etc/apt/sources.list.bak
sed --in-place 's|http://|https://|g' /etc/apt/sources.list

# Update the package listing, so we know what package exist:
apt-get update

# Install security updates:
apt-get -y upgrade

# Install package to handle APT over HTTPS
apt-get -y install --no-install-recommends apt-transport-https
