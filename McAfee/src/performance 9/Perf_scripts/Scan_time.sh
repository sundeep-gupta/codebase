#!/bin/bash
####################################### CPU/Mem Utilization during ODS ##########################################
#                                                                                                               #
# Description : This script is used to calculate CPU/Mem utilization during system scan                         #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
#                                                                                                               #
####################################### CPU/Mem Utilization during ODS ##########################################

calculate_time()
{ 
  osascript ODS.scpt > /dev/null 2>&1;
  sleep 1;
  var=`ps -ax | grep "ODS" | awk ' $6 ~ /ODS.*/ { print $1;} ' `;

  echo -e "\n\nODS id is : $var\n\n";

  while [ ! -z $var ]
  do
     var=`ps -ax | grep "ODS" | awk ' $6 ~ /ODS.*/ { print $1;} ' `;
  done;

  junk=`ps -ax | grep Record_memory_usage.pl | awk ' { print $1;  } ' | xargs kill -9 >/dev/null 2>&1`;

  ./Calculate_cpu_memory.pl 4 & 

}

echo -e "\nOn Demand Scan (ODS) is in progress, Please wait...\n";

./Record_memory_usage.pl 4 & 

calculate_time;

echo -e "\nOn Demand Scan (ODS) is, Please look for the logs in '$PWD/Reports'\n";

