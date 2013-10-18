#!/bin/sh
if [ $# -ne 2 ]; then
   echo "usage $0 <patch> <orb>"
   exit 1
fi

python /tools/tests/ui_ctrl/ui_ctrl.py -U $1 $2
sleep 20
ssh $2 "reboot"

