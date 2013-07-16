# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 876 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dJ.al)"
sub dJ {
 my ($self, $n, $p, $e, $fUz, $gDz, $gIz, $ut, $fXz, $fSz, $add2noti, $showme) = @_;

 if(not ( $self->{gBz}  || $self->{gAz})) {
 abmain::error('inval', "User registration was not enabled for $self->{name}");
 } 
 $self->fZz($n);
 my $cE = $self->{fYz}->{lc($n)};
 if ($cE ) {
 abmain::error('inval', "$n already registered, please choose another name")
 unless (lc($self->{fTz}->{name}) eq lc($n) && $self->{fTz}->{reg});
 }
 $abmain::iG = abmain::lKz($p);
 my $jK;
 if($e =~ /$abmain::uD/) {
 $jK = $1;
 }

 if( (!$jK) && ($self->{rH} || $self->{require_email_nv})) {
 abmain::error('miss', "A valid e-mail address is required for registration");
 }elsif( not $self->{rH}) {
 $gIz = 0;
 }

 if($self->{rH}) {
 	&abmain::error('inval', "The email address $e is not acceptable") if($self->{allowed_emails} && $e !~ /$self->{allowed_emails}/i);
 	&abmain::error('inval', "The email address $e is not acceptable") if($self->{jDz} && $e =~ /$self->{jDz}/i);
 }
 $self->aG(lc($n), $abmain::iG, $jK, $fUz, $gDz, $gIz, $ut, $fXz, $fSz, $add2noti, $showme);
 my $err = $self->wI($n, $p, $e, $gIz);
 my $gQ=0;
 if($self->{rH}) {
 	if($err) {
	    $self->dP(lc($n));
 $gQ =1;
 	    &abmain::error('sys', "Fail to send validation e-mail, user record not created.<br/>Error: $err");
 	}
 }
 $self->save_user_passwd($n, $p) if not $gQ;
}

# end of jW::dJ
1;
