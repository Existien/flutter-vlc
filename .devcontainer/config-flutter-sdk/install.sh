#!/bin/bash

FLUTTER=/sdk/flutter/bin/flutter
su ${_REMOTE_USER} -c "${FLUTTER} --disable-analytics"
su ${_REMOTE_USER} -c "${FLUTTER} config --no-enable-web --no-enable-android"
