#!/bin/bash
##############################
## https://github.com/molv ##
##############################

##Change user pass for a list of servers
#usage: ./scipt.sh list_of_server.txt

PASS=111
NEWPASS=222

for NODE in `cat $1`;do
echo '--------------------------'

echo "Loggin to: $NODE"
sshpass -p $PASS ssh -T -o StrictHostKeychecking=no root@$NODE << EOF

echo "Changing password to: $NEWPASS"
echo "$NEWPASS" |passwd root --stdin

EOF

echo '--------------------------'

done
unset PASS
unset NEWPASS
unset NODE
