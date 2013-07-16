#!/usr/bin/perl
####################################### Calculate CPU/Mem utilization ###########################################
#                                                                                                               #
# Description : This script is used to calculate CPU/Mem utilization                                            #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
#                                                                                                               #
####################################### Calculate CPU/Mem utilization ###########################################

use strict;
use lib '/Volumes/Data/ssm_perf/';
use Includes::Virex;

main ($ARGV[0]); 

sub main 
{ 
  my @arg=@_;
  my $cpu_mem_log; 
  my $time_log; 
  
  if ( $< != "0" )
  { 
    print "\nError : Only ROOT user can run this script\n";
    exit 1;
  } 
  
  if ( $arg[0] == 1 )
  { 
    $cpu_mem_log = '/Volumes/DATA/ssm_perf/Reports/Cpu_Mem_Install.log'; 
    $time_log = '/Volumes/DATA/ssm_perf/Reports/InstallTime.log';
  } 

  if ( $arg[0] == 2 )
  { 
    $cpu_mem_log = '/Volumes/DATA/ssm_perf/Reports/Cpu_Mem_Idle.log'; 
    $time_log = '/Volumes/DATA/ssm_perf/Reports/IdleTime.log';
   } 

  if ( $arg[0] == 3 )
  { 
    $cpu_mem_log = '/Volumes/DATA/ssm_perf/Reports/Cpu_Mem_Update.log'; 
    $time_log = '/Volumes/DATA/ssm_perf/Reports/UpdateTime.log';
  } 

  if ( $arg[0] == 4 )
  { 
    $cpu_mem_log = '/Volumes/DATA/ssm_perf/Reports/Cpu_Mem_Scan.log'; 
    $time_log = '/Volumes/DATA/ssm_perf/Reports/ScanTime.log';
  } 

  open (FP,"$cpu_mem_log"); 

  open (FP1,">>$time_log");

  my $i=0;
  my $j=0;
  my $k=0;
  my $line;
  my @temp;
  my @process; 
  my @rmemory; 
  my @vmemory; 
  my @cpu_sys; 
  my @cpu_user; 

  foreach $line (<FP>)
  { 
    if ($line =~/Processes:.*total/)
    {
      @temp=split(" ",$&);
      $process[$i]=$temp[1]; 
      $i = $i + 1;
    }
    
    if ($line =~/CPU usage:.*sys/)
    {
      @temp=split(" ",$&);
      if ($temp[4]=~/%/)
      {
         $cpu_sys[$k]=$`; 
      }

      if ($temp[2]=~/%/)
      {
         $cpu_user[$k]=$`; 
      }
      $k = $k + 1;
    }
    
    if ($line =~/Menulet|FWService|appProtd|VShield|cma|fmpd/)
    {
      @temp=split(" ",$line);
      if ($temp[9]=~/K+/)
      { 
        $rmemory[$j]=$`/1024;
      } 
      if ($temp[9]=~/M+/) 
      { 
        $rmemory[$j]=$`;
      } 
      
      if ($temp[10]=~/K+/)
      { 
        $vmemory[$j]=$`/1024;
      } 
      if ($temp[10]=~/M+/) 
      { 
        $vmemory[$j]=$`;
      } 
      $j = $j + 1;
    }
     
    if ($line =~/McAfee/)
    {
      @temp=split(" ",$line);
      if ($temp[10]=~/K+/)
      { 
        $rmemory[$j]=$`/1024;
      } 
      if ($temp[10]=~/M+/) 
      { 
        $rmemory[$j]=$`;
      } 
      
      if ($temp[11]=~/K+/)
      { 
        $vmemory[$j]=$`/1024;
      } 
      if ($temp[11]=~/M+/) 
      { 
        $vmemory[$j]=$`;
      } 
      $j = $j + 1;
    }
     
  } 
  
  my $total_process=0; 
  foreach my $a (@process)
  { 
     $total_process=$total_process+$a;
  } 
  
  my $avg_process=$total_process/($#process+1);
  print FP1 "\nAverage number of processes are : $avg_process\n";
  
  my $total_sys_cpu=0; 
  foreach my $a (@cpu_sys)
  { 
     $total_sys_cpu=$total_sys_cpu+$a;
  } 
  
  my $avg_sys_cpu=$total_sys_cpu/($#process+1);

  my $total_user_cpu=0; 
  foreach my $a (@cpu_user)
  { 
     $total_user_cpu=$total_user_cpu+$a;
  } 
  
  my $avg_user_cpu=$total_user_cpu/($#process+1);

  print FP1 "\nAverage CPU usage: $avg_user_cpu% user, $avg_sys_cpu% sys \n";

  my $total_rmemory=0; 
  foreach my $a (@rmemory)
  { 
     $total_rmemory=$total_rmemory+$a;
  } 
  
  my $avg_rmemory=$total_rmemory/($#process+1) ; 
  print FP1 "\nAverage REAL memory used by the product is : $avg_rmemory MB\n";

  my $total_vmemory=0; 
  foreach my $a (@vmemory)
  { 
     $total_vmemory=$total_vmemory+$a;
  } 
  
  my $avg_vmemory=$total_vmemory/($#process+1) ; 
  print FP1 "\nAverage VIRTUAL memory used by the product is : $avg_vmemory MB\n\n";

  close (FP);
  close (FP1);
}
