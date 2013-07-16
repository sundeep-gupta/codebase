#!/usr/bin/perl
my $directory;
# if argument passed then browse through the given directory
# else browse through current directory.
if(length(@ARGV[0]) == 0) {
	 $directory = ".";
} else {
	$directory = @ARGV[0];
}

#initialize the array that must contain the list of files in given directory
my @myArr = {};
if(-e $directory) {
	getValidFiles($directory);
	# Now @myArr will contain the list of the files (recursively) in the given directory.
	foreach  (@myArr) {
		print $_."\n";
	}
} 

#recursive subroutine which checks if the given argument is a directory or not. 
# if directory then call the function again 
# if it is a file then just add the name of the file to the array list.
sub getValidFiles {
	my $directory = shift;
	if( -d $directory) {
		opendir(my( $DIR_HANDLE), $directory);
		my @list = readdir($DIR_HANDLE);
		shift(@list); shift(@list);
		foreach (@list) {
			getValidFiles($directory."\\".$_);
		}
	} else {
		push(@myArr,$directory);
	}
	close($DIR_HANDLE);
}


