FROM ubuntu:24.04
ARG DEBIAN_FRONTEND=noninteractive

RUN \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y \
    apt-utils \
    build-essential \
    clang \
    cmake \
    curl \
    git \
    less \
    libgtk-3-dev \
    libglu1-mesa \
    libstdc++-12-dev \
    locales \
    mesa-utils \
    ninja-build \
    pkg-config \
    tmux \
    unzip \
    vim \
    wget \
    xfwm4 \
    xterm \
    xvfb \
    xz-utils \
    zip \
    && \
    rm -rf /var/lib/apt/lists/*

RUN \
  sed -Ei '/(en_US|de_DE|fr_FR)\.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8

ARG USER

RUN --mount=from=tmp,target=/tmp/ . /tmp/user.env \
 && addgroup --gid $REMOTE_GID $REMOTE_USER \
 && adduser --disabled-password --uid $REMOTE_UID --gid $REMOTE_GID $REMOTE_USER \
 && mkdir /sdk \
 && chown -R ${REMOTE_UID}:${REMOTE_GID} /sdk

WORKDIR /sdk
USER ${USER}
ARG FLUTTER_SDK=https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.38.9-stable.tar.xz
RUN curl $FLUTTER_SDK --output sdk.tar.xz \
    && tar xf sdk.tar.xz -C . \
    && rm sdk.tar.xz
ENV PATH="/sdk/flutter/bin:$PATH"

ENTRYPOINT ["/bin/bash", "-lc", "\"$0\" \"$@\""]