# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1462 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/rAa.al)"
sub rAa {
 my($self, $old, $new) = @_;

 my @eE;
 $old = "\Q$old\E";
 for(values %abmain::qJa) {
	my $eE = $_->[1];
 for(@$eE) {
		my $k = $_->[0];
		$self->{$k} =~ s/$old/$new/g;
	}
 }
}

# end of jW::rAa
1;
