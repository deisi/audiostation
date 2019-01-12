# Audiostation Docker

Network Audio Player with  [Mopidy](https://www.mopidy.com/) and [SnapCast](https://github.com/badaix/snapcast).

Use [UPnP](https://wikipedia.org/wiki/Universal_Plug_and_Play) for receiving the Music from Mobile Devices ([BubbleUPnP](https://play.google.com/store/apps/details?id=com.bubblesoft.android.bubbleupnp)) or other clients.

## Configure
Adjust `docker-compose.yml`. Specific configurations go into
`docker-compose.overwrite.yml`.

## Starting
```
docker-compose up
```

after the containers are running you can open [http://localhost:6680](http://localhost:6680) and use the Mopdiy webfrontend.

**don`t forget** Mopidy has a [HTTP JSON-RPC API](https://docs.mopidy.com/en/latest/api/http/) and can be integrated to [home-assistant.io](https://home-assistant.io/components/media_player.mpd/).

**Tested Android UPnP Apps**

- [BubbleUPnP](https://play.google.com/store/apps/details?id=com.bubblesoft.android.bubbleupnp),  works so good that i bought the Full Version, and did not test more apps.

## Structure


#### Used Dockerimages

The Connection between the Moidy Container and the [SnapCast Server](https://github.com/badaix/snapcast) runs over a gstreamer fifo file, configured as output in Mopidy.

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
- https://hub.docker.com/r/nolte/snapcast-server/
- https://hub.docker.com/r/nolte/snapcast-client/
- https://hub.docker.com/r/nolte/mopidy/
- https://hub.docker.com/r/nolte/upmpdcli/

