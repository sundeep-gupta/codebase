# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jEa;

#line 15 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jEa/pXa.al)"
sub pXa{
	my ($self) = @_;
 my $f = $self->{tb};
 my $cnt =0; 
	my $buf;
 my $lck = jPa->new($self->{tb}, jPa::LOCK_SH);
 local *F;
	open F, "<$f";
 while(sysread F, $buf, 4096*4) { $cnt += ($buf =~ tr/\n//);}
 close F;
	my $hsh = jEa::hAz($f."_del");
 my $dcnt =0;
	if($hsh) {
		$dcnt = scalar(keys %$hsh);
	}
	return wantarray?($cnt-$dcnt, $dcnt): $cnt-$dcnt;
}

# end of jEa::pXa
1;
