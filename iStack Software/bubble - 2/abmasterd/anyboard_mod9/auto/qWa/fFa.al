# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package qWa;

#line 201 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/qWa/fFa.al)"
sub fFa{
	my ($self) = @_;
	sVa::error("dM", "Wrong login/password") if(not $self->eVa()) ;
	my $mf = new aLa('idx', \@qWa::siteidx_cfgs, $self->{cgi});
	$mf->zOz();
	$mf->aAa($self->{input});

	$mf->store($self->{siteidxcfg});
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 if(not $mf->{siteidx_conf}) {
		print $mf->form(1);
 	print "</body></html>";
		return;
 }
		
	my ($dir, @urls);
 $dir = $mf->{siteidx_topdir} if $mf->{siteidx_method} eq 'file';
	push @urls,  [0, $mf->{siteidx_url0}] if $mf->{siteidx_method} eq 'http';
	my $i=0;

	for($i=1; $i<6; $i++) {
		push @urls, [$i, $mf->{"siteidx_url$i"}] if $mf->{"siteidx_url$i"};
	}

 $mf->{siteidx_wsplit} =~ s/\|+$//;
 $mf->{siteidx_wsplit} =~ s/^\|+//;
 for(@urls) {
		$self->rDa($mf, $_->[0], $_->[1], undef, \*STDOUT);
	}
	$self->rDa($mf, 0, undef, $dir, \*STDOUT) if $dir;

	$mf = new aLa('idx', \@qWa::sitesearch_cfgs, $self->{cgi});
 print $mf->form();
 print "</body></html>";
}

# end of qWa::fFa
1;
