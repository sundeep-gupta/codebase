# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3336 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/qOa.al)"
sub qOa{
 my ($self) = @_;
 my $sdb =  $self->nDz('sdb');
 my $dirs = [$self->{eD}];
 my $urls =[$self->{pL}];
 my $mf = new aLa('idx', \@qWa::siteidx_cfgs, $abmain::jT);
 $mf->zOz();
 $mf->load(abmain::wTz('siteidxcfg'));
 
 my $search = new eCa { 
		IndexDB 	=> $sdb,
		FileMask	=> $mf->{siteidx_filematch},,
		Dirs 		=> $dirs,
		IgnoreLimit	=> 4,
		Verbose 	=> 0,
 multibyte       => $mf->{siteidx_multibyte},
 wsplit          => $mf->{siteidx_wsplit} || pack("h*", $abmain::cEaA),
		URLs		=> undef,	
		Level  		=> $mf->{"siteidx_depth"} || 50,
		MaxEntry        => undef,
		UrlExcludeMask => 'pv-.*'
	
	};
 my @deads = $search->dUa(); 

}

# end of jW::qOa
1;
