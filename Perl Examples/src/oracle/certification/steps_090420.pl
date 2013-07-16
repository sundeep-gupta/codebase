#!/usr/local/bin/perl 

use strict;
my $sql_cmd_file = $ENV{HOME}.'/sql_cmd';
my $view_name = $ARGV[0] ;
my $initlog = "ade/test/log/testini.log";
my $i = $ARGV[1];
my $log_file = $ENV{HOME}."/$view_name.log";
exit unless ($view_name and $i);
open(my $fh, "| ade useview $view_name > $log_file") or die "Cannot use view ";
print $fh "source ".$ENV{HOME}."/regress/setup_mydb$i.csh\n";
print $fh "oratst -initfile ade/test/utl/ade_oratst.ini -d testini db_ground \n";
print $fh "grep ERROR $initlog | grep ade \n";
print $fh "echo 'select * from global_name;' > $sql_cmd_file \n" unless -e $sql_cmd_file;
print $fh "ade sqlplus < $sql_cmd_file | grep 'US.ORACLE.COM' \n";
print $fh "oratst -initfile ade/test/utl/ade_oratst.ini -d tkmain_$i db_testini \n" ;
close $fh;
