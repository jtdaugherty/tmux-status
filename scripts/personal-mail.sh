#!/usr/bin/env bash

# Display the unread message count for a Maildir mailbox.
# Platform: any

set -e

MAIL=~/mail/pobox/new
N=$(ls $MAIL | wc -l | awk '{ print $1 }')

HIGHLIGHT_FG="colour75"
DEFAULT_FG="colour24"

function highlight {
    echo "#[fg=$HIGHLIGHT_FG]$*#[fg=$DEFAULT_FG]"
}

s=""

if [ $N -gt 0 ]
then
    s="$(highlight $N)"
else
    s="_"
fi

if [ $N -gt 0 ]
then
    echo "$(highlight p:$N) |"
else
    echo "p:$N |"
fi
