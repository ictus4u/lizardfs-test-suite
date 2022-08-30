#!/usr/bin/env sh
set -eu

if [ -f "${ENVIRONMENT_FILE}" ]; then
  set -a
  . "${ENVIRONMENT_FILE}"
  set +a
fi

exec "$@"
