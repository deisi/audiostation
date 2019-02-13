ARG FROMIMAGE
FROM $FROMIMAGE
MAINTAINER Malte Deiseroth <mdeiseroth88@gmail.com>
ARG BUILDARCH
ARG VERSION="v0.2.4"
# for some reason there is a version and a date o.O
ARG DATE="2018-10-21"


RUN apt-get update -qq \
  && apt-get install -yqq libasound2 libvorbisfile3 unzip wget \
  && wget https://github.com/Spotifyd/spotifyd/releases/download/$VERSION/spotifyd-$DATE-$BUILDARCH.zip > /tmp/spotifyd.zip \
  && unzip /*.zip -d /usr/bin \
  && apt-get remove -y --purge unzip wget \
  && apt-get autoremove -y \
  && rm /*.zip

ADD entrypoint.sh /usr/bin
Add spotifyd.conf /etc/spotifyd.conf
ADD asound.conf /etc/asound.conf

CMD ["/usr/bin/entrypoint.sh"]
