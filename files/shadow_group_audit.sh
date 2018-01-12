#!/bin/bash

LOGLEVEL=DEBUG
log_debug() { if [ "$LOGLEVEL" == "DEBUG" ]; then echo "$@"; fi }
log_info()  { if [ "$LOGLEVEL" == "INFO" ]; then echo "$@"; fi }

shadow_gid=$(grep -P '^shadow:[^:]*:[^:]*:[^:]*' /etc/group | cut -d ':' -f3)
user=$(awk -F: '($4 == gid) { print $1 }' gid=$shadow_gid /etc/passwd)
if [ "x$user" != "x" ]; then
    log_debug "User assigned to shadow group: $user"
    log_info "$user"
fi
