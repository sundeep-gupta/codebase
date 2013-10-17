#!/usr/bin/perl -w
#
# TestPlan: NFS Test 
#
# Written by :  AppLabs Technologies
#
# Date : 03/04/05
#
# Modified : 04/13/05
#
# Description : This Script creates a file, writes into it and then deletes it on NFS server.
#
# PASS : Create file, write into it and delete it on NFS Shared resources, FAIL otherwise.
#

use strict;
use Getopt::Long;
use global_library;


my $createfilename = "/TestFile"; #Default Value : Name of the file to be created.
my $timestorun = 1; #Default value: Number of times the script should run.
my $workingdirectory = "/TC_12_2";
&GetOptions('help' => \my $help, 'fsmount=s' => \my $localmountpoint, 'filename=s' => \$createfilename, ,'debug=i'=>\$global_library::Debug,'timestorun=i' =>\$timestorun);

if($help)
{
        print "\nThis Script creates a file, writes into it and then deletes it on NFS shared Resource. \n";
        print "\nExample: #perl fs_writedelete.pl --fsmount <mount point> --filename <name> --timestorun <number>\n";	
        exit;
}

print "\nThis script is running on $^O Operating System.\n";

$localmountpoint=&global_library::RemoveSlash($localmountpoint);
if($createfilename ne "/TestFile"){ $createfilename = "/" . "$createfilename"; }

my $testcaseid="TC_12_2";
my $expectedresult="Create a file, write into it and then delete it on the NFS server.\n";
my $testscriptname = "fs_writedelete.pl";

print "TEST CASE ID: $testcaseid\n";
print "TEST SCRIPT NAME : $testscriptname\n";
print "EXPECTED RESULT: $expectedresult\n\n";

if(-e $localmountpoint)
{
	my $execctr;
	for($execctr=1 ; $execctr<=$timestorun; $execctr++)
	{
		print "Script run count : $execctr \n";
		print "TEST CASE EXECUTION STATUS: Creating working directory. \n";
		if(!&global_library::CreateWorkingDirectory("$localmountpoint$workingdirectory"))
		{
			&global_library::WriteStatus("E",$testscriptname);
			exit 2;
		}	
		if(!&global_library::WriteFile("$localmountpoint$workingdirectory$createfilename"))
		{
			&global_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");
			&global_library::WriteStatus("E",$testscriptname);
			exit 2;
		}
		if(!&global_library::VerifyFileDirCreation("$localmountpoint$workingdirectory$createfilename"))    
		{
			&global_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");
			&global_library::WriteStatus("E",$testscriptname);
			exit 2;
		}
		if(!&global_library::FileRead("$localmountpoint$workingdirectory$createfilename"))
		{
			&global_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");
			&global_library::WriteStatus("E",$testscriptname);
			exit 2;
		}
		if(!&global_library::RemoveFile("$localmountpoint$workingdirectory$createfilename"))
		{
			&global_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");
			&global_library::WriteStatus("E",$testscriptname);
			exit 2;					
		}
		if(&global_library::VerifyFileDirCreation("$localmountpoint$workingdirectory$createfilename"))    
		{
			&global_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");
			&global_library::WriteStatus("F",$testscriptname);
			exit 1;
		}
		&global_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");		
	}
	&global_library::WriteStatus("P",$testscriptname);
	exit 0;
}
else
{
	&global_library::PrintStatus("Shared Resource Does Not Exist. Execution Terminated");
	&global_library::WriteStatus("E",$testscriptname);
	exit 2;
}
