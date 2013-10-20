# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 32 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/new.al)"
sub new { 
	my $pkg = shift;
	my $arg = shift;
	my $opt = undef;
	if (ref($arg) ne "HASH") { 
		if (-f $arg) {
			$opt->{IndexDB} = $arg;
			$opt->{Verbose} = shift;
		}
		else {	
			die " wrong usage"    
		}
	} else {
		$opt = $arg;
	};

	$verbose_flag = $opt->{Debug} || $opt->{Verbose} ; 
	
	my $kFa = $opt->{IndexDB} || $opt->{IndexPath} ;
	my $filemask 	= $opt->{FileMask} ;
	my $dirs 	= ( ref($opt->{Dirs}) eq "ARRAY" ) ? $opt->{Dirs} : [ ];
	my $kJa = defined $opt->{FollowSymLinks};
	
	my $opturls =  $opt->{Urls} ||  $opt->{URLs};
	my $urls 	= ( ref($opturls) eq "ARRAY" ) ? $opturls : [ ];
	my $level	= int $opt->{Level};
	my $max_entry   = int $opt->{MaxEntry};
	
	my $filesdbpath = $kFa;
	$filesdbpath =~ s/(\.db)*$/\-files.db/;
	my $titlesdbpath = $kFa;
	$titlesdbpath =~ s/(\.db)*$/\-titles.db/;
	
	my $kGa = $opt->{MinWordSize} || 1;
	my $self = {
		kFa 	=> $kFa,
		filesdbpath 	=> $filesdbpath,
		titlesdbpath	=> $titlesdbpath,
		filemask 	=> length($filemask) ? qq/$filemask/ : undef,
		dirs 		=> $dirs,
		kJa  => $kJa,
		kGa	=> $kGa,
		kBa	=> $opt->{IgnoreLimit} || (4/5),
		urls		=> $urls,
		level		=> $level,
 max_entry       => $max_entry,
		multibyte       => $opt->{multibyte},
		wsplit          => $opt->{wsplit},
		url_exclude	=> "(?i).*\.(zip|exe|tgz|arj|bin|hqx|Z|jpg|gif|bmp|js)", 
		url_exclude2	=> $opt->{UrlExcludeMask},
		
	};
	DEBUG("filemask=$filemask, indexfile=$kFa, kBa=$self->{kBa}\n");
	DEBUG("dirs = [", join(",", @$dirs),"], ");
	DEBUG("urls = [", join(",", @$urls),"] \n");
	bless($self, $pkg);
	return $self;
}

# end of eCa::new
1;
