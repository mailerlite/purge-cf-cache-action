FROM golang:1.26-alpine@sha256:f85330846cde1e57ca9ec309382da3b8e6ae3ab943d2739500e08c86393a21b1 AS base
WORKDIR /src
COPY . /src
RUN CGO_ENABLED=0 go build -o cfpurge

FROM gcr.io/distroless/base
WORKDIR /app
COPY --from=base /src/cfpurge /app
ENTRYPOINT ["/app/cfpurge"]
