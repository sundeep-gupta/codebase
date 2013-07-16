# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9704 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/eYaA.al)"
sub eYaA {
	my ($self) = @_;
	return if $self->{_org_info_hash_inited};
 	my $mf = new aLa('idx', \@abmain::iBa);
 	$mf->zOz();
 	$mf->load(abmain::wTz('leadcfg'));
	$self->{_org_info_hash} = {};
	for(@abmain::forum_org_info_cfgs) {
		next if $_->[1] eq 'head';
		my $k = $_->[0];
		my $tag = $k;
		$tag =~ s/^ab_//;
		my $v = ($self->{$k} =~ /\S/)? $self->{$k} : $mf->{$k}; 
		$self->{_org_info_hash}->{uc($tag)} = $v; 
 }
	$self->{_org_info_hash_inited} =1;
}

# end of jW::eYaA
1;
