#!/bin/bash
####################### Incremantal, Full product Update and CPU/Mem Utilization during Update ##################
#                                                                                                               #
# Description : This script is used to do Incrementali, Full product Update and also to calculate CPU/Mem       #
#              - utilization during system scan                                                                 #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
#                                                                                                               #
####################### Incremantal, Full product Update and CPU/Mem Utilization during Update ##################

calculate_time()
{ 
  arg=$1; 
  
  osascript Product_Update.scpt > /dev/null 2>&1;
  sleep 1;
  start_time=`date "+%H:%M:%S"`;

  var=`ps -ax | grep Mue | awk ' $4 ~ /Mue.*/ { print $1;} ' `;

  while [ ! -z $var ]
  do
     var=`ps -ax | grep Mue | awk ' $4 ~ /Mue.*/ { print $1;} ' `;
  done;

  end_time=`date "+%H:%M:%S"`;

  temp_start=`echo $start_time | sed 's/:/ /g'`; 
  temp_end=`echo $end_time | sed 's/:/ /g'`; 

  set -- $temp_start; 
  hour=$1;
  min=$2;
  sec=$3;

  total_start_sec=0;
  total_start_sec=`echo $total_start_sec+$hour*60*60 | bc `;
  total_start_sec=`echo $total_start_sec+$min*60 | bc `;
  total_start_sec=`echo $total_start_sec+$sec | bc `;

  set -- $temp_end; 
  hour=$1;
  min=$2;
  sec=$3;

  total_end_sec=0;
  total_end_sec=`echo $total_end_sec+$hour*60*60 | bc `;
  total_end_sec=`echo $total_end_sec+$min*60 | bc `;
  total_end_sec=`echo $total_end_sec+$sec | bc `;

  if [ $arg -eq 1 ] 
  then 
    if [ $total_end_sec -ge  $total_start_sec ] 
    then 
       echo -e "\nTime taken for INCREMENTAL Product Update is : `echo $total_end_sec-$total_start_sec | bc` seconds\n" >> /Volumes/DATA/ssm_perf/Reports/UpdateTime.log;
    elif [ $total_start_sec -ge $total_end_sec ] 
    then 
       echo -e "\nTime taken for INCREMENTAL Product Update is : `echo $total_start_sec-$total_end_sec | bc` seconds\n" >> /Volumes/DATA/ssm_perf/Reports/UpdateTime.log;
    fi   
  fi 
  
  if [ $arg -eq 2 ] 
  then 
    if [ $total_end_sec -ge  $total_start_sec ] 
    then 
       echo -e "\nTime taken for FULL Product Update is : `echo $total_end_sec-$total_start_sec | bc` seconds\n" >> /Volumes/DATA/ssm_perf/Reports/UpdateTime.log;
    elif [ $total_start_sec -ge $total_end_sec ] 
    then 
       echo -e "\nTime taken for FULL Product Update is : `echo $total_start_sec-$total_end_sec | bc` seconds\n" >> /Volumes/DATA/ssm_perf/Reports/UpdateTime.log;
    fi   
  fi 
  

  
  junk=`ps -ax | grep Record_memory_usage.pl | awk ' { print $1;  } ' | xargs kill -9 >/dev/null 2>&1`;

  ./Calculate_cpu_memory.pl 3 & 

}

echo -e "\nIncremental Product Update is in progress, Please wait...\n";

./Record_memory_usage.pl 3 & 

calculate_time 1;

echo -e "\nINCREMENTAL Product Update is done...\n";

echo -e "\nPreparing for FULL Product Update, Please wait...\n";

./Update.sh 

echo -e "\nFull Product Update is in progress, Please wait...\n";

./Record_memory_usage.pl 3 & 

calculate_time 2;

echo -e "\nFULL Product Update is done...\n";


