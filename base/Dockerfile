# same functionality as b3vis/docker-borgmatic
# but with another base image
# cron in python docker image from https://github.com/fronzbot/docker-pycron/blob/master/Dockerfile

FROM python:3.11.4-slim-bullseye

# from official borgbackup from source
# but assuming python is already installed

# borgmatic needs cron
# we need also openssh-client
# we need tzdata to use the TZ variable
RUN apt-get update && apt upgrade -y && \
    apt-get install --no-install-recommends -y \
    curl \
    cron \ 
    rsyslog \
    logrotate \
    libssl-dev \ 
    openssl \
    libacl1-dev \
    libacl1 \
    build-essential \
    openssh-client \
    libfuse3-dev fuse3 pkg-config python3-pkgconfig \
    tzdata \   
    && apt-get clean \
    && rm -rf /var/lib/apt/lists


RUN pip3 install -U pip setuptools wheel
RUN pip3 install pkgconfig
RUN pip3 install borgbackup[pyfuse3]
RUN pip3 install borgmatic

COPY entry.sh /entry.sh
RUN chmod 755 /entry.sh

COPY rsyslog.conf /etc/rsyslog.conf
RUN chmod 755 /entry.sh


# User Shares (Read-only Backup Source) 
VOLUME /mnt/source

# Borg Repo (Backup Destination)
VOLUME /mnt/borg-repository

# Borgmatic Config
VOLUME /etc/borgmatic.d

# Borg Keys
VOLUME /root/.config/borg

# SSH Keys 
VOLUME /root/.ssh

# Borg Cache
VOLUME /root/.cache/borg

# Fuse mount point
VOLUME /mnt/fuse

CMD ["/entry.sh"]

