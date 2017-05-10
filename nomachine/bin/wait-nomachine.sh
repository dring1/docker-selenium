#!/usr/bin/env bash
# set -e: exit asap if a command exits with a non-zero status
set -e

if [ "${NOMACHINE}" != "true" ]; then
  echo "Won't start nomachine service due to NOMACHINE env var false"
  exit 0
fi

if [ ! -z "${XE_DISP_NUM}" ]; then
  echo "Will not wait for nomachine because env var XE_DISP_NUM is set."
  exit 0
fi

echo "Waiting for nomachine to be ready..."
while ! curl -s "https://localhost:${NOMACHINE_PORT_4443}/" \
          | grep "nomachine_screen"; do
  echo -n '.'
  sleep 0.1
done
echo "Done wait-nomachine.sh"
