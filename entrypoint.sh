#!/bin/bash

REPODIR="/home/django/votainteligente-portal-electoral"

if [ ! -f ${REPODIR}/requirements.txt ]; then
  # Clone votainteligente-portal-electoral
  cd ${REPODIR} && git init && \
	           git remote add origin https://github.com/DemocraciaEnRed/votainteligente-portal-electoral.git && \
		   git fetch && \
		   git checkout esperando-pr-reqs-upstream

  # Django manage
  cd ${REPODIR} && python manage.py migrate
  cd ${REPODIR} && python manage.py compilescss
  cd ${REPODIR} && python manage.py collectstatic
  cd ${REPODIR} && python manage.py loaddata example_data.yaml
fi

cd ${REPODIR} && python manage.py runserver 0.0.0.0:8000
