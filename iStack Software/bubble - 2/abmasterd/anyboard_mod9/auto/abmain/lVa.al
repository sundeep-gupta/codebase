# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 4746 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/lVa.al)"
sub lVa{
	abmain::error("dM", "Wrong login or password") if(not eVa()) ;
 my $id = $abmain::gJ{id};
	my $bf = abmain::wTz('bannerfile');
 my $uNa = new hDa($bf);
	$uNa->jYa($id);
 $uNa->store() or abmain::error("sys", "Fail to open file $bf: $!");
	pBa("Entry $id deleted");
}

# end of abmain::lVa
1;
