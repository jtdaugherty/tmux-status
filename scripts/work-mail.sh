#!/usr/bin/env bash

set -e

MAIL=~/mail/gmail-galois/INBOX/new
N=$(ls $MAIL | wc -l | awk '{ print $1 }')

if [ $N -gt 0 ]
then
    echo "g:$N"
fi
