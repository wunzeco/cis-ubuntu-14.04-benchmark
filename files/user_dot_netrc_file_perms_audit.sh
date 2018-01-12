#!/bin/bash

LOGLEVEL=DEBUG
log_debug() { if [ "$LOGLEVEL" == "DEBUG" ]; then echo "$@"; fi }
log_info()  { if [ "$LOGLEVEL" == "INFO" ]; then echo "$@"; fi }

for dir in `cat /etc/passwd | egrep -v '(root|sync|halt|shutdown)' | awk -F: '($7 != "/usr/sbin/nologin") { print $6 }'`; do
    for file in $dir/.netrc; do
        if [ ! -h "$file" -a -f "$file" ]; then
            fileperm=`ls -ld $file | cut -f1 -d" "`
            if [ `echo $fileperm | cut -c5 ` != "-" ]; then
                log_debug "Group Read set on $file"
                log_info "$dir/.netrc"
            fi
            if [ `echo $fileperm | cut -c6 ` != "-" ]; then
                log_debug "Group Write set on $file"
                log_info "$dir/.netrc"
            fi
            if [ `echo $fileperm | cut -c7 ` != "-" ]; then
                log_debug "Group Execute set on $file"
                log_info "$dir/.netrc"
            fi
            if [ `echo $fileperm | cut -c8 ` != "-" ]; then
                log_debug "Other Read  set on $file"
                log_info "$dir/.netrc"
            fi
            if [ `echo $fileperm | cut -c9 ` != "-" ]; then
                log_debug "Other Write set on $file"
                log_info "$dir/.netrc"
            fi
            if [ `echo $fileperm | cut -c10 ` != "-" ]; then
                log_debug "Other Execute set on $file"
                log_info "$dir/.netrc"
            fi
        fi
    done
done
