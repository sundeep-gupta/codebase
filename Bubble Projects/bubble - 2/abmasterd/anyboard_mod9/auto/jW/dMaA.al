# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7651 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dMaA.al)"
sub dMaA {
 my($self, $cG) = @_;
	my $entry = $self->pO($cG);
	if($entry->{to}) {
		$self->dSaA($entry->{fI});
		$self->hKa($entry);
 	for my $to (split /\s*,\s*/, $entry->{to}) {
			$self->cOaA($entry->{fI}, $to, {modify_time=>time(), msg_subj=>$entry->{wW}});
		}
 }
}

# end of jW::dMaA
1;
