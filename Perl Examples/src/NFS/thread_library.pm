#---------------------------------------------------------------#
#		Global Library File for NFS Tests 		#
#---------------------------------------------------------------#

package thread_library;
require Exporter;
use global_variables;
use POSIX qw/strftime/; 

our @ISA=qw(Exporter);
our @EXPORT=qw();
our @EXPORT_OK=qw();
our $VERSION=1.0;
use strict;


#Creating a 0 byte file
sub CreateFile
{
	chomp(my $filename=$_[0]);
	thread_library::PrintStatus("Creating File ->$filename");
	if(open(fhOUT,">$filename"))
	{
		thread_library::PrintStatus("File $filename Created");
		close(fhOUT);
		return 1;
	}
	else
	{
		thread_library::PrintStatus("File $filename Couldn't be Created");
		close(fhOUT);
		return 0;
	}
}


#Creating a regular directory
sub CreateDirectory
{
	
	chomp(my $directoryname=$_[0]);
	thread_library::PrintStatus("Creating Directory ->$directoryname");
	if(mkdir $directoryname)
	{
		thread_library::PrintStatus("Directory Created ->$directoryname");
		return 1;
	}
	else
	{
		thread_library::PrintStatus("Directory $directoryname Could not be Created");
		return 0;
	}
}

#Creating the Working Directory 
sub CreateWorkingDirectory 
{ 
	chomp(my $directoryname=$_[0]); 
	system("chmod -R 777 $directoryname > /dev/null 2> /dev/null");
	#Using unix command for recursive deletion of files.
	system("rm -rf $directoryname");
	if(mkdir($directoryname)) 
	{ 
		&thread_library::PrintStatus("Creation of working directory $directoryname successful."); 
		return 1; 
	} 
	else 
	{ 
		&thread_library::PrintStatus("Working directory $directoryname could not be created."); 
		return 0; 
	}
}
#Writing large contents into the file
sub WriteLargeFile
{
    my $filename=$_[0];
    my $filesize=$_[1];
    my $chunksize=0 x $_[2];
    thread_library::PrintStatus("Writing File $filename");
    if (open fhOUT,">$filename")
    {
        while($filesize>0)
        {
            if($filesize > $_[2])
            {
                print fhOUT $chunksize;
                $filesize=$filesize-$_[2];
            }
            else
            {
                print fhOUT 0 x $filesize;
                $filesize=0;
            }
        }   
        close(fhOUT);
	   thread_library::PrintStatus("File $filename Created/Written Successfully");	
        return 1;
    }
    else
    {
	   thread_library::PrintStatus("File $filename Couldn't be Created/Written");	
        return 0;
    }
}

#Removing file
sub RemoveFile
{
	chomp(my $filename=$_[0]);
	thread_library::PrintStatus("Removing File $filename");
	if (unlink $filename)
	{
		thread_library::PrintStatus("File $filename Removed Successfully");
		return 1;
	}
	else
	{
		thread_library::PrintStatus("File $filename Couldn't be Removed");
		return 0;
	}
}




#Removing Working Directory 
sub RemoveWorkingDirectory 
{ 
	&thread_library::PrintStatus("Removing working directory."); 
	chomp(my $directoryname=$_[0]); 
	system("chmod -R 777 $directoryname > /dev/null 2> /dev/null");#For Chmod relates Scripts 
	#Using a unix command for recursive deletion of files.
	my $cmdstatus=system("rm -fr $directoryname > $global_variables::ArcLog 2>$global_variables::ArcErrLog"); 
	if ($cmdstatus eq 0) 
	{ 
		&thread_library::PrintStatus("Removal of working directory successful."); 
		return 1; 
	} 
	else 
	{ 
		&thread_library::PrintStatus("Working directory could not be removed"); 
		return 0;
	} 
} 

#Removing directory
sub RemoveDirectory
{
	chomp(my $directoryname=$_[0]);
	thread_library::PrintStatus("Removing Directory $directoryname");
	my $cmdstatus=system("rm -rf $directoryname");
	if ($cmdstatus eq 0)
	{
		thread_library::PrintStatus("Directory $directoryname Removed Successfully");
		return 1;
	}
	else
	{
		thread_library::PrintStatus("Directory $directoryname Couldn't be Removed");
		return 0;
	}
}
	

#Reading the file using buffer with parameter filename
sub ReadUsingBuffer
{
        chomp(my $filename=$_[0]);
        chomp(my $buffersize=$_[1]);
	   if(open(fhIN,$filename))
        {
			 my $Buffer;
                undef $Buffer;
                my $cmdstatus=1;
                print "Reading $filename -> ";
                while(read(fhIN,$Buffer,$buffersize))
                {
                        print ".";
                        $cmdstatus=0;
                }
                close(fhIN);
                if($cmdstatus eq 0)
                {
                        print "\n";
				    return 1;
                }
                else
                {
				    return 0;
                }
        }
        else
        {
			 thread_library::PrintStatus("File $filename Couldn't be Read\n");
                return 0;
        }
}


#Creating symbolic link
sub CreateLink
{
	chomp(my $source=$_[0]);
	chomp(my $target=$_[1]);
	thread_library::PrintStatus("Creating Link =>$target");
	if (symlink $source,$target)
	{
		thread_library::PrintStatus("Link =>$target Created Successfully");
		return 1;
	}
	else
	{
		thread_library::PrintStatus("Link =>$target Couldn't be Created");
		return 0;
	}
}


#Verifying symbolic link
sub VerifyLink
{
	chomp(my $sourceobj=$_[0]);
	chomp(my $targetobj=$_[1]);
	my $cmdstatus=readlink("$targetobj");
	if ($cmdstatus eq $sourceobj)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

#Getting attributes of file/directory
sub GetAttribute
{
   chomp(my $object=$_[0]);
   if (stat($object))
   {
       return 1;
   }
   else
   {
       return 0;
   }
} 



#Getting Date
sub GetDate
{
	my $date=strftime("%A, %B %d, %Y", localtime(time()));
	return $date;
}
	

#Getting Time
sub GetTime
{
	my $time=strftime("%H:%M:%S", localtime(time()));
	return $time;
}
	
#Writing the final status of test case execution
#P = Pass
#F = Fail
#E = Error in Exectution
sub WriteStatus
{
    chomp(my $testscriptname=$_[1]);
    chomp(my $teststatus=$_[0]);
    my $exdate=GetDate();
    my $extime=GetTime();
    open(fhOUT,">>$global_variables::TestCaseExStatus");
    if($teststatus eq "P")
    {
        print fhOUT "$testscriptname\t:\t0=Pass\t:\t$exdate->$extime\n";
        print "TEST CASE EXECUTION STATUS: Test Execution Completed With Code 0=Pass\n";
    }
    elsif($teststatus eq "F")
    {
        print fhOUT "$testscriptname\t:\t1=Fail\t:\t$exdate->$extime\n";
        print "TEST CASE EXECUTION STATUS: Test Execution Completed With Code 1=Fail\n";
    }
    elsif($teststatus eq "E")
    {
        print fhOUT "$testscriptname\t:\t2=Error\t:\t$exdate->$extime\n";
        print "TEST CASE EXECUTION STATUS: Test Execution Completed With Code 2=Error\n";
    }
    close(fhOUT);
}


#Code to remove extra slash.
sub RemoveSlash
{
   chomp(my $mountpath = $_[0]);
   my $lastchar=chop($mountpath);
   if($lastchar eq "/")
   {
       return $mountpath;
   }
   else
   {
       $mountpath = "$mountpath" . "$lastchar";
       return $mountpath;
   }
}

#Remove symbolic link
sub RemoveLink
{
	chomp(my $sourceobj=$_[0]);
	chomp(my $targetobj=$_[1]);
	my $cmdstatus=unlink("$targetobj");
	if ($cmdstatus!=0)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}


#Print Status
 sub PrintStatus
 {
 	chomp(my $status=$_[0]);
 	print "TEST CASE EXECUTION STATUS: $status\n";
 }
