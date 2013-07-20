#!/bin/bash
####################################### CPU/Mem Utilization during ODS ##########################################
#                                                                                                               #
# Description : This script is used to calculate CPU/Mem utilization during system scan                         #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
#                                                                                                               #
####################################### CPU/Mem Utilization during ODS ##########################################

ODS_Task () 
{ 
  `/usr/bin/osascript ${ROOT_PATH}/ssm_perf/scripts/ODS.scpt > /dev/null 2>&1`;
  sleep 1;
  var=`ps -ax | grep "ODS" | awk ' $6 ~ /ODS.*/ { print $1;} ' `;

  echo -e "\n\nODS process <PID : $var> is started\n\n";

  while [ ! -z $var ]
  do
     var=`ps -ax | grep "ODS" | awk ' $6 ~ /ODS.*/ { print $1;} ' `;
  done;
 
}

main () 
{ 
  echo -e "\nIteration No ::: $cnt\n";
  echo -e "\nOn Demand Scan (ODS) is in progress, Please wait...\n";

  ${ROOT_PATH}/ssm_perf/scripts/Record_memory_usage.pl 4 & 
  
  ODS_Task ;

} 

counter_file="${ROOT_PATH}/ssm_perf/counter";
cnt=`cat $counter_file`;
countervalue=`sed -n '/^counter/p' ${ROOT_PATH}/ssm_perf/Includes/PerfConfig.txt|awk '{print $3;}'`; 

if [ $cnt -gt $countervalue ]
then 
  exit; 
fi 

main ;