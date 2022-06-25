#!/bin/bash
##############################
## https://github.com/molv ##
##############################

#This script checks virtual machine state and starting them up if needed

#Setting locale RU
localedef -c -f UTF-8 -i ru_RU ru_RU.UTF-8
export LC_ALL=ru_RU.UTF-8
export LANG=ru_RU.UTF-8

#logs
LOG=/var/log/virsh_log.txt
STATUS_LOG=/var/log/virsh_check.txt

#Getting list of all machines with state (up\down)
/usr/bin/virsh list --all | awk 'FNR > 2 {print $2,$3}' |sed '$ d'> $STATUS_LOG

while IFS=" " read -r SERVER STATUS;do
if [ "$STATUS" != "работает" ]; then
echo "`date +"%Y.%m.%d-%H:%M:%S"`: Starting server $SERVER..." >>$LOG
/usr/bin/virsh start $SERVER
else
echo "`date +"%Y.%m.%d-%H:%M:%S"`: $SERVER $STATUS" >>$LOG
fi
done <$STATUS_LOG

[[ $(find $LOG -type f -size +5M 2>/dev/null) ]] && echo  'Truncating log file' > $LOG
unset LOG
unset STATUS_LOG
unset SERVER
unset STATUS
