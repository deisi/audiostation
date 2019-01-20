[![Build Status](https://travis-ci.org/deisi/audiostation.svg?branch=master)](https://travis-ci.org/deisi/audiostation)

# Audiostation

Opensource multiroom audio project. Easy to install and use.

Provides the following:
- [Mopidy](https://www.mopidy.com/): local data and web radio stations
- [Spotifyd](https://github.com/Spotifyd/spotifyd): [Spotify
Connect](https://www.spotify.com/de/connect/) compatibility
- [upmpdcli](https://www.lesbonscomptes.com/upmpdcli/): upnp/dlna streaming
- [SnapCast](https://github.com/badaix/snapcast): syncronous playback on multiple clients

## Quickstart
Install docker and docker-compose.
```
git clone https://github.com/deisi/audiostation.git
cd audiostation
sudo docker-compose up -d
```

Run [snapcasts](https://github.com/badaix/snapcast) snapclient on various
clients throughout your house and enjoy synchronous playback. Possible clients
are Raspberrypis, Android phones, mips devices like routers or any x86 pc that
runs linux. Take a look at https://github.com/badaix/snapcast/releases for ready
to use releases.

Open spotify and play audio via Audiostation on all snapclients. Use
[bubbleupnp](https://play.google.com/store/apps/details?id=com.bubblesoft.android.bubbleupnp&hl=de)
or any other upnp controller software to play audio from your cell phone or [
kodi ](https://kodi.tv/) throughout your house. Open
[http://localhost:6680](http://localhost:6680) on the Audiostation server and
use the Mopdiy web interface.

## Configure
Adjust `docker-compose.yml` or add a ``docker-compose.overwrite.yml`.

## Goal

I have been playing around with multiroom-audio-solutions for quite some time.
However, I never found them very satisfying. They are often proprietary and work
only for a very limited set of hardware, or they are not reliable, extremely
difficult to configure or all at once. My goal is to provide a docker based
"ready to use" solution, that allows for flexible configuration but at the same
time just works. 

From experience I know, that snapcast is an excellent program to share audio
around in the local network. It is lightweight and reliable and synchronous.
However it is rarely implemented into any project right away. Instead one can
convince almost any program into sending its audio to snapcast, either via
`alsa`, `pulseaudio` or in a direct fashion via piping the audio into a `fifo`.

The goal of this project is to simplify the setup of such a system. Instead of
configuring each player (mopidy, spotify, dlna, airplay,...) individually a
`docker-compose.yml` stack will be provided and this already interconnects all
the players. It is then up to the user to decide weather she wants all of the
player at once or just some.

## Plans

- Airplay via [Shairport-Sync](https://github.com/mikebrady/shairport-sync) 
- pulseaudio
- armhf builds for raspberrypis
- ready to use clients
- Suggestions?


## About

[Snapcast](https://github.com/badaix/snapcast) is the core of the
project. It allows to stream music from one server (*snapserver*) to multiple
clients (*snapclient*). Each client needs to run an instance of the *snapclient*
program from the [Snapcast](https://github.com/badaix/snapcast) project.
Currently [Snapcast](https://github.com/badaix/snapcasst) supports **Android**,
**amd64**(Linux), **armhf**(Raspberrypi) and **mips**(Router). A Windows Client
is planned but not released yet.

Snapcast adds a delay of about 1s to its audio pipeline. If you want to be able
to watch video with this, you need to find a way to delay the video by the same
amount of time. If you want to play an ego shooter game with this you will be
disapointed. Snapcast provides no way of "realtime" processing, as large buffers
are build in to cope with bad network/soundcard constrains.

As players [Mopidy](https://www.mopidy.com/) and
[Spotifyd](https://github.com/Spotifyd/spotifyd) are used but more are planned. 


### Dockerimages

The Dockerimages of the player share a common fifo at
`/tmp/sharesound/snapfifo`. On Docker the fifo file will be create by a data
container, all containers share a
[volume](https://docs.docker.com/compose/compose-file/#volumes) which contains
the shared file. Containers are pre configured to pipe audio into the fifo
for out of the box functionality.

Containers should be as small as possible and thus based on alpine if possible. 

#### Docker Hub Used Images

**amd64**
- https://hub.docker.com/r/audiostation/snapcast
- https://hub.docker.com/r/audiostation/spotify
- https://hub.docker.com/r/audiostation/mopidy
- https://hub.docker.com/r/audiostation/upmpdcli


## Credits
Its a fork of https://github.com/nolte/docker_compose-audiostation.
