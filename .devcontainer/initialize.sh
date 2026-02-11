#!/bin/bash
set -e -u

context="/tmp/flutter-sdk"
mkdir -p "${context}"

REMOTE_USER="$(whoami)"
REMOTE_UID=$(id -u $(whoami))
REMOTE_GID=$(id -g $(whoami))

# write user to env file
cat > "${context}/user.env" << EOF
REMOTE_USER="$REMOTE_USER"
REMOTE_UID=$REMOTE_UID
REMOTE_GID=$REMOTE_GID
HOME="/home/$REMOTE_USER"
EOF

if [[ "$REMOTE_UID" == "1000" ]]; then

# write change user script to env file
cat >> "${context}/user.env" << EOF
usermod -l $REMOTE_USER ubuntu
groupmod -n $REMOTE_USER ubuntu
usermod -d /home/$REMOTE_USER -m $REMOTE_USER
EOF

else

# write create new user script to env file
cat >> "${context}/user.env" << EOF
addgroup --gid $REMOTE_GID $REMOTE_USER
adduser --disabled-password --uid $REMOTE_UID --gid $REMOTE_GID $REMOTE_USER
EOF

fi

# X11
xauth_file="${context}/user.docker.xauth"
xauth nlist "$DISPLAY" | sed -e 's/^..../ffff/' | xauth -f "$xauth_file" nmerge -

