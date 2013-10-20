=head1 NAME

Linux::Statistics - Collect linux system statistics.

=head1 SYNOPSIS

    use Linux::Statistics;

    my $obj = Linux::Statistics->new( SysInfo   => 1,
                                      ProcStats => 1,
                                      MemStats  => 1,
                                      PgSwStats => 1,
                                      NetStats  => 1,
                                      SockStats => 1,
                                      DiskStats => 1,
                                      DiskUsage => 1,
                                      LoadAVG   => 1,
                                      FileStats => 1,
                                      Processes => 1,
                                      TimeStamp => 1 );

    sleep(1);

    my $stats = $obj->getStats;

=head1 DESCRIPTION

This module collects system statistics like processor workload, memory usage and other
system informations from the F</proc> filesystem. It is tested on x86 hardware with the
distributions SuSE, SLES (s390 and s390x), Red Hat, Debian and Mandrake on kernel versions
2.4 and 2.6 but should also running on other linux distributions with the same kernel
release number. To run this module it is necessary to start it as root or another user
with the authorization to read the F</proc> filesystem and the F</etc/passwd> file.

=head1 STATISTICS

All options are identical with the functions and returns a multidimensional hash as a reference with the
collected system informations. There are two ways to collect the statistics. You can call the methods
C<new()> and C<getStats()> to collect all necessary data at the same time F<or> you call the different
functions in single steps, but note that the functions C<ProcStats()>, C<PgSwStats()>, C<NetStats()>,
C<DiskStats()> and C<Processes()> will return raw data and no deltas.

The functions C<SysInfo()>, C<MemStats()>, C<SockStats()>, C<DiskUsage()>, C<LoadAVG()> and C<FileStats()>
are no deltas. If you need only one of this informations you don't need to call C<new()> and C<getStats()>.
Note that the TimeStamp is not a function and only available if you call C<getStats()>.

If you use the method C<new()>, it checks the options and initialize all statistics that are needed to
calculate the deltas. The C<getStats()> function collects all requested informations, calculate the
deltas and actualize the initalized values. This way making it possible that the method C<new()> doesn't
must called again and again if you want to collect the statistics in a loop. The exception is that you must
call the method C<new()> if you want to add or remove a option. In the near feature I think about a function
to add options.

=head2 NOTE

If you want to get useful statistics for the options C<ProcStats>, C<NetStats>, C<DiskStats>, C<PgSwStats>
and C<Processes> then it's necessary to sleep for a while - at least one second - between the calls
of C<new()> and C<getStats()>. If you shouldn't do that it's possible that this statistics will be null.
The reason is that this statistics - remember - are deltas since the last time that the new method was
called and the call of C<getStats()>. If you use a sleep interval for one or more seconds and some statistics
be null then your system seems to have a low workload.

Have a lot of fun with this module :-)

=head1 OPTIONS, FUNCTIONS

=head2 SysInfo, C<SysInfo()>

Generated from F</proc/sys/kernel/{hostname,domainname,ostype,osrelease,version}>
and F</proc/cpuinfo>, F</proc/meminfo>, F</proc/uptime>.

   Hostname        -  This is the host name.
   Domain          -  This is the host domain name.
   Kernel          -  This is the kernel name.
   Release         -  This is the release number.
   Version         -  This is the version number.
   MemTotal        -  The total size of memory.
   SwapTotal       -  The total size of swap space.
   CountCPUs       -  The total (maybe logical) number of CPUs.
   Uptime          -  This is the uptime of the system.
   IdleTime        -  This is the idle time of the system.

=head2 ProcStats, C<ProcStats()>

Generated from F</proc/stat>.

   User            -  Percentage of CPU utilization at the user level.
   Nice            -  Percentage of CPU utilization at the user level with nice priority.
   System          -  Percentage of CPU utilization at the system level.
   Idle            -  Percentage of time the CPU is in idle state.
   IOWait          -  Percentage of time the CPU is in idle state because an i/o operation is waiting for a disk.
   Total           -  Total percentage of CPU utilization at user and system level.
   New             -  Number of new processes that were produced per second.

=head2 MemStats, C<MemStats()>

Generated from I</proc/meminfo>.

   MemUsed         -  Total size of used memory in kilobytes.
   MemFree         -  Total size of free memory in kilobytes.
   MemUsedPer      -  Total size of used memory in percent.
   MemTotal        -  Total size of memory in kilobytes.
   Buffers         -  Total size of buffers used from memory in kilobytes.
   Cached          -  Total size of cached memory in kilobytes.
   SwapUsed        -  Total size of swap space is used is kilobytes.
   SwapFree        -  Total size of swap space is free in kilobytes.
   SwapUsedPer     -  Total size of swap space is used in percent.
   SwapTotal       -  Total size of swap space in kilobytes.

=head2 PgSwStats, C<PgSwStats()>

Generated from F</proc/stat> or F</proc/vmstat>.

   PageIn          -  Number of kilobytes the system has paged in from disk.
   PageOut         -  Number of kilobytes the system has paged out to disk.
   SwapIn          -  Number of kilobytes the system has swapped in from disk.
   SwapOut         -  Number of kilobytes the system has swapped out to disk.

=head2 NetStats, C<NetStats()>

Generated from F</proc/net/dev>.

   RxBytes         -  Number of bytes received.
   RxPackets       -  Number of packets received.
   RxErrs          -  Number of errors that happend while received packets.
   RxDrop          -  Number of packets that were dropped.
   RxFifo          -  Number of FIFO overruns that happend on received packets.
   RxFrame         -  Number of carrier errors that happend on received packets.
   RxCompr         -  Number of compressed packets received.
   RxMulti         -  Number of multicast packets received.
   TxBytes         -  Number of bytes transmitted.
   TxPackets       -  Number of packets transmitted.
   TxErrs          -  Number of errors that happend while transmitting packets.
   TxDrop          -  Number of packets that were dropped.
   TxFifo          -  Number of FIFO overruns that happend on transmitted packets.
   TxColls         -  Number of collisions that were detected.
   TxCarr          -  Number of carrier errors that happend on transmitted packets.
   TxCompr         -  Number of compressed packets transmitted.

=head2 NetStatsSum

   This are just some summaries of NetStats/C<NetStats()>.

   RxBytes         -  Total number of bytes received.
   TxBytes         -  Total number of bytes transmitted.

=head2 SockStats, C<SockStats()>

Generated from F</proc/net/sockstat>.

   Used            -  Total number of used sockets.
   Tcp             -  Number of tcp sockets in use.
   Udp             -  Number of udp sockets in use.
   Raw             -  Number of raw sockets in use.
   IpFrag          -  Number of ip fragments in use.

=head2 DiskStats, C<DiskStats()>

Generated from F</proc/diskstats> or F</proc/partitions>.

   Major           -  The mayor number of the disk
   Minor           -  The minor number of the disk
   ReadRequests    -  Number of read requests that were made to physical disk.
   ReadBytes       -  Number of bytes that were read from physical disk.
   WriteRequests   -  Number of write requests that were made to physical disk.
   WriteBytes      -  Number of bytes that were written to physical disk.
   TotalRequests   -  Total number of requests were made from/to physical disk.
   TotalBytes      -  Total number of bytes transmitted from/to physical disk.

=head2 DiskStatsSum

   This are just some summaries of DiskStats/C<DiskStats()>.

   ReadRequests    -  Total number of read requests were made to all physical disks.
   ReadBytes       -  Total number of bytes reads from all physical disks.
   WriteRequests   -  Total number of write requests were made to all physical disks.
   WriteBytes      -  Total number of bytes written to all physical disks.
   Requests        -  Total number of requests were made from/to all physical disks.
   Bytes           -  Total number of bytes transmitted from/to all physical disks.

=head2 DiskUsage, C<DiskUsage()>

Generated with F</bin/df -k>.

   Total           -  The total size of the disk.
   Usage           -  The used disk space in kilobytes.
   Free            -  The free disk space in kilobytes.
   UsagePer        -  The used disk space in percent.
   MountPoint      -  The moint point of the disk.

=head2 LoadAVG, C<LoadAVG()>

Generated with F</proc/loadavg>.

   AVG_1           -  The average processor workload of the last minute.
   AVG_5           -  The average processor workload of the last five minutes.
   AVG_15          -  The average processor workload of the last fifteen minutes.
   RunQueue        -  The number of processes waiting for runtime.
   Count           -  The total amount of processes on the system.

=head2 FileStats, C<FileStats()>

Generated with F</proc/sys/fs/file-nr>, F</proc/sys/fs/inode-nr> and F</proc/sys/fs/dentry-state>.

   fhAlloc         -  Number of allocated file handles.
   fhFree          -  Number of free file handles.
   fhMax           -  Number of maximum file handles.
   inAlloc         -  Number of allocated inodes.
   inFree          -  Number of free inodes.
   inMax           -  Number of maximum inodes.
   Dentries        -  Dirty directory cache entries.
   Unused          -  Free diretory cache size.
   AgeLimit        -  Time in seconds the dirty cache entries can be reclaimed.
   WantPages       -  Pages that are requested by the system when memory is short.

=head2 Processes, C<Processes()>

Generated with F</proc/E<lt>numberE<gt>/statm>, F</proc/E<lt>numberE<gt>/stat>,
F</proc/E<lt>numberE<gt>/status>, F</proc/E<lt>numberE<gt>/cmdline> and F</etc/passwd>.

   PPid            -  The parent process ID of the process.
   Owner           -  The owner name of the process.
   State           -  The status of the process.
   PGrp            -  The group ID of the process.
   Session         -  The session ID of the process.
   TTYnr           -  The tty the process use.
   MinFLT          -  The number of minor faults the process made.
   CMinFLT         -  The number of minor faults the child process made.
   MayFLT          -  The number of mayor faults the process made.
   CMayFLT         -  The number of mayor faults the child process made.
   CUTime          -  The number of jiffies the process waited for childrens have been scheduled in user mode.
   STime           -  The number of jiffies the process have beed scheduled in kernel mode.
   UTime           -  The number of jiffies the process have beed scheduled in user mode.
   CSTime          -  The number of jiffies the process waited for childrens have been scheduled in kernel mode.
   Prior           -  The priority of the process (+15).
   Nice            -  The nice level of the process.
   StartTime       -  The time in jiffies the process started after system boot.
   ActiveTime      -  The time in D:H:M (days, hours, minutes) the process is active.
   VSize           -  The size of virtual memory of the process.
   NSwap           -  The size of swap space of the process.
   CNSwap          -  The size of swap space of the childrens of the process.
   CPU             -  The CPU number the process was last executed on.
   Size            -  The total program size of the process.
   Resident        -  Number of resident set size, this includes the text, data and stack space.
   Share           -  Total size of shared pages of the process.
   TRS             -  Total text size of the process.
   DRS             -  Total data/stack size of the process.
   LRS             -  Total library size of the process.
   DT              -  Total size of dirty pages of the process (unused since kernel 2.6).
   Comm            -  Command of the process.
   CMDLINE         -  Command line of the process.
   Pid             -  The process ID.

=head2 TimeStamp (the time stamp is only available if you call the function C<getStats()>)

Generated with C<localtime(time)>.

   Date            -  The current date.
   Time            -  The current time.

=head1 EXAMPLES

You can find very a simple script for tests under F<Linux-Statistics-1.14/Examples/>.
The script calls F<SimpleCheck> and shows you the collected data with C<Data::Dumper>.
The following example scripts lie under F<Linux-Statistics-1.14/Examples/> as well.

A very simple perl script could looks like this:

         use warnings;
         use strict;
         use Linux::Statistics;

         my $obj = Linux::Statistics->new( ProcStats => 1 );
         sleep(1);
         my $stats = $obj->getStats;

         print "Statistics for ProcStats\n";
         print "  User      $stats->{ProcStats}->{User}\n";
         print "  Nice      $stats->{ProcStats}->{Nice}\n";
         print "  System    $stats->{ProcStats}->{System}\n";
         print "  Idle      $stats->{ProcStats}->{Idle}\n";
         print "  IOWait    $stats->{ProcStats}->{IOWait}\n";
         print "  Total     $stats->{ProcStats}->{Total}\n";
         print "  New       $stats->{ProcStats}->{New}\n";

Example to collect network statistics with a nice output:

         use warnings;
         use strict;
         use Linux::Statistics;

         my $obj = Linux::Statistics->new( NetStats => 1 );
         sleep(1);
         my $stats = $obj->getStats;

         my @list = qw( RxBytes  RxPackets  RxErrs   RxDrop
                        RxFifo   RxFrame    RxCompr  RxMulti
                        TxBytes  TxPackets  TxErrs   TxDrop
                        TxFifo   TxColls    TxCarr   TxCompr );

         print ' ' x 6;
         printf '%12s', $_ for @list;
         print "\n";

         foreach my $device (keys %{$stats->{NetStats}}) {
            printf '%-6s', $device;
            printf '%12s', $stats->{NetStats}->{$device}->{$_} for @list;
            print "\n";
         }

         print "\nTotal network statistics:\n";

         while (my ($key,$value) = each %{$stats->{NetStatsSum}}) {
            printf '  %-12s', $key;
            printf '%12s', "$value\n";
         }

Example to show a process list:

         use warnings;
         use strict;
         use Linux::Statistics;

         my $obj = Linux::Statistics->new( Processes => 1 );
         sleep(1);
         my $stats = $obj->getStats;

         printf '%-12s', $_ for qw(Pid PPid Owner State Size VSize CMDLINE);
         print "\n";

         foreach my $pid (keys %{$stats->{Processes}}) {
            printf '%-12s', $stats->{Processes}->{$pid}->{$_} for qw(Pid PPid Owner State Size VSize CMDLINE);
            print "\n";
         }

You can collect the statistics in a loop as well:

         use warnings;
         use strict;
         use Linux::Statistics;

         $| = 1;

         my $obj = Linux::Statistics->new( ProcStats => 1, TimeStamp => 1 );

         print "Report/Statistic for ProcStats\n";
         printf '%8s', $_ for qw(Time User System Total Nice IOWait Idle New);
         print "\n";

         while (1) {
            sleep(1);
            my $stats = $obj->getStats;

            print "$stats->{TimeStamp}->{Time}";
            printf '%8s', $stats->{ProcStats}->{$_} for qw(User System Total Nice IOWait Idle New);
            print "\n";
         }

It is possible to create a hash reference with options as well:

         my $options = {
            SysInfo   => 1,
            ProcStats => 1,
            MemStats  => 1,
            PgSwStats => 1,
            NetStats  => 1,
            SockStats => 1,
            DiskStats => 1,
            DiskUsage => 1,
            LoadAVG   => 1,
            FileStats => 1,
            Processes => 1,
            TimeStamp => 1,
         };

         my $obj = Linux::Statistics->new( $options );
         sleep(1);
         my $stats = $obj->getStats;

If you're not sure you can use the the C<Data::Dumper> module to learn more about the hash structure:

         use warnings;
         use strict;
         use Linux::Statistics;
         use Data::Dumper;

         my $obj = Linux::Statistics->new( ProcStats => 1 );
         sleep(1);
         my $stats = $obj->getStats;

         print Dumper($stats);

One simple example for the call without C<new()> and C<getStats()>:

         use strict;
         use warnings;
         use Linux::Statistics;
         use Data::Dumper;

         my $stats = {};

         # remember... ProcStats(), PgSwStats(), NetStats(),
         # DiskStats() and Processes() are raw data and no deltas!

         for my $opt (qw(SysInfo ProcStats MemStats PgSwStats SockStats DiskUsage LoadAVG FileStats Processes)) {
            $stats->{$opt} = Linux::Statistics->$opt;
         }

         # NetStats() and DiskStats() returns two hash references.

         for my $opt (qw(NetStats DiskStats)) {
            ($stats->{$opt},$stats->{"${opt}Sum"}) = Linux::Statistics->$opt;
         }

         # have a look on the structure

         print Dumper($stats);

=head1 EXPORTS

No exports.

=head1 SEE ALSO

B<proc(5)>

F</usr/src/linux/Documentation/filesystems/proc.txt>

=head1 REPORTING BUGS

Please report all bugs to <jschulz@bloonix.de>.

=head1 EXPANSIONS

If there are statistics you need but not generated by this module please send me an email
with your wishs or a function ready to built in :-).

Maybe this module do not runs on your architecture fine because there are a lot of differences
between the /proc filesystems of your arch and a simple x86 system. In this case it would be
fine if you contact me and we looks for a solution.

=head1 AUTHOR

Jonny Schulz <jschulz@bloonix.de>.

=head1 COPYRIGHT

Copyright (c) 2005, 2006 by Jonny Schulz. All rights reserved.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

package Linux::Statistics;

use strict;
use warnings;
our $VERSION = '1.16';

# Disk statictics are since 2.4 kernel found in /proc/partitions, but since
# kernel 2.6 this statistics are now in /proc/diskstats. Further the paging
# and swapping statistics are no more in /proc/stat but also in /proc/vmstat.
# Here are now all neccessary files for this module.

my %file = (
   passwd     => '/etc/passwd',
   procdir    => '/proc',
   stats      => '/proc/stat',
   meminfo    => '/proc/meminfo',
   sysinfo    => '/proc/sysinfo',
   cpuinfo    => '/proc/cpuinfo',
   vmstat     => '/proc/vmstat',
   loadavg    => '/proc/loadavg',
   sockstats  => '/proc/net/sockstat',
   netstats   => '/proc/net/dev',
   diskstats  => '/proc/diskstats',
   partitions => '/proc/partitions',
   uptime     => '/proc/uptime',
   Hostname   => '/proc/sys/kernel/hostname',
   Domain     => '/proc/sys/kernel/domainname',
   Kernel     => '/proc/sys/kernel/ostype',
   Release    => '/proc/sys/kernel/osrelease',
   Version    => '/proc/sys/kernel/version',
   file_nr    => '/proc/sys/fs/file-nr',
   inode_nr   => '/proc/sys/fs/inode-nr',
   dentries   => '/proc/sys/fs/dentry-state'
);

# The sectors are equivalent with blocks and have a size of 512 bytes since 2.4
# kernels. This value is needed to calculate the amount of disk i/o's in bytes.

my $block_size = 512;

sub new {
   my $class = shift;
   my %self;

   if (ref $_[0] eq 'HASH') {
      $self{options} = $_[0];
   } elsif (@_ & 1) {
      die 'Statistics: not enough arguments ...';
   } else {
      $self{options} = {@_};
   }

   # we initialize necessary values
   foreach my $opt (keys %{$self{options}}) {
      no strict 'refs';
      if ($opt =~ /^(ProcStats|PgSwStats)$/) {
         $self{istat}{$opt} = &$opt();
      } elsif ($opt =~ /^Processes$/) {
         open FU,'<',$file{uptime} or die "Statistics: can't open $file{uptime}";
         $self{istat}{uptime} = (split /\s+/, <FU>)[0];
         close FU;
         $self{istat}{$opt} = initProcesses();
      } elsif ($opt =~ /^(NetStats|DiskStats)$/) {
         ($self{istat}{$opt},$self{istat}{"${opt}Sum"}) = &$opt();
      } elsif ($opt !~ /^(SysInfo|MemStats|SockStats|DiskUsage|LoadAVG|FileStats|TimeStamp)$/) {
         die "Statistics: invalid argument $opt";
      }
   }
   
   return bless \%self, $class;
}

# This function collects all statistic informations and returns the data as a hash reference.

sub getStats {
   my $self    = shift;
   my $options = $self->{options};
   my $istat   = $self->{istat};
   my $rstat   = {};

   # set a time stamp for the statistics
   if ($options->{TimeStamp}) {
      my @tm = (localtime)[reverse 0..5];

      $tm[0] += 1900;
      $tm[1]++;

      $rstat->{TimeStamp}->{Time} = sprintf '%02d:%02d:%02d', @tm[3..5];
      $rstat->{TimeStamp}->{Date} = sprintf '%04d-%02d-%02d', @tm[0..2];
   }

   if ($options->{Processes}) {
      open my $fu, '<', $file{uptime} or die "Statistics: can't open $file{uptime}";
      my $uptime = (split /\s+/, <$fu>)[0];
      close $fu;
      $istat->{uptime} = $uptime - $istat->{uptime};
      $rstat->{Processes} = Processes();
      my $r_stat = $rstat->{Processes};
      my $i_stat = $istat->{Processes};

      for my $pid (keys %{$r_stat}) {
         # if the process doesn't exist it seems to be a new process
         if ($i_stat->{$pid}->{StartTime} && $r_stat->{$pid}->{StartTime} == $i_stat->{$pid}->{StartTime}) {
            for my $key (qw(MinFLT CMinFLT MayFLT CMayFLT UTime STime CUTime CSTime)) {
               # we held this value for the next init stat
               my $tmp                  = $r_stat->{$pid}->{$key};
               $r_stat->{$pid}->{$key} -= $i_stat->{$pid}->{$key};
               $r_stat->{$pid}->{$key}  = sprintf('%.2f', $r_stat->{$pid}->{$key} / $istat->{uptime}) if $r_stat->{$pid}->{$key} > 0;
               $i_stat->{$pid}->{$key}  = $tmp;
            }
         } else {
            # we initialize the new process
            for my $key (qw(MinFLT CMinFLT MayFLT CMayFLT UTime STime CUTime CSTime StartTime)) {
               $i_stat->{$pid}->{$key} = $r_stat->{$pid}->{$key};
               delete $r_stat->{$pid};
            }
         }
      }

      # our new uptime
      $i_stat->{uptime} = $uptime;
   }

   for my $opt (qw(SysInfo MemStats SockStats DiskUsage LoadAVG FileStats)) {
      no strict 'refs';
      $rstat->{$opt} = &$opt() if $options->{$opt};
   }

   for my $opt (qw(ProcStats PgSwStats)) {
      if ($options->{$opt}) {
         { no strict 'refs'; $rstat->{$opt} = &$opt(); }

         while (my ($x,$y) = each %{$rstat->{$opt}}) {
            $rstat->{$opt}->{$x} -= $istat->{$opt}->{$x};
            $istat->{$opt}->{$x}  = $y;
         }
         if ($opt eq 'ProcStats') {
            foreach (qw(User Nice System Idle IOWait)) {
               $rstat->{ProcStats}->{$_} = sprintf('%.2f',100 * $rstat->{ProcStats}->{$_} / $rstat->{ProcStats}->{Uptime})
                  if $rstat->{ProcStats}->{$_};
            }

            $rstat->{ProcStats}->{Total} = $rstat->{ProcStats}->{User} + $rstat->{ProcStats}->{Nice} + $rstat->{ProcStats}->{System};
            delete $rstat->{ProcStats}->{Uptime};
         }
      }
   }

   for my $opt (qw(NetStats DiskStats)) {
      if ($options->{$opt}) {
         { no strict 'refs'; ($rstat->{$opt},$rstat->{"${opt}Sum"}) = &$opt() if $options->{$opt}; }

         foreach my $x (keys %{$rstat->{$opt}}) {
            while (my ($y,$z) = each %{$rstat->{$opt}->{$x}}) {
               $rstat->{$opt}->{$x}->{$y} -= $istat->{$opt}->{$x}->{$y};
               $istat->{$opt}->{$x}->{$y}  = $z;
            }
         }
         while (my ($x,$y) = each %{$rstat->{"${opt}Sum"}}) {
            $rstat->{"${opt}Sum"}->{$x} -= $istat->{"${opt}Sum"}->{$x};
            $istat->{"${opt}Sum"}->{$x}  = $y;
         }
      }
   }

   return $rstat if %{$rstat};
   return;
}

sub SysInfo {
   my %sys;

   for (qw(Hostname Domain Kernel Release Version)) {
      open my $fht, '<', $file{$_} or die "Statistics: can't open $file{$_}";
      $sys{$_} = <$fht>;
      close $fht;
   }

   open my $fhm, '<', $file{meminfo} or die "Statistics: can't open $file{meminfo}";
   while (defined (my $line = <$fhm>)) {
      if ($line =~ /^MemTotal:\s+(\d+ \w+)/) {
         $sys{MemTotal} = $1;
      } elsif ($line =~ /^SwapTotal:\s+(\d+ \w+)/) {
         $sys{SwapTotal} = $1;
      }
   }
   close $fhm;

   $sys{CountCPUs} = 0;
   open my $fhc, '<', $file{cpuinfo} or die  die "Statistics: can't open $file{cpuinfo}";
   while (defined (my $line = <$fhc>)) {
      if ($line =~ /^processor\s*:\s*\d+/) {            # x86
         $sys{CountCPUs}++;
      } elsif ($line =~ /^# processors\s*:\s*(\d+)/) {  # s390
         $sys{CountCPUs} = $1;
         last;
      }
   }
   close $fhc;

   open my $fhu, '<', $file{uptime} or die "Statistics: can't open $file{uptime}";

   foreach (split /\s+/, <$fhu>) {
      my $s = sprintf('%li',$_);
      my $d = 0;
      my $h = 0;
      my $m = 0;

      $s >= 86400 and $d = sprintf('%i',$s / 86400) and $s = $s % 86400;
      $s >= 3600  and $h = sprintf('%i',$s / 3600)  and $s = $s % 3600;
      $s >= 60    and $m = sprintf('%i',$s / 60)    and $s = $s % 60;

      unless (defined $sys{Uptime}) {
         $sys{Uptime} = "${d}d ${h}h ${m}m ${s}s";
         next;
      }

      $sys{IdleTime} = "${d}d ${h}h ${m}m ${s}s";
   }

   close $fhu;

   foreach my $key (keys %sys) {
      chomp $sys{$key};
      $sys{$key} =~ s/\t/ /g;
      $sys{$key} =~ s/\s+/ /g;
   }

   return \%sys;
}

sub ProcStats {
   my %stat;

   open my $fhp, '<', $file{stats} or die "Statistics: can't open $file{stats}";

   while (defined (my $line = <$fhp>)) {
      if ($line =~ /^cpu\s+(.*)$/) {
         @stat{qw(User Nice System Idle IOWait)} = split /\s+/, $1;
         # IOWait is only set as fifth parameter
         # by kernel versions higher than 2.4
         $stat{IOWait} = 0 unless defined $stat{IOWait};
         $stat{Uptime} = $stat{User} + $stat{Nice} + $stat{System} + $stat{Idle} + $stat{IOWait};
      } elsif ($line =~ /^processes (.*)/) {
         $stat{New} = $1;
      }
   }

   close $fhp;

   return \%stat;
}

sub MemStats {
   my %mem;

   open my $fhm, '<', $file{meminfo} or die "Statistics: can't open $file{meminfo}";
   while (defined (my $line = <$fhm>)) {
      $mem{$1} = $2 if $line =~ /^(MemTotal|MemFree|Buffers|Cached|SwapTotal|SwapFree):\s*(\d+)/;
   }
   close $fhm;

   $mem{MemUsed}     = sprintf('%u',$mem{MemTotal} - $mem{MemFree});
   $mem{MemUsedPer}  = sprintf('%.2f',100 * $mem{MemUsed} / $mem{MemTotal});
   $mem{SwapUsed}    = sprintf('%u',$mem{SwapTotal} - $mem{SwapFree});
   $mem{SwapUsedPer} = sprintf('%.2f',100 * $mem{SwapUsed} / $mem{SwapTotal});

   return \%mem;
}

sub PgSwStats {
   my %stat;

   open my $fhs, '<', $file{stats} or die "Statistics: can't open $file{stats}\n";

   while (defined (my $line = <$fhs>)) {
      if ($line =~ /^page (\d+) (\d+)$/) {
         @stat{qw(PageIn PageOut)} = ($1, $2);
      } elsif ($line =~ /^swap (\d+) (\d+)$/) {
         @stat{qw(SwapIn SwapOut)} = ($1, $2);
      }
   }

   close $fhs;

   # if paging and swapping are not found in /proc/stat
   # then let's try a look into /proc/vmstat (since 2.6)

   unless (defined $stat{SwapOut}) {
      open my $fhv, '<', $file{vmstat} or die "Statistics: can't open $file{vmstat}";

      while (defined (my $line = <$fhv>)) {
         if ($line =~ /^pgpgin (\d+)$/) {
            $stat{PageIn} = $1;
         } elsif ($line =~ /^pgpgout (\d+)$/) {
            $stat{PageOut} = $1;
         } elsif ($line =~ /^pswpin (\d+)$/) {
            $stat{SwapIn} = $1;
         } elsif ($line =~ /^pswpout (\d+)$/) {
            $stat{SwapOut} = $1;
         }
      }

      close $fhv;
   }

   return \%stat;
}

sub NetStats {
   my (%net,%sum);

   open my $fhn, '<', $file{netstats} or die "Statistics: can't open $file{netstats}";

   while (defined (my $line = <$fhn>)) {
      if ($line =~ /^\s*(\w+):\s*(.*)/) {
         @{$net{$1}}{qw(
            RxBytes  RxPackets  RxErrs   RxDrop     RxFifo  RxFrame
            RxCompr  RxMulti    TxBytes  TxPackets  TxErrs  TxDrop
            TxFifo   TxColls    TxCarr   TxCompr
         )} = split /\s+/, $2;

         $sum{RxBytes} += $net{$1}{RxBytes};
         $sum{TxBytes} += $net{$1}{TxBytes};
      }
   }

   close $fhn;
   return (\%net,\%sum);
}

sub SockStats {
   my %sock;

   open my $fhs, '<', $file{sockstats} or die "Statistics: can't open $file{sockstats}";

   while (defined (my $line = <$fhs>)) {
      if ($line =~ /sockets: used (\d+)/) {
         $sock{Used} = $1;
      } elsif ($line =~ /TCP: inuse (\d+)/) {
         $sock{Tcp} = $1;
      } elsif ($line =~ /UDP: inuse (\d+)/) {
         $sock{Udp} = $1;
      } elsif ($line =~ /RAW: inuse (\d+)/) {
         $sock{Raw} = $1;
      } elsif ($line =~ /FRAG: inuse (\d+)/) {
         $sock{IpFrag} = $1;
      }
   }

   close $fhs;
   return \%sock;
}

sub DiskStats {
   my (%disk,%sum);

   # one of the both must be opened for the disk statistics!
   # if diskstats (2.6) are not found then let's try to read
   # the partitions (2.4)

   if (open my $fhd, '<', $file{diskstats}) {
      while (defined (my $line = <$fhd>)) {
         if ($line =~ /^\s+(\d+)\s+(\d+)\s+(\w+)\s+(\d+)\s+\d+\s+(\d+)\s+\d+\s+(\d+)\s+(\d+)\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+$/ && $4 && $6) {
            for my $x ($disk{$3}) {
               $x->{Major}          = $1;
               $x->{Minor}          = $2;
               $x->{ReadRequests}   = $4;
               $x->{ReadBytes}      = $5 * $block_size;
               $x->{WriteRequests}  = $6;
               $x->{WriteBytes}     = $7 * $block_size;
               $x->{TotalRequests} += $x->{ReadRequests} + $x->{WriteRequests};
               $x->{TotalBytes}    += $x->{ReadBytes} + $x->{WriteBytes};
            }
         } elsif ($line =~ /^\s+(\d+)\s+(\d+)\s+(\w+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)$/) {
            for my $x ($disk{$3}) {
               $x->{Major}          = $1;
               $x->{Minor}          = $2;
               $x->{ReadRequests}   = $4;
               $x->{ReadBytes}      = $5 * $block_size;
               $x->{WriteRequests}  = $6;
               $x->{WriteBytes}     = $7 * $block_size;
               $x->{TotalRequests} += $x->{ReadRequests} + $x->{WriteRequests};
               $x->{TotalBytes}    += $x->{ReadBytes} + $x->{WriteBytes};
            }
         } else {
            next;
         }

         for my $x ($disk{$3}) {
            $sum{ReadRequests}  += $x->{ReadRequests};
            $sum{ReadBytes}     += $x->{ReadBytes};
            $sum{WriteRequests} += $x->{WriteRequests};
            $sum{WriteBytes}    += $x->{WriteBytes};
            $sum{Requests}      += $x->{TotalRequests};
            $sum{Bytes}         += $x->{TotalBytes};
         }
      }
      close $fhd;
   } elsif (open my $fhp, '<', $file{partitions}) {
      while (defined (my $line = <$fhp>)) {
         tr/A-Z/a-z/;
         next unless $line =~ /^\s+(\d+)\s+(\d+)\s+\d+\s+(\w+)\s+(\d+)\s+\d+\s+(\d+)\s+\d+\s+(\d+)\s+(\d+)\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+$/ && $4 && $6;
         for my $x ($disk{$3}) {
            $x->{Major}          = $1;
            $x->{Minor}          = $2;
            $x->{ReadRequests}   = $4;
            $x->{ReadBytes}      = $5 * $block_size;
            $x->{WriteRequests}  = $6;
            $x->{WriteBytes}     = $7 * $block_size;
            $x->{TotalRequests} += $x->{ReadRequests} + $x->{WriteRequests};
            $x->{TotalBytes}    += $x->{ReadBytes} + $x->{WriteBytes};
            $sum{ReadRequests}  += $x->{ReadRequests};
            $sum{ReadBytes}     += $x->{ReadBytes};
            $sum{WriteRequests} += $x->{WriteRequests};
            $sum{WriteBytes}    += $x->{WriteBytes};
            $sum{Requests}      += $x->{TotalRequests};
            $sum{Bytes}         += $x->{TotalBytes};
         }
      }
      close $fhp;
   } else {
      die "Statistics: can't open $file{diskstats} or $file{partitions}";
   }

   return (\%disk,\%sum);
}

sub DiskUsage {
   my (%disk_usage,$disk_name);

   open my $fhp, "/bin/df -k |" or die "Statistics: can't execute /bin/df -k";

   # filter the header
   {my $null = <$fhp>;}

   while (defined (my $line = <$fhp>)) {
      $line =~ s/%//g;

      if ($line =~ /^(.+?)\s+(.+)$/ && !$disk_name) {
         @{$disk_usage{$1}}{qw(Total Usage Free UsagePer MountPoint)} = (split /\s+/, $2)[0..4];
      } elsif ($line =~ /^(.+?)\s*$/ && !$disk_name) {
         # it can be that the disk name is to long and the rest
         # of the disk informations are in the next line ...
         $disk_name = $1;
      } elsif ($line =~ /^\s+(.*)$/ && $disk_name) {
         # this line should contain the rest informations for the
         # disk name that we stored in the last loop
         @{$disk_usage{$disk_name}}{qw(Total Usage Free UsagePer MountPoint)} = (split /\s+/, $1)[0..4];
         undef $disk_name;
      } else {
         # okay, it should never be the issue that we get a
         # line that we couldn't split, but for sure we undef
         # the disk_name if it's set
         undef $disk_name if $disk_name;
      }
   }

   close $fhp;
   return \%disk_usage;
}

sub LoadAVG {
   my (%lavg,$proc);

   open my $fha, '<', $file{loadavg} or die "Statistics: can't open $file{loadavg}";

   ( $lavg{AVG_1}
   , $lavg{AVG_5}
   , $lavg{AVG_15}
   , $proc
   ) = (split /\s+/, <$fha>)[0..3];

   close $fha;

   ( $lavg{RunQueue}
   , $lavg{Count}
   ) = split /\//, $proc;

   return \%lavg;
}

sub FileStats {
   my %fstat;

   open my $fhf, '<', $file{file_nr} or die "Statistics can't open $file{file_nr}";
   @fstat{qw(fhAlloc fhFree fhMax)} = (split /\s+/, <$fhf>)[0..2];
   close $fhf;

   open my $fhi, '<', $file{inode_nr} or die "Statistics can't open $file{inode_nr}";
   @fstat{qw(inAlloc inFree)} = (split /\s+/, <$fhi>)[0..1];
   $fstat{inMax} = $fstat{inAlloc} + $fstat{inFree};
   close $fhi;

   open my $fhd, '<', $file{dentries} or die "Statistics can't open $file{dentries}";
   @fstat{qw(Dentries Unused AgeLimit WantPages)} = (split /\s+/, <$fhd>)[0..3];
   close $fhd;

   return \%fstat;
}

sub initProcesses {
   my %sps;

   opendir my $pdir, $file{procdir}  or die "Statistics: can't open directory $file{procdir}";
   my @prc = grep /^\d+$/, readdir $pdir; 
   closedir $pdir;

   foreach my $pid (@prc) {
      if (open my $fhp, '<', "$file{procdir}/$pid/stat") {
         @{$sps{$pid}}{qw(MinFLT CMinFLT MayFLT CMayFLT UTime STime CUTime CSTime StartTime)} = (split /\s+/, <$fhp>)[9..16,21];
         close $fhp; 
      } else {
         delete $sps{$pid};
         next;
      }
   }

   return \%sps;
}

sub Processes {
   my (%sps,%userids);

   opendir my $pdir, $file{procdir} or die "Statistics: can't open directory $file{procdir}";

   # we get all the PIDs from the /proc filesystem. if we can't open a file
   # of a process, then it can be that the process doesn't exist any more and
   # we will delete the hash key.
   my @prc = grep /^\d+$/, readdir $pdir;

   closedir $pdir;

   # we trying to get the UIDs for each linux user
   open my $fhp, '<', $file{passwd} or die die "Statistics: can't open $file{passwd}";

   while (defined (my $line = <$fhp>)) {
      next if $line =~ /^(#|$)/;
      my ($user,$uid) = (split /:/,$line)[0,2];
      $userids{$uid} = $user;
   }

   close $fhp;

   open my $fhu, '<', $file{uptime} or die "Statistics: can't open $file{uptime}";
   my $uptime = (split /\s+/, <$fhu>)[0];
   close $fhu;

   foreach my $pid (@prc) {

      #  memory usage for each process
      if (open my $fhm, '<', "$file{procdir}/$pid/statm") {
         @{$sps{$pid}}{qw(Size Resident Share TRS DRS LRS DT)} = split /\s+/, <$fhm>;
         close $fhm;
      } else {
         delete $sps{$pid};
         next;
      }

      #  different other informations for each process
      if (open my $fhp, '<', "$file{procdir}/$pid/stat") {
         @{$sps{$pid}}{qw(
            Pid Comm State PPid PGrp Session TTYnr MinFLT
            CMinFLT MayFLT CMayFLT UTime STime CUTime CSTime
            Prior Nice StartTime VSize NSwap CNSwap CPU
         )} = (split /\s+/, <$fhp>)[0..6,9..18,21..22,35..36,38];
         close $fhp;
      } else {
         delete $sps{$pid};
         next;
      }

      # calculate the active time of each process
      my $s = sprintf('%li',$uptime - $sps{$pid}{StartTime} / 100);
      my $m = 0;
      my $h = 0;
      my $d = 0;

      $s >= 86400 and $d = sprintf('%i',$s / 86400) and $s = $s % 86400;
      $s >= 3600  and $h = sprintf('%i',$s / 3600)  and $s = $s % 3600;
      $s >= 60    and $m = sprintf('%i',$s / 60);

      $sps{$pid}{ActiveTime} = sprintf '%02d:%02d:%02d', $d, $h, $m;

      # determine the owner of the process
      if (open my $fhu, '<', "$file{procdir}/$pid/status") {
         while (defined (my $line = <$fhu>)) {
            $line =~ s/\t/ /;
            next unless $line =~ /^Uid:\s+(\d+)/;
            $sps{$pid}{Owner} = $userids{$1} if $userids{$1};
         }

         $sps{$pid}{Owner} = 'n/a' unless $sps{$pid}{Owner};
         close $fhu;
      } else {
         delete $sps{$pid};
         next;
      }

      #  command line for each process
      if (open my $fhc, '<', "$file{procdir}/$pid/cmdline") {
         $sps{$pid}{CMDLINE} =  <$fhc>;
         $sps{$pid}{CMDLINE} =~ s/\0/ /g if $sps{$pid}{CMDLINE};
         $sps{$pid}{CMDLINE} =  'n/a' unless $sps{$pid}{CMDLINE};
         chomp $sps{$pid}{CMDLINE};
         close $fhc;
      }
   }

   return \%sps;
}



1;

