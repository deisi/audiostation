ARG fromimage
FROM $fromimage

WORKDIR /data
ARG SNAPCASTVERSION=v0.15.0

RUN apk -U add \
  git \
  bash \
  build-base \
  asio-dev \
  avahi-dev \
  flac-dev \
  libvorbis-dev \
  alsa-lib-dev
RUN git clone --recursive https://github.com/badaix/snapcast.git \
  && cd snapcast \
  && git checkout tags/${SNAPCASTVERSION} -b ${SNAPCASTVERSION} \
  && make \
  && cp server/snapserver client/snapclient /usr/local/bin
RUN apk --purge del git bash build-base asio-dev bash avahi-dev flac-dev libvorbis-dev alsa-lib-dev
RUN apk add avahi-libs flac libvorbis alsa-lib
RUN rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /snapcast
