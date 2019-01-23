ARG FROMIMAGE
FROM $FROMIMAGE

RUN mkdir /etc/default && mkdir /etc/mopidy

RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    mopidy \
  && apk add --no-cache py-pip \
  && pip install --upgrade pip \
  && pip install -U Mopidy-MusicBox-Webclient

##  Copy fallback configuration.
COPY mopidy.conf /etc/default/mopidy.conf

#  Copy default configuration.
COPY mopidy.conf /etc/mopidy/mopidy.conf

# Copy helper script.
COPY entrypoint.sh /entrypoint.sh

VOLUME ["/data", "/cache"]

EXPOSE 6600 6680 5555/udp

ENTRYPOINT ["/entrypoint.sh"]
