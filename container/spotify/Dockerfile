FROM debian:jessie-slim
MAINTAINER Malte Deiseroth <mdeiseroth88@gmail.com>

RUN apt-get update -qq
RUN apt-get install -yqq libasound2 libvorbisfile3 curl unzip
RUN curl -LOk `curl --silent https://api.github.com/repos/spotifyd/spotifyd/releases/latest | /usr/bin/awk '/browser_download_url/ { print $2 }' | grep amd64 | /bin/sed 's/"//g'` > /tmp/spotifyd.zip
RUN unzip /*.zip -d /usr/bin

RUN rm /*.zip
ADD entrypoint.sh /usr/bin
Add spotifyd.conf /etc/spotifyd.conf
ADD asound.conf /etc/asound.conf

CMD ["/usr/bin/entrypoint.sh"]
