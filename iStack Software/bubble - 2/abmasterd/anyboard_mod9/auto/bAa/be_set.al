# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 106 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/be_set.al)"
sub be_set{
 my ($v, $arga) = @_;
 return " $bAa::missing_val_label" if ($v eq "");		 
 return if ($v ne "" && not $arga);
 my $ok=1;
 if(scalar(@$arga)) {
	$ok=0;
 	for(@$arga) {
		$v =~ /$_/i and $ok =1 and last;
 	}
 }
 return " $bAa::invalid_val_label" if not $ok;		 
}

# end of bAa::be_set
1;
