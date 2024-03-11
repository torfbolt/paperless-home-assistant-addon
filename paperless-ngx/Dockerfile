FROM ghcr.io/paperless-ngx/paperless-ngx:2.6.2

#### Redis Setup
RUN apt-get update \
    && apt-get install redis-server redis-tools jq -y \
    && sed -i "s/bind .*/bind 127.0.0.1/g" /etc/redis/redis.conf

ENV PAPERLESS_REDIS="redis://localhost:6379"

# Clean Up
RUN apt-get -y purge build-essential libqpdf-dev \
    && apt-get -y autoremove --purge \
    && rm -rf /var/lib/apt/lists/*

# copy scripts
RUN mv /sbin/docker-entrypoint.sh /sbin/docker-entrypoint.sh.orig
COPY scripts/docker-entrypoint.sh /sbin/docker-entrypoint.sh
RUN chmod 755 /sbin/docker-entrypoint.sh

ENV PAPERLESS_CONFIGURATION_PATH="/config/paperless.conf"

#VOLUME ["/usr/src/paperless/data", "/usr/src/paperless/media", "/usr/src/paperless/consume", "/usr/src/paperless/export"]

#EXPOSE 8000
