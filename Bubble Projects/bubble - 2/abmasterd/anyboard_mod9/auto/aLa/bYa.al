# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 72 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/bYa.al)"
sub bYa{
	my ($refa) =@_;
 my $t = $refa->[1];
	if($t eq 'select' || $t eq 'kAa') {
		return bNa->new(@$refa);
	}
	if($t eq 'radio') {
		return bBa->new(@$refa);
	}
	if($t eq 'checkbox') {
		return cEa->new(@$refa);
	}
	if($t eq 'textarea' || $t eq 'htmltext' || $t eq 'hidden'|| $t eq 'text' || $t eq 'file' || $t eq 'ifile' || $t eq 'password' || $t eq 'const' || $t eq 'fixed'){
		return bAa->new(@$refa);
	}
	return bAa->new(@$refa);
}

# end of aLa::bYa
1;
