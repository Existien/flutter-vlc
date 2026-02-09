#!/bin/bash
set -e -u

context="/tmp/flutter-sdk"
mkdir -p "${context}"

# write user id to env file
cat > "${context}/user.env" << EOF
REMOTE_USER="$(whoami)"
REMOTE_UID=$(id -u $(whoami))
REMOTE_GID=$(id -g $(whoami))
HOME="/home/$(whoami)"
EOF

# X11
xauth_file="${context}/user.docker.xauth"
xauth nlist "$DISPLAY" | sed -e 's/^..../ffff/' | xauth -f "$xauth_file" nmerge -

