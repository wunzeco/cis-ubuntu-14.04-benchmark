#!/bin/bash

LOGLEVEL=DEBUG
log_debug() { if [ "$LOGLEVEL" == "DEBUG" ]; then echo "$@"; fi }
log_info()  { if [ "$LOGLEVEL" == "INFO" ]; then echo "$@"; fi }


cat /etc/group | cut -f1 -d":" | sort -n | uniq -c | while read x ; do
    [ -z "${x}" ] && break
    set - $x
    if [ $1 -gt 1 ]; then
        gids=`awk -F: '($1 == n) { print $3 }' n=$2 /etc/group | xargs`
        log_debug "Duplicate Group Name ($2): ${gids}"
    fi
done
