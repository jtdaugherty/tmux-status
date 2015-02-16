#!/usr/bin/env bash

function raw_data {
    ioreg -rc AppleSmartBattery
}

if raw_data | grep AppleSmartBattery >/dev/null
then
    CURRENT=$(raw_data | grep "CurrentCapacity" | awk '{ print $3 }')
    MAX=$(raw_data | grep "MaxCapacity" | awk '{ print $3 }')
    PERC=$(( $CURRENT * 100 / $MAX ))
    CHARGING=$(raw_data | grep "IsCharging" | grep "Yes")

    if [ ! -z "$CHARGING" ]
    then
        C=green
    else
        if [ $PERC -gt 40 ]
        then
            C=green
        elif [ $PERC -gt 20 ]
        then
            C=yellow
        else
            C=red
        fi
    fi

    echo "🔋 ${PERC}%"
fi
