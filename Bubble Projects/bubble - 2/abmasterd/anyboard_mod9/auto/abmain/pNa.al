# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3999 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/pNa.al)"
sub pNa {
 my	($is_root, $root) = eVa() ;
 error('dM', "Who are you?") if not $is_root;
 my @emails = hAa();
 sVa::gYaA "Content-type: text/plain\n\n";
 my $tot =0;

 for(@emails) {
	print $_->[0], ":\n\n";
 my @ems = split(", ",  $_->[1]);
	$tot += scalar(@ems);
 print scalar(@ems), " email addresses\n";
 print join("\n", split ", ", $_->[1]);
 print "\n\n";
 }
 print "Total: $tot\n";
}

# end of abmain::pNa
1;
