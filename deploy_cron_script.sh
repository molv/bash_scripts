#!/bin/bash
##############################
## https://github.com/molv ##
##############################

##copy script to server and add to cron
#run as 'script.sh servers_list.txt'

LOGIN=
PASS=

SCRIPT_DIR=/root/cups_check/
SCRIPT_NAME=cups_check.sh

chmod 744  $SCRIPT_NAME

for NODE in `cat $1`;do

echo '--------------------------'

echo "Uploading to server: $NODE"
sshpass -p $PASS scp $SCRIPT_DIR$SCRIPT_NAME $LOGIN@$NODE:/opt/

echo "Logging in to: $NODE"
sshpass -p $PASS ssh -T -o StrictHostKeychecking=no $LOGIN@$NODE << EOF

echo "Adding to cron"
echo "*/5 * * * * /opt/$SCRIPT_NAME" >> /var/spool/cron/$LOGIN

EOF

echo "Done"
echo '--------------------------'

done
unset PASS
unset NODE
unset SCRIPT_DIR
unset SCRIPT_NAME
