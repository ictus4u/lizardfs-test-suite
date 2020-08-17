#!/usr/bin/env sh
root_folder=$(realpath "$(dirname $0)/../")

if [ -f "${root_folder}/.env" ]; then
  set -a
  source "${root_folder}/.env"
  set +a
fi

LIZARD_RELEASE_REPOSITORY=${LIZARD_RELEASE_REPOSITORY:-"ictus4u/lizardfs-dist:latest"}
LIZARD_RELEASE_REPOSITORY=${LIZARD_BASE_REPOSITORY:-"ictus4u/lizardfs-base:latest"}

docker build -t "${LIZARD_RELEASE_REPOSITORY}" "${root_folder}/services/lizardfs-dist"
docker build -t "${LIZARD_BASE_REPOSITORY}" "${root_folder}/services/lizardfs-base"
