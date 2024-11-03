# same functionality as b3vis/docker-borgmatic
# but with another base image
# cron in python docker image from https://github.com/fronzbot/docker-pycron/blob/master/Dockerfile

FROM python:3.11-slim-bullseye

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
    openssh-client \
    python3 python3-dev python3-pip python3-virtualenv \
    libacl1-dev \
    libacl1 \
    liblz4-dev libzstd-dev libxxhash-dev \
    build-essential \
    libfuse3-dev fuse3 pkg-config python3-pkgconfig \
    tzdata \ 
    pipx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists

# borgbackup from  https://borgbackup.readthedocs.io/en/stable/installation.html#using-pip   
RUN virtualenv --python=python3 borg-env
RUN source borg-env/bin/activate
    
# might be required if your tools are outdated
RUN pip install -U pip setuptools wheel

# pkgconfig MUST be available before borg is installed!
RUN pip install pkgconfig
    
# install Borg + Python dependencies into virtualenv
RUN pip install borgbackup[pyfuse3]



# borgmatic from https://torsion.org/borgmatic/docs/how-to/set-up-backups/#non-root-install
RUN pipx ensurepath
RUN pipx install borgmatic

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

