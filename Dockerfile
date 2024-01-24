ARG DOCKER_DEFAULT_PLATFORM
FROM --platform=$DOCKER_DEFAULT_PLATFORM dockerhub.tax.service.gov.uk/segment/topicctl as topicctl-image

FROM --platform=$DOCKER_DEFAULT_PLATFORM dockerhub.tax.service.gov.uk/alpine:latest AS build-image
COPY --from=topicctl-image /bin/topicctl /bin/topicctl

ENTRYPOINT ["/bin/topicctl"]
