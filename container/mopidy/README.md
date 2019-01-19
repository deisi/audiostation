[![](https://images.microbadger.com/badges/image/audiostation/mopidy.svg)](https://microbadger.com/images/audiostation/mopidy "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/audiostation/mopidy.svg)](https://microbadger.com/images/audiostation/mopidy "Get your own version badge on microbadger.com")
[![Build Status](https://travis-ci.org/deisi/audiostation-mopidy.svg?branch=master)](https://travis-ci.org/deisi/audiostation-mopidy)

This is the mopidy container for the [audiostation](https://github.com/deisi/audiostation) project. Documentation here might be wrong.

What is Mopidy?
===============

[**Mopidy**](https://www.mopidy.com/) is a music server with support for [MPD clients](https://docs.mopidy.com/en/latest/clients/mpd/) and [HTTP clients](https://docs.mopidy.com/en/latest/ext/web/#ext-web).

Features of this image
----------------------

  * Follows [official installation](https://docs.mopidy.com/en/latest/installation/debian/) on top of [Debian](https://registry.hub.docker.com/_/debian/).
  * With backend extensions for:
  * [Mopidy-Webclient](https://github.com/pimusicbox/mopidy-musicbox-webclient)

You may install additional [backend extensions](https://docs.mopidy.com/en/latest/ext/backends/).

Usage
-----

### Playing sound from the container

There are various ways to have the audio from Mopidy running in your container
to play on your system's audio output. Here are various ways, try them and find
which one works for you.

#### /dev/snd

Simplest is by adding docker argument: `--device /dev/snd`. Try via:

    $ docker run --rm \
        --user root --device /dev/snd \
        audiostation/mopidy \
        gst-launch-1.0 audiotestsrc ! audioresample ! autoaudiosink

### General usage

    $ docker run -d \
        $PUT_HERE_EXRA_DOCKER_ARGUMENTS_FOR_AUDIO_TO_WORK \
        -v "$PWD/media:/var/lib/mopidy/media:ro" \
        -v "$PWD/local:/var/lib/mopidy/local" \
        -p 6600:6600 -p 6680:6680 \
        --user $UID:$GID \
        audiostation/mopidy \
        mopidy \

Most arguments are optional (see some examples below):

  * Docker arguments:
      * `$PUT_HERE_EXRA_DOCKER_ARGUMENTS_FOR_AUDIO_TO_WORK` should be replaced
        with some arguments that work to play audio from within the docker
        container as tested above.
      * `-v ...:/var/lib/mopidy/media:ro` - (optional) Path to directory with
        local media files.
      * `-v ...:/var/lib/mopidy/local` - (optional) Path to directory to store
        local metadata such as libraries and playlists in.
      * `-p 6600:6600` - (optional) Exposes MPD server (if you use for example
        ncmpcpp client).
      * `-p 6680:6680` - (optional) Exposes HTTP server (if you use your browser
        as client).
      * `-p 5555:5555/udp` - (optional) Exposes [UDP streaming for FIFE
        sink](https://github.com/mopidy/mopidy/issues/775) (e.g. for
        visualizers).
      * `--user $UID:$GID` - (optional) You may run as any UID/GID, and by
        default it'll run as UID/GID `84044` (`mopidy:audio` from within the
        container). The main restriction is if you want to read local media
        files: That the user (UID) you run as should have read access to these
        files. Similar for other mounts. If you have issues, try first as
        `--user root`.
  * Mopidy arguments (see [mopidy's
    command](https://docs.mopidy.com/en/latest/command/) for possible additional
    options), replace `USERNAME`, `PASSWORD`, `TOKEN` accordingly if needed, or
    disable services (e.g., `-o spotify/enabled=false`):

NOTE: Any user on your system may run `ps aux` and see the command-line you're
running, so your passwords may be exposed. A safer option if it's a concern, is
using putting these passwords in a Mopidy configuration file based on
[mopidy.conf](mopidy.conf):

    [core]
    data_dir = /var/lib/mopidy

    [local]
    media_dir = /var/lib/mopidy/media

    [audio]
    output = tee name=t ! queue ! autoaudiosink t. ! queue ! udpsink host=0.0.0.0 port=5555

    [m3u]
    playlists_dir = /var/lib/mopidy/playlists

    [http]
    hostname = 0.0.0.0

    [mpd]
    hostname = 0.0.0.0

Then run it:

    $ docker run -d \
        $PUT_HERE_EXRA_DOCKER_ARGUMENTS_FOR_AUDIO_TO_WORK \
        -v "$PWD/media:/var/lib/mopidy/media:ro" \
        -v "$PWD/local:/var/lib/mopidy/local" \
        -v "$PWD/mopidy.conf:/config/mopidy.conf" \
        -p 6600:6600 -p 6680:6680 \
        --user $UID:$GID \
        audiostation/mopidy


##### Example using HTTP client to stream local files

 1. Give read access to your audio files to user **84044**, group **84044**, or
    all users (e.g., `$ chgrp -R 84044 $PWD/media && chmod -R g+rX $PWD/media`).
 2. Index local files:

        $ docker run --rm \
            --device /dev/snd \
            -v "$PWD/media:/var/lib/mopidy/media:ro" \
            -v "$PWD/local:/var/lib/mopidy/local" \
            -p 6680:6680 \
            audiostation/mopidy mopidy local scan

 3. Start the server:

        $ docker run -d \
            -e "PULSE_SERVER=tcp:$(hostname -i):4713" \
            -e "PULSE_COOKIE_DATA=$(pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*')" \
            -v "$PWD/media:/var/lib/mopidy/media:ro" \
            -v "$PWD/local:/var/lib/mopidy/local" \
            -p 6680:6680 \
            audiostation/mopidy

 4. Browse to http://localhost:6680/

#### Example using [ncmpcpp](https://docs.mopidy.com/en/latest/clients/mpd/#ncmpcpp) MPD console client

    $ docker run --name mopidy -d \
        -v /run/user/$UID/pulse:/run/user/105/pulse \
        wernight/mopidy
    $ docker run --rm -it --net container:mopidy audiostation/ncmpcpp ncmpcpp

Alternatively if you don't need visualizers you can do:

    $ docker run --rm -it --link mopidy:mopidy audiostation/ncmpcpp ncmpcpp --host mopidy


### Feedbacks

Having more issues? [Report a bug on
GitHub](https://github.com/wernight/docker-mopidy/issues). Also if you need some
additional extensions/plugins that aren't already installed (please explain
why).
