#!/usr/bin/env sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo "Starting Init of Vault"

LOCK_FILE=/lockfile
if [ -f "$LOCK_FILE" ]; then
    echo "$LOCK_FILE exists."
else
    echo "$LOCK_FILE does not exist. Assuming first run"
  echo "Install NC"
  apk add netcat-openbsd
  apk add curl
  apk add jq
  apk add openssl
  apk add bash
  apk add --update nodejs npm


  echo "Waiting for vault server to be available"
  while ! nc -z localhost 8200; do
    sleep 1 # wait for 1 of the second before check again
  done

  # sh /scripts/fetch-key.sh "7f6cfc12-3d5e-446b-8dc2-ee6d81bac6b3"
  sh /scripts/fetch-key.sh "22302fb5-cdae-4612-b14f-8a4a866dea5b"
fi

