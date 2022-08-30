#!/usr/bin/env sh
root_folder=$(realpath "$(dirname $0)/../")

if [ -f "${root_folder}/.env" ]; then
  set -a
  source "${root_folder}/.env"
  set +a
fi

LIZARD_BASE_REPOSITORY=${LIZARD_BASE_REPOSITORY:-"registry.lizardfs.com/baldor/lizardfs-base:latest"}

docker build \
  --tag="${LIZARD_BASE_REPOSITORY}" \
  --cache-from="${LIZARD_BASE_REPOSITORY}" \
  "${root_folder}/services/lizardfs-base"
