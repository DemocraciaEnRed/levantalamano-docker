#!/bin/bash

REPODIR="/home/django/votainteligente-portal-electoral"

# Clone votainteligente-portal-electoral
cd ${REPODIR} && git init && git remote add origin https://github.com/DemocraciaEnRed/votainteligente-portal-electoral.git && git fetch && git checkout esperando-pr-reqs-upstream

# Generate random key and set it in local_settings.py
KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
sed -i "s/^SECRET_KEY$/SECRET_KEY = '$KEY'/g" ${REPODIR}/local_settings.py

# Django manage
cd ${REPODIR} && python manage.py migrate
cd ${REPODIR} && python manage.py compilescss
cd ${REPODIR} && python manage.py collectstatic
cd ${REPODIR} && python manage.py loaddata example_data.yaml

cd ${REPODIR} && python manage.py runserver 0.0.0.0:8000
