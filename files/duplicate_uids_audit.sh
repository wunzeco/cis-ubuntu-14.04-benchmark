#!/bin/bash

LOGLEVEL=DEBUG
log_debug() { if [ "$LOGLEVEL" == "DEBUG" ]; then echo "$@"; fi }
log_info()  { if [ "$LOGLEVEL" == "INFO" ]; then echo "$@"; fi }

cat /etc/passwd | cut -f3 -d":" | sort -n | uniq -c | while read x ; do
    [ -z "${x}" ] && break
    set - $x
    if [ $1 -gt 1 ]; then
        users=`awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs`
        log_debug "Duplicate UID ($2): ${users}"
        log_info "${users}"
    fi
done
