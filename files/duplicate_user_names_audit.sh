#!/bin/bash

LOGLEVEL=DEBUG
log_debug() { if [ "$LOGLEVEL" == "DEBUG" ]; then echo "$@"; fi }
log_info()  { if [ "$LOGLEVEL" == "INFO" ]; then echo "$@"; fi }


cat /etc/passwd | cut -f1 -d":" | sort -n | uniq -c | while read x ; do
    [ -z "${x}" ] && break
    set - $x
    if [ $1 -gt 1 ]; then
        uids=`awk -F: '($1 == n) { print $3 }' n=$2 /etc/passwd | xargs`
        log_debug "Duplicate User Name ($2): ${uids}"
    fi
done
