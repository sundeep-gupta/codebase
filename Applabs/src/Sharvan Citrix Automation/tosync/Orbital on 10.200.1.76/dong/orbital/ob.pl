#!/usr/bin/perl
 
use strict;
use Data::Dumper;
use Getopt::Long;
use Pod::Usage;
use FileHandle;
use File::Copy;
 
my $OptHelp;
my $OptClass;
my $OptMan;
my $OptReleases;
my $OptPlatform;
my $OptBrand;
my $OptSetCurrentRelease;
my $OptCurrentRelease;
my $OptSetExecutable;
 
pod2usage(-verbose => 0, -exitval => 1) unless(@ARGV);
 
my $Ret = GetOptions('help|?'              => \$OptHelp,
                     'man'                 => \$OptMan,
                     'platform'            => \$OptPlatform,
                     'brand'               => \$OptBrand,
                     'class'               => \$OptClass,
                     'releases'            => \$OptReleases,
                     'setcurrentrelease=s' => \$OptSetCurrentRelease,
                     'currentrelease'      => \$OptCurrentRelease,
                     'setexecutable=s'     => \$OptSetExecutable);
 
pod2usage(-exitstatus => 2, -verbose => 2) if $OptMan;
pod2usage(-exitstatus => 2, -verbose => 1) unless $Ret;
pod2usage(-exitstatus => 2) if $OptHelp;
 
 
#------------------------------------------------------------------------------
 
 
sub set_executable {
  my $NewExecutableName = "orbital_$_[0]";
  unless (-f "/orbital/current/server/$NewExecutableName") {
    die "Executable doesn't exist:  /orbital/current/server/$NewExecutableName\n";
  }
 
  my $FILENAME = "/etc/sysconfig/orbital";
 
  unless (-r $FILENAME) {
    `touch $FILENAME`;
  }
 
  open (OLD, $FILENAME) or die "Can't open $FILENAME";
  open (NEW, ">$FILENAME$$") or die "Can't open $FILENAME$$";
 
  while (<OLD>) {
    next if (m/ORBITAL_PROGRAM=/);
    print NEW;
  }
 
  print NEW "ORBITAL_PROGRAM=$NewExecutableName\n";
 
  close OLD;
  close NEW;
 
  rename "$FILENAME$$", $FILENAME;
}
 
if ($OptSetExecutable) {
  set_executable($OptSetExecutable);
}
 
 
 
__END__
 
=pod
 
=head1 NAME
 
orbsys - Collector script for Orbital configuration tasks.
 
=head1 SYNOPSIS
 
orbsys [--?] [--man] [options]
 
=head1 OPTIONS
 
=over
 
=item --releases
 
Show Orbital releases installed.
 
=item --platform
 
Identify this platform
 
=item --brand
 
Product branding of machine
 
=item --setcurrentrelease <release>
 
Set the current release.  Resets executable to 'server'.
 
=item --currentrelease
 
Show the current release.
 
=item --setexecutable <executable>
 
Set the executable.  Valid values are server, level1, level2.
 
=back
 
=cut

