#!/usr/bin/bash

PROJ="proj"

# docker run -d --name "postgresql" -h "postgresql" -p 5432:5432 -e POSTGRES_PASSWORD=<passwd> -v /var/lib/postgresql/data:/var/lib/postgresql/data:Z postgres

mkdir -p /data/log/
source /data/.env/bin/activate
PRODUCTION=$( find /data/ -name production.py | grep "settings/production.py" )
WSGI_FILE=$( find /data/ -name wsgi.py -not \( -path "*/.env/*" \) )
export DJANGO_SETTINGS_MODULE="$PROJ.settings"
if [ ! -z $PRODUCTION ]; then
    export DJANGO_SETTINGS_MODULE="$PROJ.settings.production"
fi

# python /data/manage.py migrate --fake-initial --noinput || exit
python /data/manage.py migrate --noinput || exit
python /data/manage.py collectstatic --noinput
# python manage.py compilemessages

uwsgi --http :80 --thunder-lock --enable-threads --master --wsgi-file $WSGI_FILE
