# renovate: datasource=docker depName=europe-docker.pkg.dev/mailerlitehub/base-images/go
ARG BASE_IMAGE=europe-docker.pkg.dev/mailerlitehub/base-images/go:v1.0.10-1.26@sha256:352ef790f0893ea4b4f69b559c5d31828d4b88e0cacca2e2a23a45653305c4e1
FROM ${BASE_IMAGE} AS build

WORKDIR /src
COPY . /src

RUN CGO_ENABLED=0 go build -o cfpurge

# renovate: datasource=docker depName=europe-docker.pkg.dev/mailerlitehub/base-images/base
FROM europe-docker.pkg.dev/mailerlitehub/base-images/base:v1.0.17@sha256:6b254675c0aae0fdbc98e82620e247b000caff78366a457563023199a6d3d50b

WORKDIR /mlr
COPY --from=build /src/cfpurge /mlr/

USER 24128

ENTRYPOINT ["./cfpurge"]
