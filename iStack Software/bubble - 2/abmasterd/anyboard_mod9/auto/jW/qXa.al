# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3320 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/qXa.al)"
sub qXa{
	my ($self) = @_;
 	my $sdb =  $self->nDz('sdb')."_mark";
	return if $self->{sdb_intv}<=1;
return; 
 	return if( (stat($sdb))[9] > time() - 3600*$self->{sdb_intv});
 my $lck = jPa->new($sdb, jPa::LOCK_EX());
 	if( (not -f $sdb) || (stat($sdb))[9] < time() - 3600*$self->{sdb_intv}) {
		local *F;
		open F, ">$sdb" or return;
		print F time();
		close F;
		$self->qOa();
	}

}

# end of jW::qXa
1;
