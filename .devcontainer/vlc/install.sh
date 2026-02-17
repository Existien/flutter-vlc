#!/bin/bash

apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y \
    vlc \
    && \
    rm -rf /var/lib/apt/lists/*

cp vlc_backend /usr/local/bin/