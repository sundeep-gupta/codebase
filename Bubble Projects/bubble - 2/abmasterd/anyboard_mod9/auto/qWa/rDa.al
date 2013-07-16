# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package qWa;

#line 154 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/qWa/rDa.al)"
sub rDa{
 my ($self, $mf, $idx, $url, $dir, $nA, $no_verbose) = @_;

 return if not ($url || $dir);
	my ($dirs, @urls);

 $dirs = [$dir] if  -d $dir;
	push @urls,  $url if $url =~ /^http/i;
	my $i=0;

	my $search = new eCa { 
		IndexDB 	=> $self->rCa($idx),
		FileMask	=> $mf->{siteidx_filematch},,
		Dirs 		=> $dirs,
		IgnoreLimit	=> 4,
		Verbose 	=> $no_verbose?0:1,
 multibyte       => $mf->{siteidx_multibyte},
 wsplit          => $mf->{siteidx_wsplit} || pack("h*", $qWa::cEaA),
		URLs		=> \@urls,	
		Level  		=> $mf->{"siteidx_depth$idx"} || 50,
		MaxEntry        => $mf->{siteidx_maxfiles},
		UrlExcludeMask => $mf->{siteidx_fileskip}
	
	};

	print $nA "<h2>Indexing in progress, please wait for it to finish ($url $dir) </h2>";
	print $nA "<pre>";
	my @deads;
#x2
 print $nA "</pre><a name=EOF_IDX>";
 #print $nA qq(<script>location="#EOF_IDX";</script>);
	print $nA "<h1>Indexing finished</h1>";
	my $pge;
	my @rows;
	for $pge (@deads) {
		my ($url, $dlink) = @$pge;
		next if not @$dlink;
		print $nA "<h3>Errors for $url</h3>";
		for(@$dlink) {
			my ($e, $link, $plink) = split /\t/, $_;
			next if not ($e && $link);
			push @rows, [$e, sVa::cUz($link, $link), sVa::cUz($plink, $plink)];
		}
	}
 print $nA &sVa::fMa(rows=>\@rows, ths=>["Error", "Error URL", "In page"], sVa::oVa());
}

# end of qWa::rDa
1;
