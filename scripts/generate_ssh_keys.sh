#!/usr/bin/env sh
root_folder=$(realpath "$(dirname $0)/../")

comment="${1:-lfs-builder@$(hostname)}"

priv_key="${root_folder}/services/lizardfs-base/docker/id_ed25519"

if [ ! -f "${priv_key}" ]; then
  ssh-keygen -o -a 100 -t ed25519 -f "${priv_key}" -C "${comment}"
fi
