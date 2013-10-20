# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 718 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/oF.al)"
sub oF {
 my ($qU, $gK, $lockfdir) = @_;
 $gK = "0" if not $gK;
 error('sys', "Your system is missing Fcntl:flock") if $no_flock;
 my $lf = kZz($lockfdir, "$gK");
 $qU = LOCK_EX if (!$qU);
 my $lock_fh= eval "\\*lT$gK";
 open ($lock_fh, ">>$lf") or error('sys', "Fail to open lock file $lf: $!");
 eval {
	 local $SIG{ALRM} = sub { die "lock_operation_timeout" };
 eval 'alarm 10' if $sVa::use_alarm;
 flock ($lock_fh, LOCK_EX) or error('sys', "Fail to lock $lf: $!");
 eval 'alarm 0' if $sVa::use_alarm;
 };
 if ($@) { error('sys', $@." Go back and retry.");  }
 $locks{$gK}=1;
}

# end of sVa::oF
1;
