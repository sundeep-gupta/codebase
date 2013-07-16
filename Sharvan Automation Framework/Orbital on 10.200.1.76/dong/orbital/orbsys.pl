#!/usr/bin/perl
#
#
# Copyright 2002,2003 Orbital Data Corporation
#
# $Rev: 619 $
#------------------------------------------------------------
 
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
sub by_release {
  my ($MajorA, $MinorA, $PatchlevelA) = split /\./, $a;
  my ($MajorB, $MinorB, $PatchlevelB) = split /\./, $b;
 
  $MajorA <=> $MajorB
    or
  $MinorA <=> $MinorB
    or
  $PatchlevelA <=> $PatchlevelB;
}
 
sub find_releases() {
 
  open RPMS, "rpm --query orbital |";
 
  my @Releases;
 
  while (<RPMS>) {
    next if ! m/orbital-(.+)-(.+)/;
    my $Version = $1;
    my $Patchlevel = $2;
 
    push @Releases, "$Version.$Patchlevel";
  }
 
  close RPMS;
 
  @Releases = sort by_release @Releases;
 
  return @Releases;
}
 
#------------------------------------------------------------------------------
sub find_usb_devices() {
  # Search for USB devices we care about
  # Returns a list of the devices.
 
  my @Devices;
 
  my $Handle = FileHandle->new("/proc/bus/usb/devices")
    or die "Can't open '/proc/bus/usb'";
 
  while (<$Handle>) {
    if (/P:  Vendor=0cb6 ProdID=0001/) {
      push(@Devices, "arieslcd");
    }
 
    if (/P:  Vendor=0403 ProdID=fc0b/) {
      push(@Devices, "xf633");
    }
  }
 
  return @Devices;
}
 
 
 
 
#------------------------------------------------------------------------------
if ($OptBrand) {
  my $Brand;
 
  if ( my $Handle = FileHandle->new("/orbital/etc/Branding.txt")) {
    while (<$Handle>) {
      chomp;
      next if (/^#/);
      next if (/^\s*$/);
      $Brand = $_;
      last;
    }
  } else {
    my $Platform = get_platform();
 
    if ($Platform eq "aries1") {
      $Brand = 'OrbitalLC';
    } else {
      $Brand = 'Orbital5500';
    }
  }
 
  print "$Brand\n";
}
 
#------------------------------------------------------------------------------
if ($OptCurrentRelease) {
  my $CurrentRelease = readlink("/orbital/current");
  my ($Version, $Patchlevel) = $CurrentRelease =~ m/orbital-(.+)-(.+)/;
 
  print "$Version.$Patchlevel\n";
}
 
#------------------------------------------------------------------------------
if ($OptReleases) {
  my @Releases = find_releases();
 
  print join ("\n", @Releases), "\n";
}
 
 
 
#------------------------------------------------------------------------------
 
sub get_platform() {
  my @UsbDevices = find_usb_devices();
  my $Platform;
 
  if (grep /arieslcd/, @UsbDevices) {
    $Platform = "aries1";
  }
 
  if (!$Platform) {
    # Currently, dell1 is a generic release.
    $Platform = 'dell1';
  }
 
  $Platform;
}
 
if ($OptPlatform) {
  my $Platform = get_platform();
 
  print "$Platform\n";
}
 
 
#------------------------------------------------------------------------------
if ($OptSetCurrentRelease) {
  my @Releases = find_releases();
 
  unless (grep /^$OptSetCurrentRelease$/, @Releases) {
    die "Release:  $OptSetCurrentRelease not installed";
  }
 
  # Current 1.3.0-2 style
  my $DirName = $OptSetCurrentRelease;
  $DirName =~ s/^(\d+\.\d+\.\d+)\.(\d+)$/\1-\2/;
  $DirName = "orbital-" . $DirName;
 
  if (! -d "/orbital/$DirName") {
    # Legacy 1.2-1 style
    $DirName = $OptSetCurrentRelease;
    $DirName =~ s/^(\d+\.\d+)\.(\d+)$/\1-\2/;
    $DirName = "orbital-" . $DirName;
 
    if (! -d "/orbital/$DirName") {
      # Legacy 1.3-0.1 style
      $DirName = $OptSetCurrentRelease;
      $DirName =~ s/^(\d+\.\d+)\.(\d+\.\d+)$/\1-\2/;
      $DirName = "orbital-" . $DirName;
 
      if (! -d "/orbital/$DirName") {
        die "Directory for release doesn't exist\n";
      }
    }
  }
 
  # This is only half of the update required for --setcurrentrelease.  The
  # other half is in /etc/init.d/orbinit.  We only create a /orbital/newcurrent
  # symlink here.  orbinit will make the actual change at reboot.  If we
  # actually change the symlink in here then the web gui, etc, will be
  # referring to the new /orbital/current while the old core orbital processes
  # are still running.
 
  unlink "/orbital/newcurrent";
  symlink $DirName, "/orbital/newcurrent"
    or die "Can't create symlink '/orbital/newcurrent -> $DirName'";
 
  # Kernel version does not include the build number.
  my $KernelCurrentRelease = $OptSetCurrentRelease;
  $KernelCurrentRelease =~ s/^(\d+\.\d+\.\d+)\.\d+$/\1/;
 
  my $KernelVersion = "/boot/vmlinuz-2.4.20-20.9.3_orbital";  # Legacy kernel
  # Don't error out of open.  If there is an error assume legacy system.
  open KERNEL_VERSION_FILE, "/orbital/$DirName/etc/kernel_versions";
  while (<KERNEL_VERSION_FILE>) {
    if (/^$KernelCurrentRelease\s+/) {
      split;
      $KernelVersion = @_[1];
      last;
    }
  }
 
  &set_executable("server");
  system("/sbin/grubby --set-default=$KernelVersion");
}
 
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
 
 
 
#------------------------------------------------------------------------------
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

