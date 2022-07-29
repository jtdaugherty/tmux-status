#!/usr/bin/env bash

# Display the unread message count for the Inbox as well as folders for
# a Maildir mailbox.
# Platform: any

set -e

ROOT=~/mail/gmail-galois
INBOX=$ROOT/INBOX/new
INBOX_N=$(ls $INBOX | wc -l | awk '{ print $1 }')
OTHER_N=$(find $(find $ROOT -type d -name new) -type f | grep -v INBOX | wc -l | awk '{ print $1 }')

HIGHLIGHT_FG="colour75"
DEFAULT_FG="colour24"

function highlight {
    local s=$1
    echo "#[fg=$HIGHLIGHT_FG]$s#[fg=$DEFAULT_FG]"
}

s=""

if [ $INBOX_N -gt 0 ]
then
    s="$s$(highlight $INBOX_N)"
else
    s="${s}0"
fi

if [ $OTHER_N -gt 0 ]
then
    if [ $INBOX_N -eq 0 ]
    then
        s="0"
    fi
    s="$s,$(highlight $OTHER_N)"
else
    s="$s,0"
fi

if [ ! -z "$s" ]
then
    if [ $INBOX_N -gt 0 ] || [ $OTHER_N -gt 0 ]
    then
        echo "($(highlight 'g:')$s)"
    else
        echo "(g:$s)"
    fi
fi
