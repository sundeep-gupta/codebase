#!/usr/bin/perl 
use English;
use strict;
use Net::Ping;
use Data::Dumper;

#TODO: Algorithm for Script
#   -- check_machine
#  1. Read the hostnames from the file. DONE
#  2. For each hostname - DONE
#  3. Ping the Machine to check availability - DONE
#  4. Find the latest label on the series - TODO
#  5. Find the base label for the latest label found
#  6. Createview to check that I'm able to create a view
#  7. Setup alias for oratst
#  8. Symlink /home/aime/regress
#  7. Write the hostname into machine_available.log
#
#  -- initialize database for N Sessions in all accessible machines
#   1. Check if machines_available.log exist if not run through above steps
#   2. Read the hostname from the file
#   3. For N Times   
#      a) createview
#      b) source the database file.
#      c) run oratst to initialize 
#      d) Verify there is no ERROR in the log file.
#      e) check database (TNSPING)
#      f) if all success write the hostname + lrg# in the ready.log

#   -- run_lrg
#  FOr each hostnmae in ready.log
# for each lrg in ready.lrg
# useview <view>
# start the oratst program
# 

#  --check_lrg
# for each hostname, lrg in ready.log
# check if done file is cretaed
# if not , check if fail file is created.
# write the list of failed lrg in a log and quit.


# --diff_lrg
# for each hostname
# run the lrg diff script on the base label.
#
my @error_stack = ();
my $list_file = 'machines.lst';
my $options = &parse_args(@ARGV);
&check_new();

if ($$options{'check_available'} ) {
    &check_available($list_file);
    return if &status();
}

sub check_available {
    my @available_hosts = &get_available_hosts($_[0]);
    return if &status();
}

sub get_available_hosts {
    my $filename = shift @_;
    my $file_h ;
    my @available_hosts = ();

    open($file_h, $filename) or &push_message("Unable to open file :$OS_ERROR");
    return if &status();

    my @host_list = <$file_h>;

    foreach my $host (@host_list) {
        chomp $host; $host =~ s/^\s+//; $host =~ s/\s+$//;
        next if $host =~ /^#/ || $host eq "";
        print("Pinging $host ... ");
        
        my $ping = Net::Ping->new();
        if ($ping->ping($host) ) {
            push(@available_hosts, $host);
            print(" Available\n");
        } else {
            print(" Unreachable\n");
        }
    }
    
    return @available_hosts;

}

sub interactive {
    my $message = $_[0];
    print "$message\n";
}
sub push_message {
    my $message = shift @_;
    push @error_stack, $message if $message;
}

sub status {
    return scalar @error_stack;
}

sub check_new {
    if (&status() ) {
        foreach my $message (@error_stack) {
            print STDERR "ADE Error: $message\n";
        }
        exit(0);
    }        
}

sub parse_args {
    my @args = @_;
    my $options = {
        'diff_lrg' => 0,
        'check_lrg' => 0,
        'run_lrg' => 0,
        'init_db' => 0,
        'check_available' => 0,
    };

    foreach my $arg (@args) {
        last if (status());
        if ($arg =~ /^-(.*)$/ && exists($$options{$1})) {
            $options->{$1} = 1;
        } else {
            &push_message("Invalid option :$arg");
            return;
        }
    }
    return $options;
}
