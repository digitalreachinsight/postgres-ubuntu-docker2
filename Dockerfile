# Prepare the base environment.
FROM ubuntu:20.04 as builder_base_docker
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV PRODUCTION_EMAIL=True
ENV SECRET_KEY="ThisisNotRealKey"
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y  wget git postgresql postgresql-12-postgis-3 postgresql-12-postgis-3-scripts 
RUN apt-get install --no-install-recommends -y tzdata cron rsyslog

WORKDIR /app
COPY boot.sh /
COPY pgbackup.sh /app/
COPY create-new-postgres.sh /app/
COPY cron /etc/cron.d/dockercron
RUN chmod 755 /app/pgbackup.sh
RUN chmod 755 /boot.sh

EXPOSE 5432 

HEALTHCHECK --interval=5s --timeout=20s CMD ["pg_isready", "-U", "postgres"]
CMD ["/boot.sh"]
