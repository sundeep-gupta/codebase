# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 514 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/pWa.al)"
sub pWa{
 my($self, $email) = @_;
 abmain::jJz(\$email);

 return $self->{_email_to_usr}->{lc($email)} if $self->{_email_to_usr}->{lc($email)};

 my @jXz = $self->rD();
 my @xlines;
 for(@jXz) {
	  next if ((not -f $_ ) && (not $abmain::use_sql));
	  my $linesref = $bYaA->new($_, {schema=>"AbUser", paths=>$self->dHaA($_) })->iQa({noerr=>1, where=>"email='$email'", filter=>sub {lc($_[0]->[2]) eq lc($email); } });
	  push @xlines, @$linesref if $linesref;
 }

 my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti);
 my %user_emails=();
 my @vcards;
 my %seen_user=();
 local $_;
 while ($_ = pop @xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @$_; 
	  if (lc($e) eq lc($email)) {
 		$self->{_email_to_usr}->{lc($email)}  = $_;
	  	return $_;
	  }
 
 }
}

# end of jW::pWa
1;
