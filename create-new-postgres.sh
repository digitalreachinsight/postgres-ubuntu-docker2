#!/bin/bash

cp -Rp /var/lib/postgresql-docker-version /shared-mount/postgresql-var/
cp -Rp /etc/postgresql-docker-version /shared-mount/postgresql-etc
cp -Rp /etc/postgresql-common-docker-version /shared-mount/postgresql-common-etc
cp -Rp /var/log/postgresql-docker-version /shared-mount/postgresql-log
echo "Copied postgres files to shared directory"
