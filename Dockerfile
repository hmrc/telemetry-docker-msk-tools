ARG DOCKER_DEFAULT_PLATFORM
FROM --platform=$DOCKER_DEFAULT_PLATFORM dockerhub.tax.service.gov.uk/golang:latest as compile-image

ARG TOPICCTL_VERSION

LABEL org.opencontainers.image.authors="telemetry@digital.hmrc.gov.uk"
LABEL version.topicctl="${TOPICCTL_VERSION}"

RUN go install "github.com/segmentio/topicctl/cmd/topicctl@${TOPICCTL_VERSION}"

FROM --platform=$DOCKER_DEFAULT_PLATFORM dockerhub.tax.service.gov.uk/ubuntu:latest AS build-image
COPY --from=compile-image /go/bin/topicctl /bin/topicctl

COPY bin/secure_apt.sh ./
RUN ./secure_apt.sh

COPY bin/install_base.sh ./
RUN ./install_base.sh

# Taken from GitHub source
# https://github.com/segmentio/topicctl/blob/master/Dockerfile
ENTRYPOINT ["/usr/local/bin/tini", "--", "/bin/topicctl"]
