ARG DOCKER_DEFAULT_PLATFORM
ARG GO_VERSION
FROM --platform=$DOCKER_DEFAULT_PLATFORM golang:${GO_VERSION} as compile-image

ARG TOPICCTL_VERSION

LABEL org.opencontainers.image.authors="telemetry@digital.hmrc.gov.uk"
LABEL version.golang="${GO_VERSION}"
LABEL version.topicctl="${TOPICCTL_VERSION}"

COPY bin/install_build_tools.sh ./
RUN ./install_build_tools.sh -t ${TOPICCTL_VERSION}

FROM --platform=$DOCKER_DEFAULT_PLATFORM ubuntu:latest AS build-image
COPY --from=compile-image /go/bin/topicctl /bin/topicctl

COPY bin/install_packages.sh ./
RUN ./install_packages.sh

# Taken from GitHub source
# https://github.com/segmentio/topicctl/blob/master/Dockerfile
ENTRYPOINT ["/bin/topicctl"]
