# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8649 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/iVa.al)"
sub iVa{
	my ($self, $f) = @_;
 	$self->oF(LOCK_SH,99);
 my $cnt =0; 
	my $buf;
 local *F;
	open F, "<$f";
 while(sysread F, $buf, 4096*4) { $cnt += ($buf =~ tr/\n//);}
 close F;
 	$self->pG(99);
	return $cnt;
}

# end of jW::iVa
1;
