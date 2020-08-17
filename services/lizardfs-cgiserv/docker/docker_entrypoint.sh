#!/usr/bin/env sh

if [ -f "${ENVIRONMENT_FILE}" ]; then
  set -a
  . "${ENVIRONMENT_FILE}"
  set +a
fi

exec "$@"
