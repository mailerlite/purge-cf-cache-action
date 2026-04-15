FROM golang:1.26-alpine@sha256:2389ebfa5b7f43eeafbd6be0c3700cc46690ef842ad962f6c5bd6be49ed82039 AS base
WORKDIR /src
COPY . /src
RUN CGO_ENABLED=0 go build -o cfpurge

FROM gcr.io/distroless/base@sha256:c83f022002fc917a92501a8c30c605efdad3010157ba2c8998a2cbf213299201
WORKDIR /app
COPY --from=base /src/cfpurge /app
ENTRYPOINT ["/app/cfpurge"]
