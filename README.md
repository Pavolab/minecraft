# Minecraft

A docker image for minecraft server

[![MicroBadger Size](https://img.shields.io/microbadger/image-size/pavolab/minecraft.svg?style=flat-square)](https://microbadger.com/#/images/pavolab/minecraft)
[![Docker Automated build](https://img.shields.io/docker/automated/pavolab/minecraft.svg?style=flat-square)](https://hub.docker.com/r/pavolab/minecraft/)
[![Docker Build Status](https://img.shields.io/docker/build/pavolab/minecraft.svg?style=flat-square)](https://hub.docker.com/r/pavolab/minecraft/)
[![GitHub](https://img.shields.io/github/license/pavolab/minecraft.svg?style=flat-square)](https://github.com/pavolab/minecraft/blob/master/LICENSE)
![Minecraft Version](https://img.shields.io/badge/Minecraft-1.13.2-blue.svg?style=flat-square)

## Running the Container

First create a named data volume to hold the persistent world and config data:

```bash
docker volume create --name minecraft-data
```

```bash
docker run -d -p 25565:25565 -v minecraft-data:/etc/minecraft --name minecraft-server pavolab/minecraft
```

## Optional 'docker run' Arguments

`-e _JAVA_OPTIONS='-Xms256M -Xmx2048M'` - Set JVM arguments for minimum/maximum memory consumption    (default: '-Xms256M -Xmx2048M')

`-e TZ=America/Phoenix` - Set the timezone for your server. You can find your timezone in this [list of timezones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List). Use the (case sensitive) value from the `TZ` column. If left unset, timezone will be UTC.

`--restart unless-stopped` - Always restart the container regardless of the exit status, but do not start it on daemon startup if the container has been put to a stopped state before. See the Docker [restart policies](https://docs.docker.com/engine/reference/run/#restart-policies---restart) for additional details.

**NOTE:** See the [Minecraft Wiki](http://minecraft.gamepedia.com/Server/Requirements) for more info
on memory requirements.

## Editing the Server Config

Once you have a running container, you can edit the Minecraft server config with `/opt/minecraft`

After saving changes, restart your container with `docker restart minecraft-server`

**However, I recommend that you upload to `/opt/minecraft` after the local editing is complete.**

## Adding OPs

Once you have a running server container you can add OPs by running:

```bash
docker exec minecraft-server ops [PLAYER_NAMES]
```

**NOTE:** Replace `[PLAYER_NAMES]` with the name of one or more players you wish to give OP
privileges separated by a space. If a players name contains spaces wrap it in quotation marks.

Here's an example granting OP to three players with name's `Marty`, `Jennifer` and  `Doc Brown`:

```bash
docker exec minecraft-server ops Marty Jennifer "Doc Brown"
```

## Upgrading the Server

First pull down the latest image:

```bash
docker pull pavolab/minecraft
```

Remove your running server container:

```bash
docker rm -f minecraft-server
```

And run a new one with the same command/arguments as before.
