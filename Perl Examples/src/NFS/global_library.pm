#---------------------------------------------------------------#
#		Global Library File for NFS Tests 		#
#---------------------------------------------------------------#

package global_library;
require Exporter;
use global_variables;
use POSIX qw/strftime/;
use strict;
use File::Copy;

our @ISA=qw(Exporter);
our @EXPORT=qw();
our @EXPORT_OK=qw();
our $VERSION=1.0;


#Creating a 0 byte file
sub CreateFile
{
	chomp(my $filename=$_[0]);
	&global_library::PrintStatus("Creating a zero byte file : $filename");
	if(open(CREATENEWHANDLE,">$filename"))
	{
		&global_library::PrintStatus("Creating file $filename successful.");
		close(CREATENEWHANDLE);
		return 1;
	}
	else
	{
		&global_library::PrintStatus("File $filename could not be created. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Renaming a file
sub RenameFile
{
	chomp(my $oldfilename=$_[0]);
	chomp(my $newfilename=$_[1]);
	&global_library::PrintStatus("Renaming the file $oldfilename to $newfilename");
	if(rename $oldfilename,$newfilename)
	{
		&global_library::PrintStatus("Renaming $oldfilename to $newfilename successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("File $oldfilename could not be renamed. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Function to read contents of a directory.
sub ReadDirect
{
	chomp(my $dirname=$_[0]);
	&global_library::PrintStatus("Reading contents of directory $dirname in a loop.");
	if(opendir(DIR, $dirname))
	{
		if(readdir(DIR))
		{
			my @allfiles= grep !/^\.\.?$/, readdir(DIR);
			my $dir;
			foreach $dir (@allfiles)
			{
				&global_library::PrintStatus("File/Directory $dir exists.");
			}
			closedir DIR;
			&global_library::PrintStatus("Reading directory $dirname successful.");
			return 1;
		}
		else
		{
			&global_library::PrintStatus("Could not read directory $dirname. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
			return 0;
		}
	}
	else
	{
		&global_library::PrintStatus("Could not open directory $dirname. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Renaming directory
sub RenameDir
{
	chomp(my $olddirname=$_[0]);
	chomp(my $newdirname=$_[1]);
	&global_library::PrintStatus("Renaming directory $olddirname to $newdirname");
	if(rename $olddirname,$newdirname)
	{
		&global_library::PrintStatus("Renaming directory $olddirname to $newdirname successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Directory $olddirname could not be renamed. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Verifying the Renaming of file/directory on the NFS server
sub VerifyFileDirRename
{
	chomp(my $verifyingobj=$_[0]);
	&global_library::PrintStatus("Verifying rename of $verifyingobj");
	if(stat($verifyingobj))
	{
       		&global_library::PrintStatus("Renamed file exists, rename verification successful.");
	   	return 1;
   	}
   	else
   	{
       		&global_library::PrintStatus("Renamed file does not exist, rename verification failed. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
	   	return 0;
	}
}

#Creating a regular directory
sub CreateDirectory
{
	chomp(my $directoryname=$_[0]);
	&global_library::PrintStatus("Creating directory $directoryname");
	if(mkdir($directoryname))
	{
		&global_library::PrintStatus("Directory creation $directoryname successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Directory $directoryname could not be created. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}
#Creating the Working Directory
sub CreateWorkingDirectory
{
	chomp(my $directoryname=$_[0]);
	system("chmod -R 777 $directoryname > $global_variables::ArcLog 2>$global_variables::ArcErrLog");
	#Using unix command for recursive deletion of files.
	system("rm -rf $directoryname");
	&global_library::PrintStatus("Creating working directory $directoryname.");
	if(mkdir($directoryname))
	{
		&global_library::PrintStatus("Creation of working directory $directoryname successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Working directory $directoryname could not be created. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Changing the Directory
sub ChangeDirectory
{
	chomp(my $chdirname=$_[0]);
	&global_library::PrintStatus("Changing directory to $chdirname");
        if(chdir($chdirname))
        {
		&global_library::PrintStatus("Changing directory to $chdirname succeeded.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Could not change directory to $chdirname. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Writing into the file
sub WriteFile
{
	chomp(my $filename=$_[0]);
	&global_library::PrintStatus("Writing into file $filename");
	if(open(WRITEFILE,">$filename"))
	{
		for(my $ctr=1;$ctr<=10;$ctr++)
		{
			print WRITEFILE "This is line number $ctr in file $filename\n";
		}
		close(WRITEFILE);
		&global_library::PrintStatus("Writing to file $filename successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Could not open file $filename for writing. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Writing large contents into the file
sub WriteLargeFile
{
	my $filename=$_[0];
	my $filesize=$_[1];
	my $chunksize=0 x $_[2];
	&global_library::PrintStatus("Creating/Writing large file $filename");
	if (open WRITELARGE,">$filename")
    	{
        	while($filesize>0)
        	{
        		if($filesize > $_[2])
            		{
                		print WRITELARGE $chunksize;
                		$filesize=$filesize-$_[2];
            		}
            		else
            		{
                		print WRITELARGE 0 x $filesize;
                		$filesize=0;
            		}
        	}
        	close(WRITELARGE);
        	&global_library::PrintStatus("Writing to file $filename successful.");
		return 1;
    	}
    	else
    	{
        	&global_library::PrintStatus("Could not create/write file $filename. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
    	}
}

# Function to verify if a directory is removed.
sub VerifyRemoveDirectory()
{
	chomp(my $dirname=$_[0]);
	&global_library::PrintStatus("Verifying existence of directory $dirname");
	if(stat($dirname))
	{
		&global_library::PrintStatus("Directory $dirname exists.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Directory $dirname does not exist. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Verifying the Existence of File
sub VerifyFileExists
{
	chomp(my $filename=$_[0]);
	&global_library::PrintStatus("Verifying existence of file $filename");
	my $permissions;
	if(stat($filename))
	{
		&global_library::PrintStatus("File $filename exists.");
		my $mode = (stat($filename))[2] & 07777;
		my $x=($mode & 00700)>>6;
		my $y=($mode & 00070)>>3;
		my $z=($mode & 00007);
		$permissions = $x.$y.$z;
		return $permissions;
	}
	else
	{
		&global_library::PrintStatus("File $filename does not exist. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Verifying the creation of file/directory on the NFS server
sub VerifyFileDirCreation
{
	chomp(my $verifyingobj=$_[0]);
	&global_library::PrintStatus("Verifying existence of $verifyingobj");
	if(stat($verifyingobj))
	{
		&global_library::PrintStatus("Verification of $verifyingobj successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Verification failed. $verifyingobj does not exist. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}

}

#Removing file
sub RemoveFile
{
	chomp(my $filename=$_[0]);
	&global_library::PrintStatus("Removing file $filename");
	if(unlink($filename))
	{
		&global_library::PrintStatus("Removing file $filename successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("File $filename could not be removed. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Removing Working Directory
sub RemoveWorkingDirectory
{
	&global_library::PrintStatus("Removing working directory.");
	chomp(my $directoryname=$_[0]);
	system("chmod -R 777 $directoryname > $global_variables::ArcLog 2>$global_variables::ArcErrLog");#For Chmod related Scripts
	#Using a unix command for recursive deletion of files.
	my $cmdstatus=system("rm -fr $directoryname > $global_variables::ArcLog 2>$global_variables::ArcErrLog");
	open(ERRORHANDLE,"$global_variables::ArcErrLog");
	my $errormsg=<ERRORHANDLE>;
	close(ERRORHANDLE);
	if ($cmdstatus eq 0)
	{
		&global_library::PrintStatus("Removal of working directory successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Working directory could not be removed. \nTEST CASE EXECUTION STATUS: Reported Message : $errormsg");
		return 0;
	}
}

#Removing an empty directory
sub RemoveDirectory
{
	chomp(my $directoryname=$_[0]);
	&global_library::PrintStatus("Removing directory $directoryname");
	if(rmdir($directoryname))
	{
		&global_library::PrintStatus("Removing directory $directoryname successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Directory $directoryname could not be removed. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Reading the file
sub FileRead
{
	chomp(my $filename=$_[0]);
	&global_library::PrintStatus("Reading file $filename");
	if(open(READHANDLE,"$filename"))
	{
		my $cmdfilelines = 0;
		while(<READHANDLE>)
		{
			$cmdfilelines++;
		}
		close(READHANDLE);
		if($cmdfilelines != 0)
		{
			&global_library::PrintStatus("Reading file $filename successful.");
			return 1;
		}
		else
		{
			&global_library::PrintStatus("Could not read file $filename. Could be an empty file.");
			return 0;
		}
	}
	else
	{
		&global_library::PrintStatus("Could not open $filename for reading. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Reading the file using buffer
sub ReadFileUsingBuffer
{
   	chomp(my $filehandle=$_[0]);
   	chomp(my $buffersize=$_[1]);
   	my $buffer;
   	undef $buffer;
   	&global_library::PrintStatus("Reading file $filehandle with buffer size $buffersize.");
   	my $cmdstatus=1;
   	while(read($filehandle,$buffer,$buffersize))
   	{
       		print ".";
       		$cmdstatus=0;
   	}
   	if($cmdstatus eq 0)
   	{
       		print "\n";
       		return 1;
       		&global_library::PrintStatus("Reading file $filehandle with buffer successful.");
   	}
   	else
   	{
       		&global_library::PrintStatus("File could not be read using buffer. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
   	}
}

#Reading the file using buffer with parameter filename
sub ReadUsingBuffer
{
        chomp(my $filename=$_[0]);
        chomp(my $buffersize=$_[1]);
	&global_library::PrintStatus("Reading file $filename with buffer size of $buffersize bytes");
        if(open(fhIN,$filename))
        {
        	my $buffer;
                undef $buffer;
                my $cmdstatus=1;
                print "Reading $filename -> ";
                while(read(fhIN,$buffer,$buffersize))
                {
                        print ".";
                        $cmdstatus=0;
                }
                close(fhIN);
                if($cmdstatus eq 0)
                {
                        print "\n";
                        &global_library::PrintStatus("Reading file $filename with buffer successful.");
			return 1;
                }
                else
                {
                        &global_library::PrintStatus("Could not read file with buffer.\nTEST CASE EXECUTION STATUS: Reported Message : $!");
			return 0;
                }
        }
        else
        {
        	&global_library::PrintStatus("Could not open file in read mode.\nTEST CASE EXECUTION STATUS: Reported Message : $!");
                return 0;
        }
}

#Creating symbolic link
sub CreateLink
{
	chomp(my $source=$_[0]);
	chomp(my $target=$_[1]);
	&global_library::PrintStatus("Creating symbolic link $target to $source");
	if(symlink($source,$target))
	{
		&global_library::PrintStatus("Symbolic link $target to file $source created.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Symbolic link $target to file $source could not be created.\nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Create Hard Link (Out of Scope)
sub CreateHardLink
{
	chomp(my $source=$_[0]);
	chomp(my $target=$_[1]);
	&global_library::PrintStatus("Creating non-symbolic link $target to $source.");
	if(link($source,$target))
	{
		&global_library::PrintStatus("Non-symbolic link $target to file $source created.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Non-symbolic link $target to file $source could not be created.\nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Verifying symbolic link
sub VerifyLink
{
	chomp(my $source=$_[0]);
	chomp(my $target=$_[1]);
	&global_library::PrintStatus("Verifying symlink $target");
	if(my $readtarget=readlink $target)
	{
		if($source eq $readtarget)
		{
			&global_library::PrintStatus("Symlink verification successful.");
			return 1;
		}
		else
		{
			&global_library::PrintStatus("Symlink does not point to source file.");
			return 0;
		}
	}
	else
	{
		&global_library::PrintStatus("Symlink does not exist.\nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Verify a link stat.
sub VerifyLinkStat
{
      	chomp(my $linkobject=$_[0]);
      	&global_library::PrintStatus("Looking up for symlink $linkobject");
	if(lstat($linkobject))
      	{
       		&global_library::PrintStatus("Symlink lookup successful.");
		return 1;
      	}
      	else
      	{
              	&global_library::PrintStatus("Symlink lookup failed.\nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
      	}
}

#Getting attributes of file/directory
sub GetAttribute
{
   	chomp(my $object=$_[0]);
   	&global_library::PrintStatus("Retrieving attributes of $object");
   	if(stat($object))
   	{
       		&global_library::PrintStatus("Retrieving attributes successful.");
	   	return 1;
   	}
   	else
   	{
       		&global_library::PrintStatus("Retrieving attributes failed.\nTEST CASE EXECUTION STATUS: Reported Message : $!");
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
        &global_library::PrintStatus("Test execution completed with code 0=Pass");
    }
    elsif($teststatus eq "F")
    {
        print fhOUT "$testscriptname\t:\t1=Fail\t:\t$exdate->$extime\n";
        &global_library::PrintStatus("Test execution completed with code 1=Fail");
    }
    elsif($teststatus eq "E")
    {
        print fhOUT "$testscriptname\t:\t2=Error\t:\t$exdate->$extime\n";
        &global_library::PrintStatus("Test execution completed with code 2=Error");
    }
    close(fhOUT);
}

#CHMOD for a file
sub ChmodFile
{
        chomp(my $filename=$_[0]);
        chomp(my $perm=$_[1]);
	&global_library::PrintStatus("Changing permissions of file $filename to $perm.");
        if(system("chmod $perm $filename > $global_variables::ArcLog 2>$global_variables::ArcErrLog"))
        {
		open(ERRORHANDLE,"$global_variables::ArcErrLog");
		my $errormsg=<ERRORHANDLE>;
		close(ERRORHANDLE);
		&global_library::PrintStatus("Changing file permissions for $filename failed.\nTEST CASE EXECUTION STATUS: Reported Message : $errormsg");
		return 0;
        }
        else
        {
		&global_library::PrintStatus("Changing file permissions for $filename successful.");
		return 1;
	}
}

#CHMOD for a Directory
sub ChmodDir
{
           chomp(my $dirname=$_[0]);
           chomp(my $dirperm=$_[1]);
           &global_library::PrintStatus("Changing the directory permissions to $dirperm for $dirname");
	   if(system("chmod $dirperm $dirname > $global_variables::ArcLog 2>$global_variables::ArcErrLog"))
	   {
		open(ERRORHANDLE,"$global_variables::ArcErrLog");
		my $errormsg=<ERRORHANDLE>;
		close(ERRORHANDLE);
           	&global_library::PrintStatus("Could not change permissions for $dirname.  \nTEST CASE EXECUTION STATUS: Reported Message : $errormsg");
		return 0;
           }
           else
           {
	   	&global_library::PrintStatus("Changing permissions for directory $dirname successful.");
		return 1;
           }
}

#Function to truncate a file.
sub TruncateFile
{
	chomp(my $truncatefilename=$_[0]);
	chomp(my $truncatesize=$_[1]);
	&global_library::PrintStatus("Truncating file $truncatefilename to size $truncatesize bytes.");
	open(fileOUT,"+>>$truncatefilename");
	truncate fileOUT,$truncatesize;
	close(fileOUT);
	my $truncatedsize=(stat($truncatefilename))[7];
	if($truncatedsize eq $truncatesize)
	{
		&global_library::PrintStatus("File $truncatefilename has been truncated to specified size.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("File $truncatefilename could not be truncated to specified size.\nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Function to append a file.
sub AppendFile
{
	chomp(my $appendfilename=$_[0]);
	&global_library::PrintStatus("Retrieving initial file size.....");
	my $initialfilesize = &global_library::GetFileSize("$appendfilename");
	&global_library::PrintStatus("Appending file $appendfilename.");
	system("echo Junk to increate the file size by few bytes >> $appendfilename");
	&global_library::PrintStatus("Retrieving final file size.....");
	my $finalfilesize = &global_library::GetFileSize("$appendfilename");
	if($finalfilesize > $initialfilesize)
	{
		&global_library::PrintStatus("Appending $appendfilename successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Could not append file $appendfilename.");
		return 0;
	}
}

#Function to append a file.
sub MoveFile
{
	chomp(my $oldlocation=$_[0]);
	chomp(my $newlocation=$_[1]);
	&global_library::PrintStatus("Moving file from $oldlocation to $newlocation.");
	if(system("mv $oldlocation $newlocation  > $global_variables::ArcLog 2> $global_variables::ArcErrLog"))
	{
                open(ERRORHANDLE,"$global_variables::ArcErrLog");
                my $errormsg=<ERRORHANDLE>;
                close(ERRORHANDLE);
                &global_library::PrintStatus("Moving file failed. \nTEST CASE EXECUTION STATUS: Reported Message : $errormsg"); 
	   	return 0;
	}
	else
	{
		&global_library::PrintStatus("File moved.");
		return 1;
	}

}



#check directory permissions.
sub VerifyDirStat
{
        chomp(my $dirname=$_[0]);
        chomp(my $dirperm=$_[1]);
        &global_library::PrintStatus("Verifying directory permissions.");
	my $mode = (stat($dirname))[2] & 07777;
	my $x=($mode & 00700)>>6;
	my $y=($mode & 00070)>>3;
	my $z=($mode & 00007);
	if ("$dirperm" eq "$x$y$z")
	{
		&global_library::PrintStatus("Permissions verification successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Required permissions could not be verified.\nTEST CASE EXECUTION STATUS: Reported file permissions : $x$y$z");
		return 0;
	}
}

#Verify changed file permissions.
sub VerifyFileStat
{
        chomp(my $filename=$_[0]);
        chomp(my $fileperm=$_[1]);
	if(my $mode = (stat($filename))[2] & 07777)
	{
		my $x=($mode & 00700)>>6;
		my $y=($mode & 00070)>>3;
		my $z=($mode & 00007);
		&global_library::PrintStatus("Verifying file permissions.");
		if ("$fileperm" eq "$x$y$z")
		{
			&global_library::PrintStatus("Permissions verification successful.");
			return 1;
		}
		else
		{
			&global_library::PrintStatus("Required permissions could not be verified.\nTEST CASE EXECUTION STATUS: Reported file permissions : $x$y$z");
			return 0;
		}
	}
	else
	{
		&global_library::PrintStatus("Stats for specified files could not be retrieved.\nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Writing chunks into the file
sub WriteChunksToFile
{
	chomp(my $writefilename=$_[0]);
	chomp(my $chunksize=$_[1]);
	&global_library::PrintStatus("Writing $chunksize bytes of data to $writefilename");
	my $byteofdata = "A";
	my $chunkofdata ="";
	if (open WRITETOFILE,">>$writefilename")
	{
		$chunkofdata =  $byteofdata x $chunksize;
		print WRITETOFILE "$chunkofdata";
		close(WRITETOFILE);
		&global_library::PrintStatus("Writing $chunksize byte sized chunks to file $writefilename successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Could not write $chunksize byte sized chunks of data to $writefilename \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Return File size in bytes
sub GetFileSize
{
	chomp(my $file=$_[0]);
	my $filesize;
	if($filesize =(stat($file))[7])
	{
		&global_library::PrintStatus("File size returned : $filesize bytes.");
	}
	else
	{
		&global_library::PrintStatus("Could not retrieve size of $file. \nTEST CASE EXECUTION STATUS: Reported Message : $!");

	}
	return $filesize;

}

#Writing chunk of data into the file
sub WriteChunks
{
   	my $filename=$_[0];
   	my $filesize=$_[1];
   	my $chunksize=$_[2];
   	my $buffer=$_[3];
   	my $i;
   	if (open WRITECHUNKS,">$filename")
   	{
       		if ($chunksize eq 1)
       		{
       			for($i=1;$i<=1024*$filesize;$i++)
           		{
               			print WRITECHUNKS "$buffer";
           		}
       		}
       		if ($chunksize eq 2)
       		{
           		for($i=1;$i<=1024*$filesize;$i=$i+2)
           		{
               			print WRITECHUNKS "$buffer";
           		}
       		}
       		if ($chunksize eq 4)
       		{
           		for($i=1;$i<=1024*$filesize;$i=$i+4)
           		{
               			print WRITECHUNKS "$buffer";
           		}
       		}
       		if ($chunksize eq 8)
       		{
           		for($i=1;$i<=1024*$filesize;$i=$i+8)
           		{
               			print WRITECHUNKS "$buffer";
           		}
       		}
       		if ($chunksize eq 16)
       		{
           		for($i=1;$i<=1024*$filesize;$i=$i+16)
           		{
               			print WRITECHUNKS "$buffer";
           		}
       		}
       		if ($chunksize eq 32)
       		{
           		for($i=1;$i<=1024*$filesize;$i=$i+32)
           		{
               			print WRITECHUNKS "$buffer";
           		}
       		}
       		close(WRITECHUNKS);
  		&global_library::PrintStatus("Writing $chunksize byte sized chunks of data to file $filename successful.");
       		return 1;
   	}
   	else
   	{
   		&global_library::PrintStatus("Could not write $chunksize byte sized chunks of data to file $filename. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
       		return 0;
   	}
}

#Verifying the chunk size
sub CheckChunkSize
{
    	if ($_[0] eq 1 || $_[0] eq 2 || $_[0] eq 4 || $_[0] eq 8 || $_[0] eq 16 || $_[0] eq 32)
    	{
		&global_library::PrintStatus("Verification of chunk size successful.");
        	return 1;
    	}
    	else
    	{
		&global_library::PrintStatus("Chunk size could not be verified.\nTEST CASE EXECUTION STATUS: Reported Message : $!");
        	return 0;
    	}
}

#Function to create a user.
sub CreateUser
{
	chomp(my $username=$_[0]);
	&global_library::PrintStatus("Creating user $username.");

	# Using a unix commands to create user.
	system("userdel $username > $global_variables::ArcLog 2> $global_variables::ArcErrLog");
	if(system("useradd $username > $global_variables::ArcLog 2> $global_variables::ArcErrLog"))
	{
		open(ERRORHANDLE,"$global_variables::ArcErrLog");
		my $errormsg=<ERRORHANDLE>;
		close(ERRORHANDLE);
 		&global_library::PrintStatus("Could not create user $username.\nTEST CASE EXECUTION STATUS: Reported Message : $errormsg");
		return 0;
	}
	else
	{
		&global_library::PrintStatus("User account $username creation sccessful.");
		return 1;
	}
}

#Function to remove user.
sub RemoveUser
{
	chomp(my $username=$_[0]);
	&global_library::PrintStatus("Removing user $username.");
	# Using a unix command to delete a user.
	if(system("userdel  $username > $global_variables::ArcLog 2> $global_variables::ArcErrLog"))
	{
		open(ERRORHANDLE,"$global_variables::ArcErrLog");
		my $errormsg=<ERRORHANDLE>;
		close(ERRORHANDLE);
		&global_library::PrintStatus("Could not remove user $username.\nTEST CASE EXECUTION STATUS: Reported Message : $errormsg");
		return 0;
	}
	else
	{
		&global_library::PrintStatus("User account $username removal successful.");
		return 1;
	}
}

#Access File as limited user
sub AccessFileAsLimitedUser
{
   	chomp(my $filename=$_[0]);
   	chomp(my $username=$_[1]);
   	&global_library::PrintStatus("Accessing file $filename as limited user $username.");
   	#Using a unix command as perl does not support multiple user profile execution.
   	my $cmdstatus=system("sudo -u $username cat $filename > $global_variables::ArcLog 2> $global_variables::ArcErrLog");
   	open(ERRORHANDLE,"$global_variables::ArcErrLog");
	my $errormsg=<ERRORHANDLE>;
	close(ERRORHANDLE);
   	if($cmdstatus == 0)
   	{
	   	&global_library::PrintStatus("Could access file as limited user $username.");
       		return 1;
   	}
   	else
   	{
	   	&global_library::PrintStatus("Could not access file as limited user $username.\nTEST CASE EXECUTION STATUS: Reported Message : $errormsg");
       		return 0;
   	}
}

#Code to remove extra slash.
sub RemoveSlash
{
   	chomp(my $lnmountpath = $_[0]);
   	my $lastchar=chop($lnmountpath);
   	if($lastchar eq "/")
   	{
       		return $lnmountpath;
   	}
   	else
   	{
       		$lnmountpath = "$lnmountpath" . "$lastchar";
       		return $lnmountpath;
   	}
}

#Listing the files in given directory and returning the number of files
sub ListFiles
{
   	chomp(my $dir=$_[0]);
   	my $filecount=0;
	if(opendir(DIRTOLIST, $dir))
	{
		my @allfiles= grep !/^\.\.?$/, readdir(DIRTOLIST);
		my $dir;
		foreach $dir (@allfiles)
		{
			$filecount++;
		}
		closedir DIRTOLIST;
		return $filecount;
	}
	else
	{
		&global_library::PrintStatus("Could not open directory $dir. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
	}
}

#Remove symbolic link
sub RemoveLink
{
	chomp(my $source1=$_[0]);
	chomp(my $target1=$_[1]);
	&global_library::PrintStatus("Removing link $target1.");
	if(unlink($target1))
	{
		&global_library::PrintStatus("Removal of link $target1 successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Removal of link $target1 failed.\nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

# Get Status of file or directory
sub GetStat()
{
	chomp(my $directoryname=$_[0]);
	&global_library::PrintStatus("Retrieving statistics for $directoryname");
	my @stts = stat($directoryname);
	my $n = @stts;
	if ($n > 0)
    	{
		&global_library::PrintStatus("Retrieving statistics successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Retrieving statistics failed.\nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

#Writing chunks into the file
sub WriteChunksAtRandomToFile
{
	chomp(my $writefilename=$_[0]);
	chomp(my $chunksize=$_[1]);
	my $byteofdata = "0";
	my $chunkofdate ="";
	#code to generate random line number
	my $randlocation= int(rand 1000) + 1;
	if (open WRITETOFILE,">>$writefilename")
	{
		$chunkofdate =  $byteofdata x $chunksize;
		#code to seek a random location
		if(seek(WRITETOFILE, $randlocation,0))
		{
			print WRITETOFILE "$chunkofdate";
			close(WRITETOFILE);
			&global_library::PrintStatus("Writing chunks to $writefilename successful.");
			return 1;
		}
	}
	else
	{
		&global_library::PrintStatus("Could not write chunks to $writefilename \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}


# Write content to file as a regular user.
sub WriteFileAsRegUser
{
   	chomp(my $filename=$_[0]);
   	chomp(my $limiteduser=$_[1]);
   	my $return;
   	&global_library::PrintStatus ("Writing to $filename with limited user account $limiteduser.");
   	for(my $ctr=1;$ctr<=10;$ctr++)
   	{
       		my $cmdstatus = system("sudo -u $limiteduser echo Test Text >> $filename");
       		if($cmdstatus == 0)
       		{
                     	$return = 1;
       		}
       		else
       		{
                     	$return = 0;
       		}
   	}
   	if($return == 1)
   	{
   		&global_library::PrintStatus ("Writing to file as a limited user $limiteduser successful.");
   	}
   	else
   	{
   		open(ERRORHANDLE,"$global_variables::ArcErrLog");
		my $errormsg=<ERRORHANDLE>;
		close(ERRORHANDLE);
   		&global_library::PrintStatus ("Could not write to file as limited user $limiteduser.  \nTEST CASE EXECUTION STATUS: Reported Message : $errormsg");
   	}
   	return $return;
}


##########################################################
#          Master Script Functions			 #
#							 #
##########################################################
#Clean the log
sub CleanLogFile
{
   	chomp(my $verb=$_[0]);
   	if(open(CLEANLOG,">$_[0]"))
   	{
      		close(CLEANLOG);
		if($verb)
		{
			if(open(CLEANMSG,">scripts_output_msg"))
   			{
       				close(CLEANMSG);
   		 		return 1;
   			}
   			else
  			{
  				&global_library::PrintStatus("Could not open \"scripts_output_msg\" for cleaning.  \nTEST CASE EXECUTION STATUS: Reported Message : $!");
      			 	return 0;
   			}
		}
		return 1;
   	}
   	else
   	{
   		&global_library::PrintStatus("Could not access log file for cleaning. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
       		return 0;
   	}
}


#Wring the log
sub WriteLog
{
   chomp(my $teststatus=$_[0]);
   chomp(my $script=$_[1]);
   chomp(my $LogFile=$_[2]);
   	if(open(WRITELOG,">>$LogFile"))
   	{
    		my $exdate=GetDate();
       		my $extime=GetTime();
       		if($teststatus eq "P")
       		{
        	   	print WRITELOG "$script\t:\t0=Pass\t:\t$exdate->$extime\n";
       		}
       		elsif($teststatus eq "F")
       		{
        	   	print WRITELOG "$script\t:\t1=Fail\t:\t$exdate->$extime\n";
       		}
       		elsif($teststatus eq "E")
       		{
        	   	print WRITELOG "$script\t:\t2=Error\t:\t$exdate->$extime\n";
       		}
       		elsif($teststatus eq "I")
       		{
        	   	print WRITELOG "$script\t:\t3=Invalid\t:\t$exdate->$extime\n";
       		}
       		close(WRITELOG);
		&global_library::PrintStatus("Message written to log file.");
       		return 1;
   	}
   	else
   	{
	   	&global_library::PrintStatus("Could not open log file in write mode.  \nTEST CASE EXECUTION STATUS: Reported Message : $!");
       		return 0;
   	}
}

#Removing all file and directories
sub RemoveAll
{
	chomp(my $directoryname=$_[0]);
	#Using a unix specific command for recursive cleaning of files and directories.
	my $cmdstatus=system("rm -fr $directoryname/* 2> $global_variables::ArcErrLog");
	open(ERRORHANDLE,"$global_variables::ArcErrLog");
	my $errormsg=<ERRORHANDLE>;
	close(ERRORHANDLE);
	if ($cmdstatus eq 0)
	{
		&global_library::PrintStatus("Deleting directory $directoryname successful.");
		return 1;
	}
	else
	{
		&global_library::PrintStatus("Could not delete $directoryname.  \nTEST CASE EXECUTION STATUS: Reported Message : $errormsg");
		return 0;
	}
}


#Print Status
sub PrintStatus
{
	chomp(my $status=$_[0]);
	print "TEST CASE EXECUTION STATUS: $status\n";
}


#Running Script
sub RunScript
{
   	chomp(my $script=$_[0]);
   	chomp(my $verbose=$_[1]);
   	if($verbose)
   	{
       		my $exitcode=system("$script");
       		return $exitcode;
   	}
   	else
   	{
       		my $exitcode=system("$script >> scripts_output_msg");
       		return $exitcode;
   	}
}


#Return File size in bytes
sub GetObjSize
{
   chomp(my $file=$_[0]);
   my $filesize;
   $filesize =(stat($file))[7];
   if (defined $filesize)
   {
       &global_library::PrintStatus("File size returned : $filesize bytes.");
       return $filesize;
   }
   else
   {
       &global_library::PrintStatus("Could not retrieve size of $file. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
   }
}
#Write specified bytes to a file.
sub OverwriteWithBytes
{
	chomp(my $file=$_[0]);
	chomp(my $bytes=$_[1]);
	my $datachunk = "A" x $bytes;
	if (open(WRITEBYTES,">",$file))
	{
		if(print WRITEBYTES "$datachunk")
		{
			close(WRITEBYTES);
			&global_library::PrintStatus("Overwriting $file successful");
			&global_library::PrintStatus("Verifying file to be overwritten");
			chomp(my $finalsize = &global_library::GetObjSize("$file"));
			if($finalsize == $bytes)
			{
				&global_library::PrintStatus("Verification successful. File has been overwritten");
				return 1;
			}
			else
			{
				&global_library::PrintStatus("Verification failed. File was not overwritten. Final Size : $finalsize and Expected size : $bytes");
				return 0;
			}
		}
		else
		{
			close(WRITEBYTES);
			&global_library::PrintStatus("Could not overwrite file $file \nTEST CASE EXECUTION STATUS: Reported Message : $!");
			return 0;
		}

	}
	else
	{
		&global_library::PrintStatus("Could not open $file for writing. \nTEST CASE EXECUTION STATUS: Reported Message : $!");
		return 0;
	}
}

1;
