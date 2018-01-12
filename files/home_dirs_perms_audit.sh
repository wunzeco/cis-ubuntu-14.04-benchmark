#!/bin/bash

LOGLEVEL=DEBUG
log_debug() { if [ "$LOGLEVEL" == "DEBUG" ]; then echo "$@"; fi }
log_info()  { if [ "$LOGLEVEL" == "INFO" ]; then echo "$@"; fi }

cat /etc/passwd | awk -F: '{ print $1 " " $3 " " $6 " " $7 }' | while read user uid dir shell; do
    if [ $uid -ge 1000 -a -d $dir -a "x$shell" != "x/usr/sbin/nologin" ]; then
        dirperm=`ls -ld $dir | cut -f1 -d" "`
        if [ `echo $dirperm | cut -c6 ` != "-" ]; then
            log_debug "Group Write permission set on directory $dir"
            log_info "$dir"
        fi
        if [ `echo $dirperm | cut -c8 ` != "-" ]; then
            log_debug "Other Read permission set on directory $dir"
            log_info "$dir"
        fi
        if [ `echo $dirperm | cut -c9 ` != "-" ]; then
            log_debug "Other Write permission set on directory $dir"
            log_info "$dir"
        fi
        if [ `echo $dirperm | cut -c10 ` != "-" ]; then
            log_debug "Other Execute permission set on directory $dir"
            log_info "$dir"
        fi
    fi
done
