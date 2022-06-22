#!/bin/bash
LOG=/var/log/bacula_check.log
#checking availability of bacula console
/usr/sbin/bconsole <<< 'version' > /dev/null 2>&1

#if exit code is null, consider bacula is OK
if [ $? == 0 ];then
echo "`date +"%Y.%m.%d-%H:%M:%S"`: Bacula OK" >> $LOG

#in other case - restart bacula
else

echo "`date +"%Y.%m.%d-%H:%M:%S"`: Restarting bacula..." >> $LOG
/etc/init.d/bacula-dir restart > /dev/null 2>&1
/etc/init.d/bacula-sd restart > /dev/null 2>&1
fi
#clear log is more than 1 mb
[[ $(find $LOG -type f -size +1M 2>/dev/null) ]] && echo  'Truncating LOG file' > $LOG
unset LOG
