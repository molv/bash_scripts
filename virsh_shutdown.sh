#!/bin/bash
##############################
## https://github.com/molv ##
##############################

#shutting down all machines on hypervisor

for MACHINE in `/usr/bin/virsh list --all | awk 'FNR > 2 {print $2}' `;do
echo "Shutting down $MACHINE..."
/usr/bin/virsh shutdown $MACHINE
done
unset $MACHINE
