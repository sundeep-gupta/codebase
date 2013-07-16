#!/usr/bin/perl
use Bubble::FileUtils;
use File::Find;
use File::Copy;
my ($dir, $extn, $recursive) = @ARGV;
$recursive = 0;
$recursive = 1 if $recursive;
&usage() unless $dir || -d $dir || $extn;
&Bubble::FileUtils::change_extension($dir, $extn, $recursive);

sub usage() {
    print "Usage : $ARGV[0] <dir> <extn> [1]"
    exit(0);
}