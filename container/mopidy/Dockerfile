FROM alpine:3.8

RUN mkdir /etc/default && mkdir /etc/mopidy

##  Copy fallback configuration.
COPY mopidy.conf /etc/default/mopidy.conf

#  Copy default configuration.
COPY mopidy.conf /etc/mopidy/mopidy.conf

# Copy helper script.
COPY entrypoint.sh /entrypoint.sh

RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  mopidy

# I cant explain why, but to me it seems
# I have less pause in streams if I
# also install these. However image size
# also grows by about 80MB
#RUN apk add --no-cache \
#  gst-plugins-base0.10 \
#  gst-plugins-good0.10 \
#  gst-plugins-ugly0.10 \
#  py-gst0.10

## Install Pip to install extensions
RUN apk add --no-cache \
  py-pip \
  && pip install --upgrade pip

## Install extensions
RUN pip install -U Mopidy-MusicBox-Webclient

VOLUME ["/etc/mopidy", "/var/lib/mopidy"]

EXPOSE 6600 6680 5555/udp

ENTRYPOINT ["/entrypoint.sh"]
