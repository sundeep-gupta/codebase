# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7636 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/vWz.al)"
sub vWz {
 my ($self, $entry) = @_;
	my $mf = $self->nDz('msglist');
 $bYaA->new($mf, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($mf) })->jXa(
 [[@{$entry}{@lB::mfs}]]
 );
 	if($entry->{to}) {
		$self->dSaA($entry->{fI});
		$self->hKa($entry);
 	for my $to (split /\s*,\s*/, $entry->{to}) {
			$self->cOaA($entry->{fI}, $to, {modify_time=>time(), msg_subj=>$entry->{wW}});
		}
	}
}

# end of jW::vWz
1;
