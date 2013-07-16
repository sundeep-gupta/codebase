# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2473 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/oV.al)"
sub oV{
 my ($self, $entry, $in, $for_arch) = @_;
 my $aline = $self->yO($entry->{fI});
 $aline =~ s/\?cmd=get\&/\?cmd=geta\&/ if $for_arch;
 $aline =~ s/\?cmd=get;/\?cmd=geta;/ if $for_arch;
 my $yH = lB->new($entry->{aK}, 0, $entry->{jE});
 my $jZz = lB->new($entry->{aK}, 0, $entry->{aK});
 my $yW = $yH->nH($self, $in, $for_arch);
 my $topurl = $jZz->nH($self, $in, $for_arch);
 my $kGz = abmain::cUz($topurl, $self->{top_word}) ||'&nbsp;';
 my $kW;
 my $jUz = $entry->{xE};
 if(!$for_arch && ( $self->{gL} ne "1" && $self->{gL} ne "true") && ($jUz & 4)==0 ) {
	$kW=abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=follow;fu=$entry->{fI}&zu=$entry->{aK};scat=$entry->{scat};upldcnt=$self->{def_extra_uploads}", $self->{uI});
 }
 my $kI= qq/<a href="$yW">/;
 my $tO = $self->dRz($for_arch);
 my $jYz = $self->{msg_sep1};
 my $name = $self->fGz($entry->{hC}, 'fEz');
 my ($mbg, $mba, $mwid);
 $mbg=qq(bgcolor="$self->{bgmsgbar}") if $self->{bgmsgbar} ne "";
 $mwid= qq(width="$self->{mbar_width}") if $self->{mbar_width};
 $mba= $self->{zBz} if $self->{zBz};
 $name = "" if $self->{no_show_poster};
 $self->{sE} = "" if $self->{no_show_poster};
 $aline =~ s/$tV/$kI/;
 $aline =~ s/$gVz/$self->{sJ}/;
 $aline =~ s/$gWz/$self->{sE}/;
 $aline =~ s/$tW/$kW/;
 $aline =~ s/$gTz/$tO/;
 $aline =~ s/$top_tag/$kGz/;
 $aline =~ s/$gXz/$name/;
 $aline =~ s/$gUz/$jYz/;
 $aline =~ s/$mbar_width_tag/$mwid/;
 $aline =~ s/$mbar_bg_tag/$mbg/;
 $aline =~ s/$zAz/$mba/;
 $self->fZa(\$aline); 
 return $aline;
}

# end of jW::oV
1;
