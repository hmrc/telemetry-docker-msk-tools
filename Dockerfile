FROM dockerhub.tax.service.gov.uk/golang:alpine AS kaf-image
RUN go install github.com/birdayz/kaf/cmd/kaf@latest

FROM dockerhub.tax.service.gov.uk/segment/topicctl AS topicctl-image

FROM dockerhub.tax.service.gov.uk/alpine:latest AS build-image

COPY --from=topicctl-image /bin/topicctl /bin/topicctl
COPY --from=kaf-image /go/bin/kaf /bin/kaf

RUN mkdir /root/.kaf
RUN ln -s /etc/kaf_config /root/.kaf/config
