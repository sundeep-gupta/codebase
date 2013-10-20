#!/usr/bin/perl
use File::Find;
use Cwd;
use Time::HiRes qw(gettimeofday);
use POSIX qw/strftime/;

sub map {
	@drives = ('k:','l:','m:');
	foreach (@drives) {
		$del = system("net use $_ /delete");
		print $del;
		$res = system("net use $_ \\\\apollo\\engineering\\sqa");
		if ($res == 0) {
			exit;
		}
	}
}

sub remove_slash {
	$x = "c:\kumar\\";
	if (substr($x,length($x)-1,1) eq "\\") {
		print $x."\\";
	}
	else{
		print $x."\\\\";
	}
}

sub large_file{
	open(FH,">binary") or die "Cannot open file\n";
	#print FH pack( "c",rand(255 ));
	#print FH map (pack( "c",rand(255 )) ,  1..(1024*1024));


	print FH ("0" x 1048576);
	close(FH);
}

sub get_micro {
# get seconds and microseconds since the epoch
	  ($s, $usec) = gettimeofday();
	print $s;
	print "\n";
	print $usec;
	print "\n";
	system("dir>file");
	  ($s, $usec) = gettimeofday();
	print $s;
	print "\n";
	print $usec;
}

sub find_replace{
	$x = getcwd;
	$x =~ s/\//\\\\/g;
	$x = $x."\\\\";
	print $x;
}

#Getting Date
sub GetDate
{
	my $date=strftime("%B %d, %Y", localtime(time()));
	return $date;
}


#Getting Time
sub GetTime
{
	my $time=strftime("%H:%M:%S", localtime(time()));
	return undef;
}

if ((my $x = GetTime()) eq undef)
{
	print $x;
}
else
{
	print "No time";
}