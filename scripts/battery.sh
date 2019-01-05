#!/usr/bin/env bash

function raw_data {
    ioreg -rc AppleSmartBattery
}

function power_connected {
    raw_data | grep ExternalConnected | grep Yes >/dev/null
}

if raw_data | grep AppleSmartBattery >/dev/null
then
    CURRENT=$(raw_data | grep "CurrentCapacity" | awk '{ print $3 }')
    MAX=$(raw_data | grep "MaxCapacity" | awk '{ print $3 }')
    PERC=$(( $CURRENT * 100 / $MAX ))
    CHARGING=$(raw_data | grep "IsCharging" | grep "Yes")

    if [ $PERC -lt 95 ] || ! power_connected
    then
        echo "🔋${PERC}%"
    fi
fi
