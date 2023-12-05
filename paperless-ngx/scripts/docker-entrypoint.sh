#!/usr/bin/env bash

set -e

CONFIG_PATH=/data/options.json

echo "Home Assistant addon entry script"

redis-server --daemonize yes

# Load config
export PAPERLESS_URL=$(jq --raw-output ".url // empty" $CONFIG_PATH)
export PAPERLESS_FILENAME_FORMAT=$(jq --raw-output ".filename.format" $CONFIG_PATH)
export PAPERLESS_OCR_LANGUAGE=$(jq --raw-output ".ocr.language" $CONFIG_PATH)

export DEFAULT_USERNAME=$(jq --raw-output ".default_superuser.username" $CONFIG_PATH)
export DEFAULT_EMAIL=$(jq --raw-output ".default_superuser.email" $CONFIG_PATH)
export DEFAULT_PASSWORD=$(jq --raw-output ".default_superuser.password" $CONFIG_PATH)

export PAPERLESS_CONSUMER_POLLING=$(jq --raw-output ".consumer.polling" $CONFIG_PATH)
export PAPERLESS_TIME_ZONE=$(jq --raw-output ".timezone.timezone" $CONFIG_PATH)

# Change Paperless directories so that we can access the files
export PAPERLESS_CONSUMPTION_DIR=$(jq --raw-output ".directories.consumption" $CONFIG_PATH)
export PAPERLESS_DATA_DIR=$(jq --raw-output ".directories.data" $CONFIG_PATH)
export PAPERLESS_MEDIA_ROOT=$(jq --raw-output ".directories.media" $CONFIG_PATH)

#mkdir -p $PAPERLESS_CONSUMPTION_DIR
#mkdir -p $PAPERLESS_DATA_DIR
#mkdir -p $PAPERLESS_MEDIA_ROOT

#sudo chmod -R 777 $PAPERLESS_CONSUMPTION_DIR
#sudo chmod -R 777 $PAPERLESS_DATA_DIR
#sudo chmod -R 777 $PAPERLESS_MEDIA_ROOT

echo "Continuing with original docker entry script"

exec /sbin/docker-entrypoint.sh.orig "$@"
