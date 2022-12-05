#!/usr/bin/env bash
set -eo pipefail

export DOCKER_BUILDKIT=1

if [[ -z "${GO_VERSION}" ]]; then
  echo "GO_VERSION not set"
  exit 1
fi

if [[ -z "${TOPICCTL_VERSION}" ]]; then
  echo "TOPICCTL_VERSION not set"
  exit 1
fi

ECR_REPO=634456480543.dkr.ecr.eu-west-2.amazonaws.com
IMAGE_NAME=$ECR_REPO/topicctl
IMAGE_TAG="${TOPICCTL_VERSION}"

# Use branch+commit for tagging:
docker build --tag "$IMAGE_NAME:$IMAGE_TAG" \
             --platform "${DOCKER_DEFAULT_PLATFORM}" \
             --build-arg BUILDKIT_INLINE_CACHE=1 \
             --build-arg DOCKER_DEFAULT_PLATFORM="${DOCKER_DEFAULT_PLATFORM}" \
             --build-arg GO_VERSION="${GO_VERSION}" \
             --build-arg TOPICCTL_VERSION="${TOPICCTL_VERSION}" \
             .

# Security scanners:
trivy image --exit-code 0 --ignorefile "$(pwd)/.trivyignore" --ignore-unfixed --severity MEDIUM,HIGH "$IMAGE_NAME:$IMAGE_TAG"
trivy image --exit-code 1 --ignorefile "$(pwd)/.trivyignore" --ignore-unfixed --severity CRITICAL "$IMAGE_NAME:$IMAGE_TAG"

if [[ -z "${SKIP_ECR_PUSH}" ]]; then
  # Login and push to the registry:
  aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin $ECR_REPO
  docker push "$IMAGE_NAME:$IMAGE_TAG"
fi
