#!/usr/bin/env bash

set -e

HERE=$(cd `dirname $0;`; pwd)

STRICT=0
SCRIPT_DIR=$HERE/scripts
SEPARATOR=" "
DEFAULT_ITEM_ATTR=""
PREFIX=""
SUFFIX=""

function strict {
    [ $STRICT == 1 ]
}

function script_path {
    local name=$1
    echo "$SCRIPT_DIR/$name.sh"
}

function script_exists {
    local name=$1
    local pth=$(script_path $name)
    [ -f $pth ]
}

function build_status {
    local config=$1
    local status=""

    # For each status script specified in the configuration, run it
    # and build up a status line.
    . $config

    for name in $SCRIPTS
    do
        if [ -z $name ]
        then
            continue
        fi

        if ! script_exists $name
        then
            if strict
            then
                error "No such script: $name"
                exit 1
            else
                continue
            fi
        fi

        local pth=$(script_path $name)

        if [ ! -x $pth ]
        then
            if strict
            then
                error "Script not executable: $pth"
                exit 1
            else
                continue
            fi
        fi

        local output=$($pth)

        if [ -z "$output" ]
        then
            continue
        fi

        if [ ! -z "$status" ]
        then
            status="${status}"
        else
            status="${DEFAULT_ITEM_ATTR}${PREFIX}"
        fi

	fg_name="$(echo $name | tr a-z A-Z)_FG"
	bg_name="$(echo $name | tr a-z A-Z)_BG"

	fg="$(eval 'echo $'$fg_name)"
	bg="$(eval 'echo $'$bg_name)"

	if [ -z "$fg" ]
	then
	    fg=$DEFAULT_FG
	fi
	if [ -z "$bg" ]
	then
	    bg=$DEFAULT_BG
	fi

	item_attr="#[fg=$fg,bg=$bg]"
	sep_item_attr="#[fg=$bg]"

	if [ ! -z "$USE_POWERLINE" ]
	then
	    sep=" ${sep_item_attr}⮂"
	else
	    sep="#[fg=$DEFAULT_FG,bg=$DEFAULT_BG]${SEPARATOR}"
	fi

	if [ -z "${status}" ]
	then
            status="${item_attr}${output}"
	else
            status="${status}${sep}${item_attr}${output}"
	fi


	PREV_BG=$bg
    done

    if [ ! -z "$status" ]
    then
        status="${status}${DEFAULT_ITEM_ATTR}${SUFFIX}"
    fi

    echo $status
}

function error {
    echo "$*" >&2
}

function usage {
    error "Usage: $0 <config> [--strict]"
}

if [ -z "$1" ]
then
    usage
    exit 1
fi

if [ ! -f "$1" ]
then
    error "No such file: $1"
    usage
    exit 1
fi

if [ ! -z "$2" ]
then
    if [ "$2" == "--strict" ]
    then
        STRICT=1
    else
        usage
        exit 1
    fi
fi

PREV_BG=$DEFAULT_FG

build_status $1
