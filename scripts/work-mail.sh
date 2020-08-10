#!/usr/bin/env bash

# Display the unread message count for the Inbox as well as folders for
# a Maildir mailbox.
# Platform: any

set -e

ROOT=~/mail/gmail-galois
INBOX=$ROOT/INBOX/new
INBOX_N=$(ls $INBOX | wc -l | awk '{ print $1 }')
OTHER_N=$(find $(find $ROOT -type d -name new) -type f | grep -v INBOX | wc -l | awk '{ print $1 }')

s=""

if [ $INBOX_N -gt 0 ]
then
    s="$s$INBOX_N"
fi

if [ $OTHER_N -gt 0 ]
then
    if [ $INBOX_N -eq 0 ]
    then
        s="0"
    fi
    s="$s,$OTHER_N"
fi

if [ ! -z "$s" ]
then
    echo "g:$s"
fi
