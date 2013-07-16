# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1250 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/pJa.al)"
sub pJa {
	my $self = shift;
	my $dir = $self->{eD};
	$dir =~ s!/!-!g;
	$dir =~ s!:!_!g;
	$dir =~ s!\\!-!g;
	return "ABF$dir";
}

# end of jW::pJa
1;
