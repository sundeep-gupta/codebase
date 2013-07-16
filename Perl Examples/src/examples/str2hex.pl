my $var = $ARGV[0]; my $i; foreach $i (split(//,$var)) {printf '%x', ord($i);}
