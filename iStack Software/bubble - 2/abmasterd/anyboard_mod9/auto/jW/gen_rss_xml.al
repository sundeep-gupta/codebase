# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8457 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gen_rss_xml.al)"
sub gen_rss_xml {
	my ($self, $input, $cnt, $objs) = @_;
	my ($iN, $etime, $fN) =  @{$input}{qw(iN etime fN)};
	my $furl = $self->fC();
	my $xO = $self->{name};
	my $desc = $self->{forum_desc};
 gWaA(\$desc);
 gWaA(\$xO);

	my $enc="";
	if($self->{txt_encoding} =~ /\w/) {
		$enc = qq( encoding="$self->{txt_encoding}");
	}
	my $start =qq(<?xml version="1.0"$enc ?>\n<rss version="0.91">\n);
	my $chan = qq(<channel>\n<title>$self->{name}</title>\n<link>$furl</link>\n<description>$desc</description></channel>\n);
	if($cnt <=0) {
 	($cnt, $objs) = $self->nYa(undef, 0, 0, 0, $iN, $etime, 1, undef);
	}
	my $idx = 0;
	$fN = 15;
	if($fN >0 && $cnt >$fN) {
		$idx = $cnt - $fN;
	}
	my $i=$idx;
	my @itemstrs;
	for(;$i<$cnt; $i++) {
		my $obj = $objs->[$i];
		next if length($obj->{body}) < 256;
		my $tit = $obj->{wW};
		my $url = $obj->nH($self, -1);
		$url =~ s/&/&amp;/g;
 	my $text= $obj->{body};
		$text =~ s/&nbsp;/ /gi;
		$text =~ s!<br/>|<p>!\n!gi;
 	$text =~ s/<[^>]*>//gs;   
		my $abs = substr $text, 0, 200;

 gWaA(\$tit);
 gWaA(\$abs);

		push @itemstrs, 
			qq(<item>\n<title>$tit</title>\n<link>$url</link>\n<description>$abs</description>\n</item>\n);
	}
	return join("", $start, $chan, @itemstrs, "</rss>");

}

# end of jW::gen_rss_xml
1;
