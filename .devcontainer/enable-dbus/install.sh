#!/bin/bash

apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y \
    dbus \
    d-feet \
    bustle \
    && \
    rm -rf /var/lib/apt/lists/*

mkdir -p /usr/local/share/enable-dbus
cp entrypoint.sh /usr/local/share/enable-dbus
