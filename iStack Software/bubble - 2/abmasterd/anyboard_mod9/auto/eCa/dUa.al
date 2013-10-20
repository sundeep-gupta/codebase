# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 452 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/dUa.al)"
sub dUa {
	my $self = shift;
	my $key = 0;
	my $kFa = $self->{kFa};
	my $filesdbpath = $self->{filesdbpath};
	my $titlesdbpath = $self->{titlesdbpath};

	my $dir;
	my $dirs 	= $self->{dirs};
	my $urls	= $self->{urls};
	my $filemask 	= $self->{filemask};
	my $keyref = \$key;
	my $filelistfile = $kFa;
	$filelistfile =~  s/(\.db)?$/\.filelist/;
	$filelistfile =~ /(.*)/; $filelistfile = $1;
	open FILELIST, ">".$filesdbpath;
	open TITLIST, ">".$titlesdbpath;
	
	my $shared = {
		kFa 	=> $kFa,
		filesdbpath 	=> $filesdbpath,
		titlesdbpath 	=> $titlesdbpath,
		indexdb 	=> { },
		filesdb 	=> { },
		titlesdb 	=> { },
		cachedb 	=> { },
		filemask 	=> $filemask,
		current_key	=> 16, 
		bytes		=> 0,
		count 		=> 0,
		filecount	=> 0,
		filesfh		=> \*FILELIST,	
		titsfh		=> \*TITLIST,	
		status_THE 	=> 0,
		kJa	=> $self->{kJa},
		kGa	=> $self->{kGa},
		ignoreword	=> {},
		autoignore	=> 1,
		kBa	=> $self->{kBa} || (2/3),
		level		=> $self->{level},	
		max_entry	=> $self->{max_entry},
		multibyte       =>$self->{multibyte},
 wsplit          => $self->{siteidx_wsplit} || pack("h*", $qWa::cEaA),
		url_exclude 	=> $self->{url_exclude},
		url_exclude2 	=> $self->{url_exclude2},
	};
	
	unlink $kFa."~"; 
	unlink $filesdbpath."~"; 
	unlink $titlesdbpath."~";
	eJa($shared->{indexdb}, $kFa."~", $eCa::sep )   or die "$kFa: $!\n";
	eJa($shared->{filesdb}, $filesdbpath."~" )   or die $!;
	eJa($shared->{titlesdb},$titlesdbpath."~" ) or die $!;

	my $ignorefile = $kFa;
	$ignorefile =~ s/(\.db)?$/\.stopwords/;
	if (-r $ignorefile) { 
		open F, $ignorefile;
		while (<F>) {
			chomp;
			s/^\s+|\s+$//g;
			$shared->{ignoreword}->{$_} = 1;
		}
		close F;
		my $count = int keys %{ $shared->{ignoreword} };
		$shared->{autoignore} = 0;
	}
	my $time = time();
	my $filecount = 0;
	#DEBUG("Counting files...\n") if int @$dirs;
 	for $dir( sort  @$dirs) { $filecount += dBa($shared, $dir, 1); }
	for $dir( sort  @$dirs) { dBa($shared, $dir); }
	my @deads;
	for my $url( sort  @$urls) {  push @deads, [$url, [dWa($shared, $url) ]]; }
	$time = time()-$time;
	#DEBUG("$shared->{bytes} bytes read, $shared->{count} files processed in $time seconds\n");
	dVa($shared->{indexdb}, $shared);
	ePa($shared->{indexdb}, $kFa, $eCa::sep);
	# ePa($shared->{filesdb}, $filesdbpath);
	# ePa($shared->{titlesdb}, $titlesdbpath);
	
	close FILELIST;
	close TITLIST;
	if ( $shared->{autoignore} ) {
		open  F, ">".$ignorefile;
		print F join( "\n", sort keys %{ $shared->{ignoreword} } );
		close F;
	}

	return @deads;	
}

# end of eCa::dUa
1;
