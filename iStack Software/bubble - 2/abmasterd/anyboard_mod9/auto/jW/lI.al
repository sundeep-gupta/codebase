# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1603 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/lI.al)"
sub lI {
 my($self) = @_;
 $self->bI();
 abmain::vA();
 $self->iA(\@abmain::bO);
 my $sf = $self->nDz('skey');
 my $ptmp = "";
 if(open SF, $sf) {
	$ptmp =<SF>;
	$ptmp =~ s/\s//g;
	close SF;
 }
 if($self->{eF}->{mS} ne $self->{eF}->{dQz} ) {
	     	abmain::error('inval', "New passwords do not match.");
 }
 my $cE = abmain::lKz($self->{eF}->{oA}, $self->{oA});
 if($self->{oA} ne $cE && $self->{oA} ne "") {
 #sleep(1);
	     	abmain::error('dM', "Wrong admin password.") 
			unless $ptmp && $ptmp eq $cE;
 }
 $self->{oA}=abmain::lKz($self->{eF}->{mS});
 unlink $sf;
 
}

# end of jW::lI
1;
