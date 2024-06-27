#!/bin/sh

# Exit shell if errors.
set -e

#Check if the MySQL database is up. 
while ! nc -zv $MYSQL_HOST $MYSQL_PORT; do
   echo "🟡 Waiting for MySQL Database Startup ($MYSQL_HOST:$MYSQL_PORT) ..."
   sleep 2
done

echo "✅ MySQL Database Started Successfully ($MYSQL_HOST:$MYSQL_PORT)"

python manage.py collectstatic --noinput
echo "✅ Static Files Collected"
python manage.py makemigrations --noinput
echo "✅ Migrations Made"
python manage.py migrate --noinput
echo "✅ Migrations Applied"
python manage.py runserver 0.0.0.0:8000
