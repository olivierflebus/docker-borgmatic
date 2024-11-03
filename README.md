# Borgmatic Container
<img src="https://github.com/witten/borgmatic/raw/master/docs/static/borgmatic.png" />
<br>
<img src="https://img.shields.io/github/issues/b3vis/docker-borgmatic" />
<img src="https://img.shields.io/github/stars/b3vis/docker-borgmatic" />
<img src="https://img.shields.io/docker/stars/b3vis/borgmatic" />
<img src="https://img.shields.io/docker/build/b3vis/borgmatic" />
<img src="https://img.shields.io/docker/pulls/b3vis/borgmatic" />

### Description

This is a fork of the b3vis docker-borgmatic image (https://github.com/b3vis/docker-borgmatic) that I've rebased to python:3.8-slim-buster (and then upgraded to bullseye, and then bookworm), as the alpine base has serious performance issues over ssh on my unraid system (don't know why).

With this simple modification I'm able to go from 1 MB/s to 50 MB/s between my two borg machines.

Speed issues (and fix) can also be observed just running scp between the two machines. So it seems it's not borg's fault ;-)


### Usage
General instructions can be found in the base image [README](./base/README.md).

### Build the image

```
cd base
docker build --no-cache --pull -t whatyouwant/docker-borgmatic .
```
