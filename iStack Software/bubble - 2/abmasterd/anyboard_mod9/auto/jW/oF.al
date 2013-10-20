# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2417 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/oF.al)"
sub oF {
 my ($self, $qU, $gK, $lockfdir) = @_;
 $gK = "0" if not $gK;
 return if (!$self->{qG});
 #abmain::error('sys', "Your system is missing Fcntl:flock") if $no_flock;
 my $lf = $self->nDz('lock', $lockfdir)."$gK";
 $qU = LOCK_EX if ((!$qU) || not -f $lf);
 my $lock_fh= eval "\\*lT$gK";
 if($qU == LOCK_EX ) {
 	open ($lock_fh, ">>$lf") or abmain::error('sys', "Fail to open file $lf: $!");
 }else {
 	open ($lock_fh, "$lf") or abmain::error('sys', "Fail to open file $lf: $!");
 }
 eval {
 my $rem;
	 local $SIG{ALRM} = sub { die "lock_operation_timeout ($lf)" };
 $rem = eval 'alarm 20' if $abmain::use_alarm;
 flock ($lock_fh, $qU) or abmain::error('sys', "Fail to lock $lf: $!");
 eval "alarm $rem" if $abmain::use_alarm;
 };
 if ($@ =~ /operation_timeout/) { abmain::error('sys', "Lock operation timed out. Go back and retry.<!--$@-->");  }
 $locks{$gK}=1;
}

# end of jW::oF
1;
