#!/bin/sh
i=1
label=$1
if [ $label != '' ]
then
        while [ $i -le 16 ]
        do
                view_name=linux_ia64_stndq04_lrg$i
                ade createview -label $label $view_name
                i=`expr $i + 1`
        done
fi

