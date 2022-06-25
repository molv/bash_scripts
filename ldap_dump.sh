#!/bin/bash
##############################
## https://github.com/molv ##
##############################

#This script creates compressed dump of LDAP database and rotates old copies

DUMP_PATH=/root/ldap_backup
LOG=/var/log/ldap_dump.log

mkdir -p $DUMP_PATH > /dev/null 2>&1

echo "`date +"%Y.%m.%d-%H:%M:%S"`: Creating new dump" >> $LOG
/usr/sbin/slapcat -l $DUMP_PATH/ldap_`hostname`_`date +"%Y_%m_%d"`.ldif
gzip -9 $DUMP_PATH/ldap_`hostname`_`date +"%Y_%m_%d"`.ldif

echo "`date +"%Y.%m.%d-%H:%M:%S"`: Rotating old dump files" >> $LOG
find $DUMP_PATH -type f -mtime +30 -delete

#30 1 * * * /opt/ldap_dump.sh
#/opt/ldap_dump.sh
