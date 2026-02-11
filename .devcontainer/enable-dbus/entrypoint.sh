#!/bin/bash
if ! ps | grep -q dbus-daemon; then
  pkill dbus-daemon
fi

nohup dbus-daemon --session --print-address > /tmp/dbus-daemon.out &
sleep 0.1
export DBUS_SESSION_BUS_ADDRESS=$(cat /tmp/dbus-daemon.out)
if ! grep -q 'export DBUS_SESSION_BUS_ADDRESS=' ~/.bashrc; then
  echo "export DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS" >> ~/.bashrc
else
  sed -i -e "s|export DBUS_SESSION_BUS_ADDRESS=.*$|export DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS|g" ~/.bashrc &
fi
