#!/usr/bin/env bash

# Display first listed non-localhost IP address
# Platform: any

ifconfig | \
grep 'inet ' | \
grep -v 127.0.0.1 | \
head -1 | \
sed -E 's/^.*inet (addr:){0,1}(([0-9]{1,3}\.){3}[0-9]{1,3}).*$/\2/'
