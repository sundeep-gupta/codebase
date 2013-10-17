#!/usr/bin/perl -w
#
# TestPlan: NFS Test
#
# Written by :  AppLabs Technologies
#
# Date : 03/31/05
#
# Description : Creating a file of specified size and writing the contents into the file simultaneously using N number of threads on NFS server
#
# PASS : If file is created and get modified from N number of threads simultaneously, FAIL otherwise
#


require thread_library;
use Getopt::Long;
use strict;

my ($help,$localmountpoint,$workingdirectory,$ctr,$fc,$kidpid,$i);
my $scriptruncount=1;
my $threadcount=10; #Number of Files
my $filesize=1048576; #Default File Size 1MB
my $chunksize=4096; #Defualt chunk size to be written at a time in the file
$thread_library::Debug=0;

&GetOptions('help'=>\$help,
            'fsmount=s'=>\$localmountpoint,
	       'threadcount=i'=>\$threadcount,
		  'filesize=i'=>\$filesize,
	       'chunksize=i'=>\$chunksize,
	       ,'debug=i'=>\$thread_library::Debug,'timestorun=i'=>\$scriptruncount);
if($help)
{
        print "This script creates a file of specified size and tries to modify the same file using N number of threads simultaneously.\n";
        print "Example: #perl fs_simultaneouswritethreads.pl --fsmount <local mount point> --threadcount <number of threads> --filesize <size of each file in bytes> --chunksize <chunk size in bytes> --timestorun <number>\n";
        exit;
}

$localmountpoint=&thread_library::RemoveSlash("$localmountpoint");
$workingdirectory="/TC_C_40";
my $testscriptname="fs_simultaneouswritethreads.pl";#TC_C_40
print "\nThe script is running on $^O Operating System.\n";
print "TEST SCRIPT NAME: $testscriptname\n";
print "EXPECTED RESULT: A file of specified size should be created and should get modified using N number of threads simultaneously\n";

my $ppid=$$;
my @pid;

if (-e $localmountpoint)
{
	for($ctr=1;$ctr<=$scriptruncount;$ctr++)
	{
		print "Script Run Count : $ctr\n";
		if (!&thread_library::CreateWorkingDirectory("$localmountpoint$workingdirectory"))
		{
			&thread_library::WriteStatus("E",$testscriptname);
			exit 2;
		}
		#Creating file starts here
		if(!&thread_library::CreateFile("$localmountpoint$workingdirectory$global_variables::FileName"))
		{
			&thread_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");
			&thread_library::WriteStatus("E",$testscriptname);
			exit 2;
		}
		
		#Writing into file starts here
		for($fc=1;$fc<=$threadcount;$fc++)
		{
			if (!defined($kidpid = fork())) 
			{
	    			# fork returned undef, so failed
		 		die "cannot fork: $!";
			}
			elsif ($kidpid == 0) 
			{
		    		# fork returned 0, so this branch is the child
				if(!&thread_library::WriteLargeFile("$localmountpoint$workingdirectory$global_variables::FileName",$filesize,$chunksize))
				{
					&thread_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");
					&thread_library::WriteStatus("F",$testscriptname);
					print "Killing The Threads => ";
					kill 9,$ppid;
					kill 9,@pid;
					exit 1;
				}
				exit 0;
			} 
			else 
			{ 
    				# fork returned neither 0 nor undef, 
			    	# so this branch is the parent
				$pid[$fc]=$kidpid;
			}
		}#Writing into file ends here
	    	for($i=1;$i<=$threadcount;$i++)
    		{
         		waitpid($pid[$i],0);
    		}
		&thread_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");
	}
	print "\n";
	&thread_library::WriteStatus("P",$testscriptname);
	print "\n";	
	exit 0;
}
else
{
	&thread_library::PrintStatus("Shared Resource Couldn't be Mounted. Execution Terminated");
	exit 2;
}

