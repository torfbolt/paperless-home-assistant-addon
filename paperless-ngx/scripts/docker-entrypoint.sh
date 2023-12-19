#!/usr/bin/env bash

set -e

echo "Home Assistant addon entry script"

redis-server --daemonize yes

CONFIG_PATH=/data/options.json

# Load config
#PAPERLESS_URL=$(jq --raw-output ".url // empty" $CONFIG_PATH)
#export PAPERLESS_URL
PAPERLESS_FILENAME_FORMAT=$(jq --raw-output ".filename.format" $CONFIG_PATH)
export PAPERLESS_FILENAME_FORMAT
PAPERLESS_OCR_LANGUAGE=$(jq --raw-output ".ocr.language" $CONFIG_PATH)
export PAPERLESS_OCR_LANGUAGE

DEFAULT_USERNAME=$(jq --raw-output ".default_superuser.username" $CONFIG_PATH)
export DEFAULT_USERNAME
DEFAULT_EMAIL=$(jq --raw-output ".default_superuser.email" $CONFIG_PATH)
export DEFAULT_EMAIL
DEFAULT_PASSWORD=$(jq --raw-output ".default_superuser.password" $CONFIG_PATH)
export DEFAULT_PASSWORD

PAPERLESS_TIME_ZONE=$(jq --raw-output ".timezone.timezone" $CONFIG_PATH)
export PAPERLESS_TIME_ZONE

PAPERLESS_CONSUMPTION_DIR=$(jq --raw-output ".directories.consumption" $CONFIG_PATH)
export PAPERLESS_CONSUMPTION_DIR
PAPERLESS_DATA_DIR=$(jq --raw-output ".directories.data" $CONFIG_PATH)
export PAPERLESS_DATA_DIR
PAPERLESS_MEDIA_ROOT=$(jq --raw-output ".directories.media" $CONFIG_PATH)
export PAPERLESS_MEDIA_ROOT

echo "Continuing with original docker entry script"

exec /sbin/docker-entrypoint.sh.orig "$@"
