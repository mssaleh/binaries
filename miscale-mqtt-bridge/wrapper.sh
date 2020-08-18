#!/bin/bash

export MISCALE_MAC="0C:95:41:D0:A4:72" # Mac address of your scale
export HCI_DEV=hci0                    # Bluetooth hci device to use. Defaults to hci0
export MQTT_HOST="192.168.1.222"       # MQTT Server (defaults to 127.0.0.1)
export MQTT_PREFIX=miScale             # MQTT Topic Prefix. Defaults to miscale
export MQTT_USERNAME=mohammed          # Username for MQTT server (comment out if not required)
export MQTT_PASSWORD="mdsh229059!"     # Password for MQTT (comment out if not required)
export MQTT_PORT=1883                  # Defaults to 1883
export TIME_INTERVAL=30                # Time in sec between each query to the scale, to allow other applications to use the Bluetooth module. Defaults to 30
export MQTT_DISCOVERY=true             # Home Assistant Discovery (true/false), defaults to true
export MQTT_DISCOVERY_PREFIX=homeassistant   # Home Assistant Discovery Prefix, defaults to homeassistant


export USER1_GT=69           # If the weight is greater than this number, we'll assume that we're weighing User #1
export USER1_SEX=male
export USER1_NAME=Bader          # Name of the user
export USER1_HEIGHT=175       # Height (in cm) of the user
export USER1_DOB=1980-01-01   # DOB (in yyyy-mm-dd format)

export USER2_LT=30         # If the weight is less than this number, we'll assume that we're weighing User #2
export USER2_SEX=female
export USER2_NAME=Maitha       # Name of the user
export USER2_HEIGHT=95        # Height (in cm) of the user
export USER2_DOB=2002-01-01   # DOB (in yyyy-mm-dd format)

export USER3_SEX=female
export USER3_NAME=Sawsan       # Name of the user
export USER3_HEIGHT=165      # Height (in cm) of the user
export USER3_DOB=1988-01-01   # DOB (in yyyy-mm-dd format)

MY_PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
python3 $MY_PWD/Xiaomi_Scale.py
