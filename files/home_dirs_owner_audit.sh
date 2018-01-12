#!/bin/bash

LOGLEVEL=DEBUG
log_debug() { if [ "$LOGLEVEL" == "DEBUG" ]; then echo "$@"; fi }
log_info()  { if [ "$LOGLEVEL" == "INFO" ]; then echo "$@"; fi }

cat /etc/passwd | awk -F: '{ print $1 " " $3 " " $6 }' | while read user uid dir; do
    if [ $uid -ge 1000 -a -d "$dir" -a $user != "nfsnobody" ]; then
        owner=$(stat -L -c "%U" "$dir")
        if [ "$owner" != "$user" ]; then
            log_debug "The home directory ($dir) of user $user is owned by $owner."
            log_info  "$dir:$user"
        fi
    fi
done
