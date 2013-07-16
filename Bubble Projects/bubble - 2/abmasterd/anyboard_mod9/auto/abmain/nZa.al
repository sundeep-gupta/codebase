# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2877 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/nZa.al)"
sub nZa{
	my $dir = shift;
 	return if not -w $dir;
 	my $f = kZz($dir, time()."abt"); 
 my $w;
	local *F;
 	if((open F, ">$f") && print F time() ) {
		close F;
		$w = 1;
 	}
 	unlink $f if -f $f;
	return $w;
}

# end of abmain::nZa
1;
