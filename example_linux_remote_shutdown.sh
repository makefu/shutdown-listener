#!/usr/bin/env bash
###########################
# this bash script is a template for remote system shutdown

###############
## Variables ##
###############
hostname=""

###############
## main	     ##
###############
echo "Shutting down remote linux system"

if ssh -o StrictHostKeyChecking=no $hostname  ; then
    echo "Shutdown successful"
else
    echo "Shutdown failed"
fi

