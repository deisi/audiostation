**This is currently under heavy development. It most likely will not work right now.**

# Audiostation Docker

Flexible multiroom audio project. Its a fork of
https://github.com/nolte/docker_compose-audiostation but adjusted for my needs.

[SnapCast](https://github.com/badaix/snapcast) for multiroom/speaker support,
[Mopidy](https://www.mopidy.com/) for local data, web radio stations and.
[Spotifyd](https://github.com/Spotifyd/spotifyd) for [Spotify
Connect](https://www.spotify.com/de/connect/) compatibility.

Use [UPnP](https://wikipedia.org/wiki/Universal_Plug_and_Play) for receiving the
Music from Mobile Devices
([BubbleUPnP](https://play.google.com/store/apps/details?id=com.bubblesoft.android.bubbleupnp))
or Spotify app to stream music in any room of your house

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

- [ ] Airplay via [Shairport-Sync](https://github.com/mikebrady/shairport-sync) 
- [ ] Upnp/DLNA via [upmpdcli](https://www.lesbonscomptes.com/upmpdcli/)
- Suggestions?

## Configure
Adjust `docker-compose.yml` or add a ``docker-compose.overwrite.yml`.

## Starting
From the folder with `docker-compose.yml`:
```
docker-compose up
```

after the containers are running you can open
[http://localhost:6680](http://localhost:6680) and use the Mopdiy webfrontend.

**don`t forget** Mopidy has a [HTTP JSON-RPC
API](https://docs.mopidy.com/en/latest/api/http/) and can be integrated to
[home-assistant.io](https://home-assistant.io/components/media_player.mpd/).

You can also play music from spotify via Spotifyd. Open the spotify app and take
a look at availabe player. Spotifyd should advertise itself right away.


**Tested Android UPnP Apps**

- [BubbleUPnP](https://play.google.com/store/apps/details?id=com.bubblesoft.android.bubbleupnp),
  works so good that i bought the Full Version, and did not test more apps.

## Structure

[Snapcast](https://github.com/badaix/snapcast) is the core of the
project. It allows to stream music from one server (*snapserver*) to multiple
clients (*snapclient*). Each client needs to run an instance of the *snapclient*
program from the [Snapcast](https://github.com/badaix/snapcast) project.
Currently [Snapcast](https://github.com/badaix/snapcasst) supports **Android**,
**amd64**(Linux), **armhf**(Raspberrypi) and **mips**(Router). A Windows Client
is planned but not released yet.

As players [Mopidy](https://www.mopidy.com/) and
[Spotifyd](https://github.com/Spotifyd/spotifyd) are used but more are planned. 


#### Used Dockerimages

The Dockerimages of the players share a common fifo at `/tmp/sharesound/snapfifo`

The Connection between the Moidy Container and the [SnapCast Server](https://github.com/badaix/snapcast) runs over a fifo file, configured as output in Mopidy.

```
...
[audio]
output = audioresample ! audioconvert ! audio/x-raw,rate=48000,channels=2,format=S16LE ! wavenc ! filesink location=/tmp/sharesound/snapfifo
...
```
form [snapcast player setup ](https://github.com/badaix/snapcast/blob/master/doc/player_setup.md#mopidy)


On Docker the fifo file will be create by a data container, all three containers share a [volume](https://docs.docker.com/compose/compose-file/#volumes) which contains the shared file.

##### Docker Hub Used Images

**amd64**
- https://hub.docker.com/r/audiostation/snapcast
- https://hub.docker.com/r/audiostation/spotify
- https://hub.docker.com/r/audiostation/mopidy

