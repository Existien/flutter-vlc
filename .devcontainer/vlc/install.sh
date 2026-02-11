#!/bin/bash

apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y \
    vlc \
    && \
    rm -rf /var/lib/apt/lists/*
