# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 874 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/gLaA.al)"
sub gLaA {
 my $mail = shift;
 my $wD = "";
 
 if($mail->{to_list}) {
 $wD = $mail->{to_list};
 }
 delete $mail->{to_list};
 my @msgs= ();
 while ($wD =~ /$uD/go) {
	my $e = $1;
	$mail->{To} = $e;
	vS($mail);
	if ($wH) {
		push @msgs, 'Error:'.$wH;
	}else {
		push @msgs, 'Sent to:'.$e;
	}
 
 }
 return @msgs;
}

# end of sVa::gLaA
1;
