#!/bin/bash

##sends ssh key to a list of hosts

PASS=12345678
for NODE in `cat $1`;do
echo '--------------------------'

echo "Sending key to node: $NODE"
sshpass -p $PASS ssh-copy-id root@$NODE

echo '--------------------------'

done
unset PASS
unset NODE
