FROM alpine:3.8

RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  python2 \
  upmpdcli

COPY upmpdcli.conf /etc/upmpdcli.conf
RUN adduser -S upmpdcli

EXPOSE 1900/udp
EXPOSE 49152

ENTRYPOINT ["upmpdcli"]
