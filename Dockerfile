# renovate: datasource=docker depName=europe-docker.pkg.dev/mailerlitehub/base-images/go
ARG BASE_IMAGE=europe-docker.pkg.dev/mailerlitehub/base-images/go:v1.0.11-1.26@sha256:4793070a51191682d4dd28f014b66d2bc0e33f4336dc518fd27f5b9d8558cae5
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
