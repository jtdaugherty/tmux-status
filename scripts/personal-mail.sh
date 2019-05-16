#!/usr/bin/env bash

set -e

MAIL=~/mail/pobox/INBOX/new
N=$(ls $MAIL | wc -l | awk '{ print $1 }')

if [ $N -gt 0 ]
then
    echo "p:$N"
fi
