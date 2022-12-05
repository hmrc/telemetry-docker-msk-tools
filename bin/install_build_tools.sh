#!/bin/bash

set -euo pipefail

# Setup package versions
function usage {
  echo "Usage:      $0 [options]"
  echo "Required:"
  echo "  -t        The version of the topicctl tool to be installed."
  echo "Options:"
  echo "  -h        Show this help."
  exit 1
}

while getopts ":h:t:" opt; do
  case "${opt}" in
    t)
      TOPICCTL_VERSION=${OPTARG}
      ;;
    h | *) # Display help.
        usage
        exit 0
        ;;
  esac
done
shift $((OPTIND-1))

if [ -z "${TOPICCTL_VERSION}" ]; then
  echo "TOPICCTL_VERSION has not been set. Exiting."
  usage
fi

# Install topicctl:
go install "github.com/segmentio/topicctl/cmd/topicctl@${TOPICCTL_VERSION}"
