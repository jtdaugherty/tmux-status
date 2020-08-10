#!/usr/bin/env bash

# Display the unread message count for a Maildir mailbox.
# Platform: any

set -e

MAIL=~/mail/pobox/new
N=$(ls $MAIL | wc -l | awk '{ print $1 }')

if [ $N -gt 0 ]
then
    echo "p:$N"
fi
