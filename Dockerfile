# renovate: datasource=docker depName=europe-docker.pkg.dev/mailerlitehub/base-images/go
ARG BASE_IMAGE=europe-docker.pkg.dev/mailerlitehub/base-images/go:v1.0.17-1.26@sha256:05385270a9b003035331e01af8e9e7badbd6624834a5a7a8ebae45d81d3801e8
FROM ${BASE_IMAGE} AS build

WORKDIR /src
COPY . /src

RUN CGO_ENABLED=0 go build -o cfpurge

# renovate: datasource=docker depName=europe-docker.pkg.dev/mailerlitehub/base-images/base
FROM europe-docker.pkg.dev/mailerlitehub/base-images/base:v1.0.17

WORKDIR /mlr
COPY --from=build /src/cfpurge /mlr/

USER 24128

ENTRYPOINT ["./cfpurge"]
