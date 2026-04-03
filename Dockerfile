FROM golang:1.26-alpine@sha256:2389ebfa5b7f43eeafbd6be0c3700cc46690ef842ad962f6c5bd6be49ed82039 AS base
WORKDIR /src
COPY . /src
RUN CGO_ENABLED=0 go build -o cfpurge

FROM gcr.io/distroless/base
WORKDIR /app
COPY --from=base /src/cfpurge /app
ENTRYPOINT ["/app/cfpurge"]
