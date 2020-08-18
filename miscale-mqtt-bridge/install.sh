#!/bin/sh
set -e

sudo apt install pi-bluetooth python3-bluez libbluetooth-dev bluez-tools bluez bluez-hcidump bluetooth python3-virtualenv
cd miscale-mqtt-bridge
virtualenv -p python3 .venv
source .venv/bin/activate
sudo pip3 install bluepy paho-mqtt pyyaml
pip3 install bluepy paho-mqtt pyyaml
sudo cp miscale-mqtt-bridge.service /etc/systemd/system/miscale-mqtt-bridge.service
sudo systemctl daemon-reload
sudo systemctl start miscale-mqtt-bridge.service
sudo systemctl status miscale-mqtt-bridge.service
sudo systemctl enable miscale-mqtt-bridge.service
