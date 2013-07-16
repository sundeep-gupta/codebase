#!/usr/bin/perl
use strict;

use Fcntl qw(:flock SEEK_END);
use MIME::Parser;
my $parser = MIME::Parser->new();
my $tempFolder = "/tmp/gmail";
mkdir $tempFolder;
$parser->output_under($tempFolder);
my $file = "/Volumes/Bubble/gmail/Messages/2628.emlx";
open (my $fh, ">>", $file) or die "Unable to open file";
flock($fh, LOCK_EX) or die "Lock failed\n";
sleep(10);

my $entity = $parser->parse($fh);
use Data::Dumper;
print Dumper($entity);
