# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8359 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gXa.al)"
sub gXa{
 my ($self, $gJz) = @_;
	my $mf = new aLa('mem', \@abmain::member_profile_cfgs);
	return $mf if $gJz eq "";
	$mf->aCa(['avatar', 'radio', $self->{avatar_trans}, "Avatar"]);
	$mf->zOz();
 my $pf = $self->bJa($gJz);
 my ($p, $s) = @{$self->dHaA($pf)};
 if(not $abmain::use_sql) {
		$mf->load($pf);
	}else {
		my $dbo= zDa->new('AbUserProfile');
		$dbo->aPaA("where userid=? and realm=? and srealm=?", [lc($gJz), $p, $s]);
		$mf->rWa($dbo);
 }
	return $mf;
}

# end of jW::gXa
1;
