# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1026 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/iMz.al)"
sub iMz {
 my ($self, $n, $p, $e, $c, $matche) = @_;
 $self->fZz($n);
 my $np = abmain::lKz($p);
 
 my $isadm =  lc($n) eq lc($self->{admin});

 if(not $self->{gFz}->{lc($n)}) {
 	 &abmain::error('inval', "User $n not found") if not $c;
 my $fMz = $self->{user_init_type}||'E';
 	 my $ustat = $self->{user_init_stat} || 'A';
	 if($isadm) {
		$fMz = 'E';
		$ustat = 'A';
	 }
 $self->{gFz}->{lc($n)}->[4]= $ustat;
 $self->{gFz}->{lc($n)}->[6]= $fMz;
 }

 my $err;
 if($err=abmain::jVz($n)) {
 abmain::error('inval', $err);
 }
 if(length($n) > $self->{sO}){
 &abmain::error('iK', "Name field must be less than ${\($self->{sO})} characters");
 }

 if ($e ne $self->{gFz}->{lc($n)}->[1]  && $matche) {
 	&abmain::error('inval', "Incorrect email address");
 }

 $e = abmain::xJz($e) || $self->{gFz}->{lc($n)}->[1];
 abmain::error('miss', "A valid email address is required") if ($self->{rH} && (not $e) && (not $isadm));
 $self->aG(lc($n), $np, $e, @{$self->{gFz}->{lc($n)}}[3..9]);
 $self->save_user_passwd($n, $p);
}

# end of jW::iMz
1;
