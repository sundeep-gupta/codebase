#!/usr/bin/perl
use strict;

my ($drive_letter, $ip) = @ARGV;

#VARIABLE DECLARATIONS
my $outFile = "C${drive_letter}Time.txt";
my %read_list = ("${drive_letter}:\\*.dat" => "NUL:");
my $networkPath = "\\\\10.0.3.$ip\\share";
						
my $unmapFile = "unmap${drive_letter}.txt";
my $mapFile = "map${drive_letter}.txt";

for (; ;) {
	if (unmapDrive($drive_letter.":", $unmapFile) && mapDrive($drive_letter.":", $networkPath, $mapFile)) {
		sleep(3);
		my ($key1, $value1);
		while (($key1,$value1) = each(%read_list)) {
			sleep(2);
			exit if ( copy_files($key1,$value1,$outFile) == 0);
		}
	}
}

# UNMAP THE NETWORK DRIVE
sub unmapDrive {
#check if drive letter is valid
my( $drive, $mapFile ) = @_;
	#print "net use $drive /del /y > $mapFile 2>&1";
	print `net use $drive /del /y > $mapFile 2>&1`;
	sleep 1;

	# CHECK IF UNMAPPING WAS SUCCESSFUL
	if(!($? == -1 || ( $? & 127 ) ) && ( -f $mapFile )) {
		open(FILE_HANDLE, $mapFile);
		foreach  (<FILE_HANDLE>) {
			if (/(The network connection could not be found|There are no entries in the list|command completed successfully|was deleted successfully.)/) {
				print "UNMapping successful\n";
				return 1;
			}
		}
		close(FILE_HANDLE);
	} 
	print "UnMapping Failed";
	return 0;
}

# MAP THE NETWORK DRIVE
sub mapDrive {
my( $drive, $networkPath, $mapFile ) = @_;
print "net use $drive $networkPath > $mapFile 2>&1";
	print `net use $drive $networkPath > $mapFile 2>&1`;

	# IF MAPPING UNSUCCESSFUL THEN DISCONTINUE.

	if( !($? == -1 || ( $? & 127 )) && (-f $mapFile)) {
		open(FILE_HANDLE, $mapFile);
		foreach  (<FILE_HANDLE>) {
			if (/(command completed successfully)/) {
				print "Mapping successful\n";
				return 1;
			}
		}
		close(FILE_HANDLE);
	}
	print "Mapping Failed";
	return 0;
}
# SPAWN A COPY OPERATION and RESULTS SENT TO ONE FILE

sub copy_files {
my ( $src, $dst, $outFile) = @_;
	print `copy $src $dst /z >> $outFile 2>&1`;
	if( !($? == -1 || ( $? & 127 ) ) && ( -f $outFile)) {
		open(FILE_HANDLE, $outFile);
		foreach  (<FILE_HANDLE>) {
			if (/(drive specified|operation|network path|another process|semaphore|timeout|expired|sharing|unable|access|error)/i) {
				print "Test failed.\n" , $_;
				return 0;
			}
		}
		close(FILE_HANDLE);
		print "Copy Successful\n $?";
		#YOU CAN CALCULATE THROUGHPUT HERE.
		return 1;
	}
	print "Copy Failed";
	return 0;
}