#!/bin/bash
  
# Start the first process
env > /etc/.cronenv

service cron start &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start cron: $status"
  exit $status
fi

mv /var/lib/postgresql /var/lib/postgresql-docker-version
ln -s /shared-mount/postgresql-var/ /var/lib/postgresql

mv /etc/postgresql /etc/postgresql-docker-version
ln -s /shared-mount/postgresql-etc /etc/postgresql

mv /etc/postgresql-common /etc/postgresql-common-docker-version
ln -s /shared-mount/postgresql-common-etc /etc/postgresql-common

mv /var/log/postgresql /var/log/postgresql-docker-version
ln -s /shared-mount/postgresql-log /var/log/postgresql

chown root.postgres /shared-mount/postgresql-log
chmod 775 /shared-mount/postgresql-log
chmod +t /shared-mount/postgresql-log

# Start the second process
service postgresql start &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start apache2: $status"
  exit $status
fi
bash
