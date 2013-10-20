#!/tools/bin/perl
#use warnings ;

# load an array with test files
#my @tests = qw ( test1.pl test2.pl test3.pl test4.pl test5.pl);
#my @tests = qw ( test_base.pl);
my @tests = qw (bm_0_lzs_0_srf104M.txt_compress_50ms_50ms_1.5_1.5.sh.pl );

my @tests1 = qw(
		bm_0_lzs_0_srf104M.txt_compress_50ms_50ms_1.5_1.5.sh.pl
		bm_0_lzs_0_srf104M.txt_compress_5ms_5ms_1.5_1.5.sh.pl
		bm_0_lzs_0_srf719M.txt_compress_50ms_50ms_10_10.sh.pl
		bm_0_lzs_0_srf719M.txt_compress_5ms_5ms_10_10.sh.pl
		bm_0_lzs_6_srf104M.txt_compress_50ms_50ms_1.5_1.5.sh.pl
		bm_0_lzs_6_srf104M.txt_compress_5ms_5ms_1.5_1.5.sh.pl
		bm_0_lzs_6_srf719M.txt_compress_50ms_50ms_10_10.sh.pl
		bm_0_lzs_6_srf719M.txt_compress_5ms_5ms_10_10.sh.pl
		bm_1_lzs_0_srf104M.txt_compress_50ms_50ms_1.5_1.5.sh.pl
		bm_1_lzs_0_srf104M.txt_compress_5ms_5ms_1.5_1.5.sh.pl
		bm_1_lzs_0_srf719M.txt_compress_50ms_50ms_10_10.sh.pl
		bm_1_lzs_0_srf719M.txt_compress_5ms_5ms_10_10.sh.pl
		bm_1_lzs_6_srf104M.txt_compress_50ms_50ms_1.5_1.5.sh.pl
		bm_1_lzs_6_srf104M.txt_compress_5ms_5ms_1.5_1.5.sh.pl
		bm_1_lzs_6_srf719M.txt_compress_50ms_50ms_10_10.sh.pl
		bm_1_lzs_6_srf719M.txt_compress_5ms_5ms_10_10.sh.pl
	       );

# talk to and get stats over corporate network
my $orb1 = "10.200.2.125" ;
my $orb2 = "10.200.2.126" ;
my $dr = "10.200.10.175" ;
my $client1 = "10.200.1.109" ;
my $client2 = "10.200.1.150" ;

# the address on the test network of the source and target
my $client1_test = "10.1.1.130" ;
my $client2_test = "10.2.2.130" ;

# set up some delay route stuff
my $dr_clear = "/usr/local/tmp/dummynet/dummy_clear.pl" ;
my $dr_path = "/usr/local/tmp/dummynet/" ;


my $lock = 0 ;

# count the number of iterations so that I only
# print the header on the csv once
my $count = 0;
run_test() ;

sub run_test {
#iterate over the tests 
for my $t ( @tests )
  {
    if ( $count == 10 )
      {
	$count = 0 ;
	$t++ ;
      }
    # grab the configuration that we need

    unless ($return = do $t) {
      warn "couldn't parse $file: $@" if $@;
      warn "couldn't do $file: $!"    unless defined $return;
      warn "couldn't run $file"       unless $return;
    }

    # location of the output csv files
    my $fn1 = "/logs/tmp/log_" . $orb1 . "_" . $t . ".csv" ;
    my $fn2 = "/logs/tmp/log_" . $orb2 . "_" . $t . ".csv" ;

    # open the log files 
    open (FH1, ">>  $fn1") or die "could not open FH1 $fn1:$! \n" ;
    open (FH2, ">>  $fn2") or die "could not open FH2 $fn2: $! \n" ;

    # open a log file
    my $log = "/logs/tmp/log_" . $orb1 . "_" . $orb2 . "_" .  $test_name . ".txt" ;
    open (LOG, ">>  $log") or die "could not open $log: $! \n" ;
    print "cleaning $orb1 ...\n" ;
    print LOG `/tools/bin/perl rw_engine.pl default_orb1.pl` ;
    print "cleaning $orb2 ...\n" ;
    print LOG `/tools/bin/perl rw_engine.pl default_orb2.pl` ;

    print  "cleaning the delay router \n" ;
    print  LOG `ssh -l root $dr $dr_clear` ;

    # build the path to the delay router scripts:
    my $dr_shell = $dr_path .  $dr_file;
    #print "($dr_path)   ($dr_file) \n";
    # configure the delay router
    print  "configuring the delay router...\n" ;
    print LOG  `ssh -l root $dr $dr_clear` ;
    print LOG `ssh -l root $dr $dr_shell $client1_test $client2_test` ;
    print "sleeping ... \n";
    sleep(2);
    print "woke ... \n";
    # configure orbs

    # TODO : Need something here to configure both orbs out of 1 script. ?Fixed ??
    print     "configuring the orbs $orb1 ...\n" ;
    print LOG `/tools/bin/perl rw_engine.pl $t` ;

    # fork a process
    # child monitors the orbs and handles the signal
    # parent runs the test amd then kills the monitor 
    my $child = fork();
    die "can't fork:$! \n" unless defined $child ;
    if ($child > 0)
      {
	print "initial data capture ... \n" ;
	# Lets get the initial picture of the system 
	monitor_orbs($t, $count, $test_file,  $dr_setting, $test_setting) ;
	$count++ ;
	sleep 10 ;

        # run the ftp traffic
        print "starting traffic \n" ;
	#print "FG($file_gets) FT($file_target) \n" ;	
        foreach  my $s ( 1 .. $file_gets) {
	  # run wget writing out to STDOUT and then send it to /dev/null
          print LOG  `wget -O - $file_target > /dev/null` ;
        }
	print "test ended sending kill ...\n" ;
        kill ('INT', $child);
	exit 0 ;
      }
    else
      {
        #$SIG{INT} = \&handle_interrupt ;
        # capture the data
	while (1 )
	  {
	    print "capturing data $count ... \n" ;
	    monitor_orbs($t, $count, $test_file,  $dr_setting, $test_setting) ;
	    $count++ ;
	    sleep 30 ;
	  }
      }
    sleep 10 ;
    print "end of $count test ...\n" ;
 } # end of tests loop
}

sub handle_interrupt
  {
    #print "in interrupt handler  \n" ;
    $lock = 1 ;
    run_test();
   # post proces stuff here
  }

sub monitor_orbs
  {
    my $name_test = shift ;
    my $flag = shift ;
    my $file = shift;
    my $delay_setting = shift ;
    # monitor the orbs every 120 seconds 
    #while (1)
     # {
        print FH1 `/tools/bin/perl rw_engine.pl read_system4.pl $flag $file $name_test $delay_setting $test_setting $orb1 `;
        print FH2 `/tools/bin/perl rw_engine.pl read_system4.pl $flag $file $test_name $delay_setting $test_setting $orb2`;
        sleep 2 ;
    #  }
  }

# this may be alittle drastic
#END
#  {
#    print `killall perl` ;
#  }
