#!/usr/bin/perl -w
#
# TestPlan: NFS Test
#
# Written by :  AppLabs Technologies
#
# Date : 03/14/05
# Modified On : 03/30/05
# Description : Creating N number of files of specified size using N number of threads on NFS server
#
# PASS : If files are created sucessfully, FAIL otherwise
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
        print "This script creates N number of files of specified size using N number of threads.\n";
        print "Example: #perl fs_writethreads.pl --fsmount <local mount point> --threadcount <number of threads> --filesize <size of each file in bytes> --chunksize <chunk size in bytes> --timestorun <number>\n";
        exit;
}

$localmountpoint=&thread_library::RemoveSlash("$localmountpoint");
$workingdirectory="/TC_C_19";
my $testscriptname="fs_writethreads.pl";#TC_C_19
print "\nThe script is running on $^O Operating System.\n";
print "TEST SCRIPT NAME: $testscriptname\n";
print "EXPECTED RESULT: N number of files of specified size should be created successfully on the NFS server\n";
$fc=$threadcount;

my @pid;
my $ppid=$$;

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
		#Creating files starts here
		&thread_library::PrintStatus("Creating the Files\n");
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
				if(!&thread_library::WriteLargeFile("$localmountpoint$workingdirectory$global_variables::FileName$fc",$filesize,$chunksize))
				{
					&thread_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");
					&thread_library::WriteStatus("E",$testscriptname);
					print "Killing The Running Threads => ";
					kill 9,$ppid;
					kill 9,@pid;
					exit 2;
				}
				exit 0;
			} 
			else 
			{ 
    				# fork returned neither 0 nor undef, 
			    	# so this branch is the parent
				$pid[$fc]=$kidpid;
			}
		}#Creating files ends here
    	    	for($i=1;$i<=$threadcount;$i++)
 		{
 	  		waitpid($pid[$i],0);
 		}
		#Verifying files creation starts here
		$fc=$threadcount;	
		&thread_library::PrintStatus("Verifying the Files Creation\n");
		for($i=1;$i<=$threadcount;$i++)
 		{
 			if(!&thread_library::GetAttribute("$localmountpoint$workingdirectory$global_variables::FileName$i"))
			{
				&thread_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");
				&thread_library::WriteStatus("F",$testscriptname);
				exit 1;
			}
 		}
		&thread_library::PrintStatus("Verified the Files Creation Successfully\n");
		#Verifying files creation ends here
		&thread_library::RemoveWorkingDirectory("$localmountpoint$workingdirectory");
		$fc=$threadcount;
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

