FROM alpine:3.12.1

RUN apk update && apk upgrade && apk add influxdb

EXPOSE 8086

ENTRYPOINT influxd run
