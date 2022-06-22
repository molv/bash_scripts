#!/bin/bash
#simple check if service is running

SERVICE=cups
SCRIPT_NAME=cups_check
if
ps ax |grep -v grep | grep -v $SCRIPT_NAME | grep -i $SERVICE > /dev/null
then
	echo "$SERVICE is running"
else
	echo "$SERVICE is not running"
	 /etc/init.d/$SERVICE restart
fi
unset SERVICE
unset SCRIPT_NAME
