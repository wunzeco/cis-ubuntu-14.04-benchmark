#!/bin/bash

LOGLEVEL=DEBUG
log_debug() { if [ "$LOGLEVEL" == "DEBUG" ]; then echo "$@"; fi }
log_info()  { if [ "$LOGLEVEL" == "INFO" ]; then echo "$@"; fi }

for dir in `cat /etc/passwd | egrep -v '(root|sync|halt|shutdown)' | awk -F: '($7 != "/usr/sbin/nologin") { print $6 }'`; do
    for file in $dir/.[A-Za-z0-9]*; do
        if [ ! -h "$file" -a -f "$file" ]; then
            fileperm=`ls -ld $file | cut -f1 -d" "`
            if [ `echo $fileperm | cut -c6 ` != "-" ]; then
                log_debug "Group Write permission set on file $file"
                log_info "$file"
            fi
            if [ `echo $fileperm | cut -c9 ` != "-" ]; then
                log_debug "Other Write permission set on file $file"
                log_info "$file"
            fi
        fi
    done
done
