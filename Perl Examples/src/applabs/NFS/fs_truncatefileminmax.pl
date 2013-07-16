#!/usr/bin/perl -w
#
# TestPlan: NFS Test
#
# Written by :  AppLabs Technologies
#
# Date : 03/21/2005
#
# Modified Date : 03/25/2005
#
# Description :This Script is to create a large file with the given size and truncate the file to a specified Lesser or Higher size 
#
# PASS : If the file is truncated to the given size, FAIL otherwise
#

use global_library;
use Getopt::Long;
use strict;

my $timestorun =1;	#Default Number of times to run the Script
my $filesize=1048576;	#Default File Size
my $truncsize=4096;	#Default TruncSize
my $chunksize=4096;	#Default chunk size to be written at a time in the file


&GetOptions('help'=> \my $help,
	    'fsmount=s'=> \my $localmountpoint,
	    'filesize=i'=> \$filesize,
	    'chunksize=i'=> \$chunksize,
	    'truncsize=i'=> \$truncsize,
	    ,'debug=i'=>\$global_library::Debug,'timestorun=i'=> \$timestorun );


if($help)
{
	print("\nThis Script is to create a large file with the given size and truncate the file to a specified Lesser or Higher size.\n");
	print("\nperl fs_truncatefileminmax.pl --fsmount <local mount point> --filesize <filesize in bytes> --chunksize <chunk size in bytes> --truncsize <trunc size in bytes> --timestorun <number>\n\n");
	exit;
}
print "\nThis script is running on $^O Operating System.\n";
$localmountpoint=&global_library::RemoveSlash($localmountpoint);
my $workingdirectory="/TC_C_3839";
my $testscriptname="fs_truncatefileminmax.pl"; #TC_C_38 & TC_C_39
my $expectedresult="File should be truncated to a given size.";
my $largefile="/TestLargeFile";

print "TEST SCRIPT NAME : $testscriptname\n";
print "EXPECTED RESULT : $expectedresult\n";

if (-e $localmountpoint)
{
	for(my $ctr=1;$ctr<=$timestorun ;$ctr++)
	{
		print "Script Run Count : $ctr\n";
		if (!&global_library::CreateWorkingDirectory("$localmountpoint$workingdirectory"))
		{
				&global_library::WriteStatus("E",$testscriptname);	
				exit 2;
		}
		if(!&global_library::WriteLargeFile("$localmountpoint$workingdirectory$largefile","$filesize","$chunksize"))
		{
			&global_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");
			&global_library::WriteStatus("E",$testscriptname);
			exit 2;
		}
		if(!&global_library::TruncateFile("$localmountpoint$workingdirectory$largefile","$truncsize"))
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
	&global_library::PrintStatus("Mount point does not exist. Test execution terminated.\n");
	&global_library::WriteStatus("E",$testscriptname);
	exit 2;
}
