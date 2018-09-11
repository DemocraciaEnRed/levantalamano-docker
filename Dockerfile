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
COPY ./votainteligente-portal-electoral/requirements.txt /requirements.txt
RUN runuser django -l -c 'pip install -r /requirements.txt --user'

# Local Settings (--chown flag needs Docker 17.09+)
COPY ./local_settings.py /home/django/local_settings.py
RUN chown django:django /home/django/local_settings.py

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
