# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1204 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/test_pattern.al)"
sub test_pattern{
	my $pat = shift;
	return 1 if $pat eq "";
	my $ok1 = eval { "" =~ /$pat/; 1};
	return if not $ok1;
	return ('a' =~ /$pat/)? 0: 1;
}

# end of jW::test_pattern
1;
