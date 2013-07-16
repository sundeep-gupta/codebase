# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4573 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gIaA.al)"
sub gIaA{
 my ($self)= @_;
 my $cf = $self->nDz('flist');;
 my $tt;
 local *F;

 if((not -f $cf) || (stat($cf))[9] < time() - 3600) {
 my $lck = jPa->new($cf, jPa::LOCK_EX());
 if((not -f $cf) || (stat($cf))[9] < time() - 360) {
	      	abmain::hYa(); 
 		$tt= abmain::fKa(1, $self->fC());
		open F, ">$cf" or return "System error when writing file ($cf, $!)";
		print F $tt;
		close F;
	}
 }
 open F, "<$cf";
 local $/=undef;
 $tt = <F>;
 close F;
 return $tt;

}

# end of jW::gIaA
1;
