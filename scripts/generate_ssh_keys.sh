#!/usr/bin/env sh
root_folder=$(realpath "$(dirname $0)/../")

comment="${1:-lfs-builder@$(hostname)}"

priv_key="${root_folder}/services/lizardfs-dist/docker/ssh/id_ed25519"

if [ ! -f "${priv_key}" ]; then
  ssh-keygen -o -a 100 -t ed25519 -f "${priv_key}" -C "${comment}"
fi

if [ -f "${priv_key}.pub" ]; then
  echo "Use the generated public key shown below for authorizing access to your respostory:"
  cat "${priv_key}.pub"
fi
