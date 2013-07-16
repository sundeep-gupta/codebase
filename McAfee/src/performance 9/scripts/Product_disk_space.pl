#!/usr/bin/perl
####################################### DISK Space consumed by the Product ######################################
#                                                                                                               #
# Description : This script is used to calculate disk space occupied by the product                             #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
#                                                                                                               #
####################################### DISK Space consumed by the Product ######################################
use strict;
my @prod_components;

@prod_components=("/usr/local/McAfee/AntiMalware/dats/","/usr/local/McAfee","/Library/Preferences/com.mcafee.ssm.antimalware.plist","/Library/Preferences/com.mcafee.ssm.appprotection.plist","/Library/Preferences/com.mcafee.ssm.firewall.plist","/Library/Frameworks/AVEngine.framework/","/Library/Frameworks/MacScanner.framework/","/Library/Frameworks/ScanBooster.framework/","/Library/Frameworks/VirusScanPreferences.framework/","/Library/McAfee/cma","/Applications/McAfee Security.app","/etc/cma.d","/etc/cma.conf","/Library/Application Support/McAfee","/Library/Receipts/AntiMalware.pkg","/Library/Receipts/AppProtection.pkg","/Library/Receipts/FMP.pkg","/Library/Receipts/Firewall.pkg","/Library/Receipts/MSCUI.pkg","/Library/Receipts/cma.pkg");

my $total_size=0;
my $temp;
my @temp;
my $dat_size;

foreach $a (@prod_components) 
{
  if ($a =~ /dats/)
  {
    $temp=`du -sh "$a"`;
    @temp=split(" ",$temp);
    if ($temp[0] =~ /K/)
    {
      $temp[0]="$` KB";
    }

    if ($temp[0] =~ /M/)
    {
      $temp[0]="$` MB";
    }

    $dat_size=$temp[0];
    next;
  }
 
  $temp=`du -sh "$a"`; 
  @temp=split(" ",$temp); 

  if ($temp[0] =~ /K/)
  { 
    $temp[0]=$`;
  }
 
  if ($temp[0] =~ /M/)
  { 
    $temp[0]=$`;
    $temp[0]=$temp[0]*1024;
  } 
  $total_size=$total_size+$temp[0];
} 

print "\n\n\nDATS size : $dat_size\n";
print "\nMSM Product size with DATS (in KB) : $total_size KB\n";
$total_size=$total_size/1024;
print "\nMSM Product size with DATS (in MB) : $total_size MB\n";
$total_size=$total_size-$dat_size;
print "\nMSM Product size without DATS (in MB) : $total_size MB\n\n\n";
