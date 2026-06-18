#!/bin/sh
set -e

PUID=${PUID:-1000}
PGID=${PGID:-1000}

echo "[somedl] Starting with UID=${PUID}, GID=${PGID}"

# -o allows non-unique IDs in case the requested UID/GID is already
# taken by a system account inside the container (mirrors linuxserver behaviour)
groupmod -o -g "$PGID" somedl
usermod -o -d /config -u "$PUID" somedl

chown -R somedl:somedl /config /downloads

exec gosu somedl "$@"
