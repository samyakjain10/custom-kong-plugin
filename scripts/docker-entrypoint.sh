#!/bin/bash
set -e

export KONG_NGINX_DAEMON=off

if [[ "$1" == "kong" ]]; then
  PREFIX=${KONG_PREFIX:=/usr/local/kong}

  if [[ "$2" == "docker-start" ]]; then
    kong migrations bootstrap && kong migrations up && kong migrations finish
    kong prepare -p "$PREFIX"
    sh plugin_setup.sh

    exec /usr/local/openresty/nginx/sbin/nginx \
      -p "$PREFIX" \
      -c nginx.conf
  fi
fi

exec "$@"