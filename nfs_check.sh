#!/bin/bash
##############################
## https://github.com/molv ##
##############################
#This script checks state of the NFS share by searching specified filetype, remounts it and restarts dependent service
LOG=/var/log/nfs_check.log
NFS_LOCAL_PATH=/some_local_path/

#what type of file should exist into the mounted share
FILETYPE=jpg

#path to share on the NFS server
NFS_REMOTE_PATH=/some_remote_path/

#NFS server address
NFS_REMOTE_HOST=999.999.999.999

#service, that uses this nfs share and needs to be restarted
SERVICE_NAME=some_service_name

nfs_remount ()
{
echo "`date +"%Y.%m.%d-%H:%M:%S"`: NFS remount command has been invoked" >>$LOG

/etc/init.d/$SERVICE_NAME stop
mount -t nfs $NFS_REMOTE_HOST:$NFS_REMOTE_PATH $NFS_LOCAL_PATH
/etc/init.d/SERVICE_NAME start
}

#check share state and execute remount function if needed
find $NFS_LOCAL_PATH -type f -iname "*.$FILETYPE" 2>/dev/null | grep -q . || nfs_remount

#clear log
[[ $(find $LOG -type f -size +5M 2>/dev/null) ]] && echo  "`date +"%Y.%m.%d-%H:%M:%S"`: Log cleared" > $LOG
