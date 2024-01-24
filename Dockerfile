ARG DOCKER_DEFAULT_PLATFORM
ARG GO_VERSION
FROM --platform=$DOCKER_DEFAULT_PLATFORM golang:${GO_VERSION} as kaf-image
RUN go install github.com/birdayz/kaf/cmd/kaf@latest

FROM --platform=$DOCKER_DEFAULT_PLATFORM dockerhub.tax.service.gov.uk/segment/topicctl as topicctl-image

FROM --platform=$DOCKER_DEFAULT_PLATFORM dockerhub.tax.service.gov.uk/alpine:latest AS build-image
COPY --from=kaf-image /go/bin/kaf /bin/kaf
COPY --from=topicctl-image /bin/topicctl /bin/topicctl

ENTRYPOINT ["/bin/topicctl"]
