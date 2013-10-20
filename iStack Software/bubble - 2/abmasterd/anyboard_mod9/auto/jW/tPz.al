# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4986 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/tPz.al)"
sub tPz{
 my ($self, $sstamp, $mode, $pat) = @_;
 my $edir = $self->nDz('evedir');
 my $eidx = abmain::kZz($edir, "event.idx");
 my $ecache = abmain::kZz($edir, "event.cac");
 $mode = 'tab' if not $mode;
 my $omode = $mode eq 'tab'? 'list' : 'tab';

 if($sstamp eq "") {
 my $iN = time();
 $sstamp = sVa::bAaA($iN,6);	
 }
 $sstamp = substr($sstamp, 0, 6);
 $sstamp .="00000000";

 my @rows;
 my ($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst);
 if($sstamp =~ /(\d\d\d\d)(\d\d)(\d\d)\d{6}/) {
		$year = $1;
		$mon = $2;
 }else {
	    	($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst) = localtime(time);
		$year +=1900;
		$mon +=1;
 } 
 my $itemhash;

 my $linesref = $bYaA->new($eidx, {schema=>"AbEveIndex", paths=>$self->zOa('eve')})->iQa({noerr=>1, where=>"start_time>'$sstamp'"} );
 my @eves;
 for(@$linesref) {
 next if $pat && not join (" ", @$_) =~ /$pat/i;
 my ($eid, $esub, $etime, $eorg, $eauthor, $ct, $modt)= @$_;
 next if ($sstamp && ($etime cmp $sstamp) <0);
 next if not $eid;
 next if not $esub;
 push @eves, [$eid, $esub, $etime, $eorg, $eauthor, $ct, $modt];
	   $itemhash->{substr($etime, 0, 8)} .= sVa::cUz("#$eid", $esub). "<br/>";
 }
 my @eves_sorted = sort { $a->[2] cmp $b->[2] } @eves;
 my @bgs=($self->{uQz}, $self->{uRz});

 sVa::gYaA "Content-type: text/html\n\n";
 $self->eMaA( [qw(other_header other_footer eve_page_top_banner eve_page_bottom_banner)]);
 print qq(<html><head>\n$self->{sAz}\n);
 print $self->{other_header};
 print $self->{eve_page_top_banner};
 print $self->{uGz};
 my $addel =  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=eveform", $self->{eve_add_word});
 my $viewol =  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tVz;mode=$omode", $omode eq 'tab'? "Calendar view": "List view");
 print qq(<a name="EVETOP">\&nbsp;</a>);
 my @ths =($self->{tNz}, "Topic", $self->{uVz}, "Comments");
 my $i=0;
 my $comment;
 for(@eves_sorted) {
 $comment="";
 if($_->[6]) {
 $comment = "Modified at ".abmain::dU('SHORT', $_->[6], 'oP');
 }else{
 $comment = "Created at ".abmain::dU('SHORT', $_->[5], 'oP');
 }
 
 push @rows, [sVa::aKaA($_->[2]), abmain::cUz("#$_->[0]", $_->[1]), $_->[3],  "<small>$comment</small>"];
 }
 my %attr = $self->oVa();
 if($mode eq 'tab') {
		my $prevt = sVa::eNaA($year, $mon, -1);
		my $nextt = sVa::eNaA($year, $mon, 1);
 	my $prevlnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tVz;mode=$mode;sstamp=$prevt", "Previous");
 	my $nextlnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tVz;mode=$mode;sstamp=$nextt", "Next");
 		my $cmdstr = join(" | ", $prevlnk, "<b>".sprintf("%d/%02d", $year, $mon). "</b>", $nextlnk, $viewol, $addel);
		print sVa::tQa($year, $mon, $itemhash, sub { $_[0];}, 
			$cmdstr,
			\%attr );
 }else {
 		my $cmdstr = join(" | ",  $viewol, $addel);
		print "<center>$cmdstr</center>";
 		print sVa::fMa(rows=>\@rows, ths=>\@ths, $self->oVa());
 }
 print $self->{uXz};
 for(@eves_sorted) {
 print qq(<a name="$_->[0]">\&nbsp;</a>);
	   print $self->uBz($_->[0]);
 print $self->{uLz};
 }
 print $self->{eve_page_bottom_banner};
 print $self->{other_footer};
 
}

# end of jW::tPz
1;
