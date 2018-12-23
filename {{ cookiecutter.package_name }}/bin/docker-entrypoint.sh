#!/usr/bin/bash

PROJ="proj"
HOME_PATH="/app"
# docker run -d --name "postgresql" -h "postgresql" -p 5432:5432 -e POSTGRES_PASSWORD=<passwd> -v /var/lib/postgresql/data:/var/lib/postgresql/data:Z postgres

mkdir -p /app/log/
PRODUCTION=$( find $HOME_PATH -name production.py | grep "settings/production.py" )

export DJANGO_SETTINGS_MODULE="$PROJ.settings"
if [ ! -z $PRODUCTION ]; then
    export DJANGO_SETTINGS_MODULE="$PROJ.settings.production"
fi

# python $HOME_PATH/manage.py migrate --fake-initial --noinput || exit
python $HOME_PATH/manage.py migrate --noinput || exit
python $HOME_PATH/manage.py collectstatic --noinput

uwsgi --ini uwsgi.ini
