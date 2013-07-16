# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package qWa;

#line 291 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/qWa/fAa.al)"
sub fAa {
	my ($self)=@_;
	my $t0 = time();
	my $mf = new aLa('idx', \@qWa::siteidx_cfgs, $self->{cgi});
	$mf->zOz();
	$mf->load($self->{siteidxcfg});
	sVa::gYaA "Content-type: text/html\n\n";
 my $multibyte =$mf->{siteidx_multibyte};

 my @files;
 my $i=0;
 my $line = $self->{input}->{tK};
 my $pagenum = $self->{input}->{pagenum};

 my $search;
 my $err="";
 my $totmatch=0;

 for($i=0; $i<6; $i++) {
		next if not -f $self->rCa($i);
		$search = eCa->new($self->rCa($i), 0);

		my $result;
		if ($line =~ /\band\b|\bor\b/i) {
			$result = $search->eIa($line,1);
		} else {
			$result = $search->query([split /\s+/, $line], $multibyte);
		}
		my $cnt = int  @{ $result->{files} };
		$totmatch += $cnt;	 
		push @files, [$i, $result->{files}] if $cnt;;
		$err .="<br>".$search->errstr() if $search->errstr();
 }
	my $k;
	my $method = $mf->{siteidx_method};
	my $topdir = $mf->{siteidx_topdir};
	my $topurl = $mf->{siteidx_url0};
	my $pgsz = $mf->{siteidx_maxmatch} || 10;
	my $nLz = int ($totmatch/$pgsz);
	if($totmatch%$pgsz >0) {
		$nLz ++;
	}
	print $mf->{siteidx_header};
 print qq(
<table width="82%" border="0" height="92" cellpadding="0" cellspacing="0">
 <tr> 
 <td rowspan="2" height="76" valign="bottom" width="27%">
<a href="http://netbula.com">
<img border="0" src="$self->{img_top}/search_logo.jpg" width="185" height="60" align="bottom">
</a>
</td>
 <td height="14" bgcolor="#FFFFFF" colspan="2" valign="bottom"><img src="$self->{img_top}/hline_mblue.gif" width="100%" height="3"></td>
 </tr>
 <tr> 
 <form action="$self->{cgi}" method="GET">
 <td width="42%" height="40" bgcolor="#CC9900" valign="middle"> 
	\&nbsp;
 <input type="text" class="inputfields" name="tK" value="$line">
 <input type=hidden value=searchsite name="pwsearchcmd">
 <input class="buttonstyle" type=submit value="Search" name="x">
 </td>
 </form>
 <td width="31%" height="40" valign="middle" bgcolor="#CC9900"><font color="#FFFFFF"><b>Search 
 powered by <a href="http://netbula.com/">PowerSearch</a></b></font> 
 </td>
 </tr>
 <tr> 
 <td colspan="3" valign="top" height="1"><img src="$self->{img_top}/hline_mblue.gif" width=100% height="3"> 
 </td>
 </tr>
</table>
);
	print $mf->{siteidx_banner};
	my $t = time() - $t0;
 my $idx=0;
	my ($sidx, $eidx);
	$sidx = $pgsz * $pagenum;
	$eidx = $sidx + $pgsz;
	$eidx = $totmatch  if $eidx > ($totmatch-1);
	my @cHaA;
	my $bQaA;
	my $fre = sVa::cIaA($line);
 for($bQaA =0; $bQaA <$nLz; $bQaA++) {
		my $i = $bQaA +1;
		if($bQaA == $pagenum) {
			push @cHaA, 	"<b>$i</b>";
		}else {
			push @cHaA, sVa::cUz($self->{cgi}."?pwsearchcmd=searchsite&tK=$fre&pagenum=$bQaA", $i);
		}
	} 
	for(@files) {
		my $filename;
		my $score;
		my $title;
		my $count = int  @files;
		print "<!--$t seconds -->\n";
		print "<ul>";
 my %shownf;
		my ($i, $flist) = @$_;
		my $topdir = $mf->{siteidx_topdir};
		my $topurl = $mf->{"siteidx_url$i"};
 last if $idx >= $eidx;
		for $k( sort { $b->{score} <=>  $a->{score} } @$flist) {
			$idx ++;
			if ($idx-1<$sidx ) {
				next;
 } 
 	last if $idx-1 >= $eidx;
			$filename = $k->{filename};
			if($method eq 'file') {
				$filename =~ s/^$topdir//;
				$filename =~ s/^\///;
			}
			$score = $k->{score};
			my ($title, $abs, $chk, $sz, $lmt) = split("\t", $k->{title});
			$title =~ s/($line)/<b>$1<\/b>/ig;
			$abs=~ s/($line)/<b>$1<\/b>/gi;
			my $url = dDa::eAa($topurl, $filename);
 next if $shownf{$url};
 $shownf{$url} = 1;
			$title= $url if not $title;
#x2
 print $abs, " <b>....</b><br>";
			$sz = $sz /1024;
		        print qq(<font color=green size=1>$url -- ), sprintf("%.2fK", $sz), "-- $lmt</font>";	
			print "</li><p>";
			
		}
		print "</ul>";
		print "$totmatch matches found. Showing ", scalar(keys %shownf), " matches\n";
	}
 if(not scalar(@files)) {
		print "No matches found.\n";

 }else {
		print "<p>Page ", join(" ", @cHaA);
	}
	print "Error: ", $search->errstr, "\n" if $err;
 print "</td></tr></table>";

	print qq(
<table width="82%" border="0" height="92" cellpadding="1" cellspacing="0">
 <tr> 
 <td rowspan="2" height="76" valign="bottom" width="27%">
<a href="http://netbula.com">
<img border="0" src="$self->{img_top}/search_logo.jpg" width="185" height="60" align="bottom">
</a>
</td>
 <td height="14" bgcolor="#FFFFFF" colspan="2" valign="bottom"><img src="$self->{img_top}/hline_mblue.gif" width="100%" height="3"></td>
 </tr>
 <tr> 
 <form action="$self->{cgi}">
 <td height="40" bgcolor="#CC9900" valign="middle">  \&nbsp;
 <input type="text" name="tK" class="inputfields">
 <input type=hidden value=searchsite name="pwsearchcmd">
 <input class="buttonstyle" type=submit value="Next search" name=x>
 </td>
 </form>
 <td height="40" valign="middle" bgcolor="#CC9900"><font color="#FFFFFF"><b>
 <a href="http://netbula.com/">PowerSearch</a></b></font> 
 </td>
 </tr>
 <tr> 
 <td colspan="3" valign="top" height="1"><img src="$self->{img_top}/hline_mblue.gif" width=100% height="3"> 
 </td>
 </tr>
</table>
<p>&nbsp;</p>
);
	print $mf->{siteidx_footer};
	$self->qPa($mf);
}

1;
1;
# end of qWa::fAa
