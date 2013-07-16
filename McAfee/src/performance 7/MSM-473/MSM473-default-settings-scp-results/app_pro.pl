#!/usr/bin/perl


my $apppro_log = "./app_pro.log";
my $apppro_log_mod = "./app_pro_log_mod";
my $contents = `cat $apppro_log`;
my @lines = split('\n',$contents);
my $result_1 = "Command  FILESIZE in KB  TIME TAKEN in secs\n";
my $result_2 = "APPLICATION  TIME TAKEN \n";
foreach my $line (@lines) {
    if ($line =~ /scp/) {
        $result_1 .= "$line\n";
    }
    if ($line =~ /TIME TAKEN/) {
        $line =~ s/TIME TAKEN\s+//;
        $result_2 .= "$line\n";
    }
}
open (FP,">$apppro_log_mod");
print FP "$result_1\n";
print FP "$result_2\n";
close (FP);


