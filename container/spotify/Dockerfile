FROM multiarch/debian:jessie-slim
MAINTAINER Malte Deiseroth <mdeiseroth88@gmail.com>
ARG VERSION="v0.2.3"
# for some reason there is a version and a date o.O
ARG DATE="2018-10-21"
#amd64|armv6
ARG ARCH


RUN apt-get update -qq
RUN apt-get install -yqq libasound2 libvorbisfile3 unzip wget
RUN wget https://github.com/Spotifyd/spotifyd/releases/download/$VERSION/spotifyd-$DATE-$ARCH.zip > /tmp/spotifyd.zip
RUN unzip /*.zip -d /usr/bin
RUN apt-get remove -y --purge unzip wget
RUN apt-get autoremove -y

RUN rm /*.zip
ADD entrypoint.sh /usr/bin
Add spotifyd.conf /etc/spotifyd.conf
ADD asound.conf /etc/asound.conf

CMD ["/usr/bin/entrypoint.sh"]
