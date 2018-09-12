FROM python:2.7.15-stretch
MAINTAINER aaraujo@protonmail.ch
ENV DEBIAN_FRONTEND noninteractive

ARG uid
ARG gid

# Debian dependencies
RUN apt-get update && apt-get install -y zlib1g-dev libjpeg-dev graphicsmagick libboost-dev python-dev && \
    apt-get clean && \
    rm -rf /var/cache/apt

RUN groupadd --gid $gid django && adduser --home /home/django --uid $uid --gid $gid --disabled-password django

# Django dependencies
RUN wget https://github.com/DemocraciaEnRed/votainteligente-portal-electoral/raw/esperando-pr-reqs-upstream/requirements.txt -O /requirements.txt
RUN runuser django -l -c 'pip install -r /requirements.txt --user'

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
