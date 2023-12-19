FROM ghcr.io/paperless-ngx/paperless-ngx:2.10.0

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

#ENV PAPERLESS_ENABLE_HTTP_REMOTE_USER=true
#ENV PAPERLESS_HTTP_REMOTE_USER_HEADER_NAME="HTTP_X_REMOTE_USER_NAME"
#ENV PAPERLESS_FORCE_SCRIPT_NAME="/local_paperless/ingress"
#ENV PAPERLESS_STATIC_URL="/local_paperless/ingress/static/"
#ENV PAPERLESS_USE_X_FORWARD_HOST=true
#ENV PAPERLESS_USE_X_FORWARD_PORT=true

RUN sed -i '/django.middleware.clickjacking/d' /usr/src/paperless/src/paperless/settings.py

#VOLUME ["/usr/src/paperless/data", "/usr/src/paperless/media", "/usr/src/paperless/consume", "/usr/src/paperless/export"]

#EXPOSE 8000
