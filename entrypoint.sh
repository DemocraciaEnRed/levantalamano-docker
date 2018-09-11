#!/bin/bash

# Generate random key and set it in local_settings.py
KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
sed -i "s/^SECRET_KEY$/SECRET_KEY = '$KEY'/g" /home/django/local_settings.py
mv /home/django/local_settings.py /code/local_settings.py

# Django manage
cd /code && python manage.py migrate
cd /code && python manage.py compilescss
cd /code && python manage.py collectstatic
cd /code && python manage.py loaddata /example_data.yaml

cd /code && python manage.py runserver 0.0.0.0:8000
