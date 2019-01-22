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
RUN cd /root
RUN git clone --recursive https://github.com/badaix/snapcast.git
RUN cd snapcast
RUN  git checkout tags/${SNAPCASTVERSION} -b ${SNAPCASTVERSION}
RUN make \
RUN cp server/snapserver client/snapclient /usr/local/bin
RUN cd /
RUN apk --purge del git bash build-base asio-dev bash avahi-dev flac-dev libvorbis-dev alsa-lib-dev
RUN apk add avahi-libs flac libvorbis alsa-lib
RUN rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /root/snapcast
