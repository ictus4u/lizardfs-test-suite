#!/usr/bin/env sh
root_folder=$(realpath "$(dirname $0)/../")

if [ -f "${root_folder}/.env" ]; then
  set -a
  source "${root_folder}/.env"
  set +a
fi

repository=${LIZARD_RELEASE_REPOSITORY:-"ictus4u/lizardfs-dist:latest"}

docker build --ssh -t "${root_folder}/services/lizardfs-base"
