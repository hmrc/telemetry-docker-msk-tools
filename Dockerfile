ARG DOCKER_DEFAULT_PLATFORM
FROM --platform=$DOCKER_DEFAULT_PLATFORM golang:alpine as kaf-image
RUN go install github.com/birdayz/kaf/cmd/kaf@latest

FROM --platform=$DOCKER_DEFAULT_PLATFORM dockerhub.tax.service.gov.uk/segment/topicctl as topicctl-image

FROM --platform=$DOCKER_DEFAULT_PLATFORM dockerhub.tax.service.gov.uk/alpine:latest AS build-image

COPY --from=kaf-image /go/bin/kaf /bin/kaf
RUN mkdir /root/.kaf
RUN ln -s /etc/kaf_config /root/.kaf/config

COPY --from=topicctl-image /bin/topicctl /bin/topicctl
