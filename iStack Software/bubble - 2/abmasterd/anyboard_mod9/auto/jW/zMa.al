# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8376 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/zMa.al)"
sub zMa{
 my ($self, $mf, $gJz) = @_;
	$gJz = lc($gJz);
 my $pf = $self->bJa($gJz);
 my ($p, $s) = @{$self->dHaA($pf)};
 if(not $abmain::use_sql) {
		$mf->store($pf);
	}else {
		require zDa;
		my $dbo= zDa->new('AbUserProfile');
		if($dbo->aPaA("where userid=? and realm=? and srealm=?", [$gJz, $p, $s])) {
			$dbo->bCaA($mf, "where userid=? and realm=? and srealm=?", [$gJz, $p, $s]);
		}else {
			$dbo->aTaA($mf);
			$dbo->{realm}= $p;
			$dbo->{srealm}= $s;
			$dbo->{userid}=$gJz;
			$dbo->tEa();
		}
		
 }
	return $mf;
}

# end of jW::zMa
1;
