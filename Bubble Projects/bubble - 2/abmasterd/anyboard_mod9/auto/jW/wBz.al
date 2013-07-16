# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5074 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/wBz.al)"
sub wBz {
 my ($self, $nA, $showdel) = @_;
 $self->cR();
 my $lnkidx = $self->nDz('links');
 my $linesref = $bYaA->new($lnkidx, {schema=>"AbLinks", paths=>$self->dHaA($lnkidx) })->iQa({noerr=>1} );
 
 $self->eMaA( [qw(other_header other_footer lnk_page_banner lnk_page_bbanner)]);

 print $nA "<html><head>", $self->{sAz},
 "<title>$self->{name} related links</title>";
 print $nA $self->{other_header},
 $self->{lnk_page_banner};

 print $nA $self->{lnk_vsep};
 print $nA "<UL CLASSID=ABLINKS>\n";
 local $_;
 while ($_ = pop @$linesref) {
 my ($lid, $lsub, $lurl, $lcat, $lauthor, $ltime, $desc)= @$_;
 print $nA "<LI>", abmain::cUz($lurl, $lsub), $self->{lnk_sd_sep}, $desc;
 if($showdel) {
 	print $nA '&nbsp;' x 5;
 	print $nA "".abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=uOz;lnkid=$lid", "$self->{lnk_del_word}");
 }
 
 }
 print $nA "</UL>";
 print $nA $self->{lnk_page_bbanner},
 abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=wMz;adm=1", "$self->{lnk_adm_word}"),
	 '&nbsp;' x 4,
 	 abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=uNz", "$self->{lnk_add_word}"),
 $self->{other_footer};
 close $nA;

}

# end of jW::wBz
1;
