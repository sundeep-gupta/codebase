# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 588 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/dLa.al)"
sub dLa {
	my ($shared, $file, $lmt, $text) = @_;
	my $cachedb = $shared->{indexdb};
	my $filesdb = $shared->{filesdb};
	my $key = $shared->{current_key};
	my $no_of_files = $shared->{filecount};
	$shared->{filecount}++;
	DEBUG $shared->{count}+1, "/$no_of_files $file (id=$key)\n";
	my $filesfh = $shared->{filesfh};
	my $titsfh = $shared->{titsfh};
	local $/;
	my $had_txt = 0;
	$had_txt = 1 if length($text) > 0;
	unless ($had_txt) {
		undef $/;
		open(FILE, $file);
		($text) = <FILE>; 	
		close FILE;
	}
	my $filesize =  length($text);
	if ($file =~ /\.s?htm.?/i || $had_txt ) {
		$text =~ s/&nbsp;/ /gi;
		$text =~ s/\s+/ /g;
		$text =~ /<title[^>]*>([^<]+)<\/title>/gci ;
		my $title = $1;
		$title =~ s/\s+/ /g;
 $text =~ s/.*<body[^>]*>//i;       
 $text =~ s/<style[^>]*>.*?<\/style>/ /gi;       
 $text =~ s/<script[^>]*>.*?<\/script>/ /gi;       
 $text =~ s/<[^>]*>/ /g;
 $text =~ s/\s+/ /g;
		my $abstract = substr $text, 1, 120;
 my $chk = unpack("%16C*", $text); 
		$lmt =~ s/\s+/ /g;
	#	$shared->{titlesdb}->{pack"xn",$key} = $title."\t".$abstract."\t$chk\t$filesize\t$lmt";  

		print $titsfh pack("xn",$key), "\t", $title."\t".$abstract."\t$chk\t$filesize\t$lmt", "\n";  

		#DEBUG("* \"$title\"\n");
		for(0..9){
			$text .= "  $title";
		}
	}
	my($wordsIndexed) = $shared->{multibyte}? pUa($cachedb, $text,$key, $shared): dRa($cachedb, $text,$key, $shared);
	$shared->{current_key}++;
	#DEBUG "* $wordsIndexed words\n";
	
	# $filesdb->{pack"xn",$key} = $file;   	 
	print $filesfh pack("xn",$key), "\t", $file, "\n";   	 
	$shared->{bytes} += $filesize;
	$shared->{count}++;
	$shared->{iMa} += $filesize;
}

# end of eCa::dLa
1;
