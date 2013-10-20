# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 6978 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/iXz.al)"
sub iXz{
 my $gV = $abmain::gJ{gV};
 my $inline = $abmain::gJ{aO};
 $iS->cR();
 if($iS->{aWz}) {
 	$iS->{aGz}=1;
 	$iS->{aIz}=0;
 $iS->aQz();
 }

 $iS->yIz(\%abmain::gJ, qw(hG aO mJ mAz iWz lVz rP));

 my ($lfile, $iZz, $aK, $jBz);

 $aK = $abmain::gJ{aK}; 
 $iZz = $abmain::gJ{iZz}; 
 $lfile = $gV? $iS->nDz('archlist'): $iS->nDz('msglist');
 my $e = $iS->pO($aK, $lfile, 1);
 $iS->{collapse_age} = 0;
 
 my $jCz = new lB; 
 push @{$jCz->{bE}}, $iS->{dA}->{$aK};
 sVa::gYaA "Content-type: text/html\n\n";
 $iS->eMaA( [qw(other_header other_footer)]);
 print qq(<html><head><title>where</title>$iS->{sAz}$iS->{other_header});
 
 print "\n", $iS->yHz($gV), "\n" if $iS->{ySz};
 $iS->{fDz} = 'undef';
 my $cmdbar = $iS->bHa(1, $gV, 1);
 print qq(<div class="ABMSGAREA">);
 print "\n$cmdbar\n";
 $jCz->jN(iS=>$iS, nA=>\*STDOUT, jK=>($inline?0:-1), hO=>0, gV=>$gV, iZz=>$iZz, 
		jAz=>($inline?0:1), kQz=>$abmain::gJ{kQz}, pub=>($jCz->{to} eq "")?'p':'v');
 print qq#<P><hr width="$iS->{cYz}"><p>@{[$iS->dRz($gV)]}#;
 print '&nbsp;' x 5;
 print qq@<a href="javascript:history.go(-1)">$iS->{back_word}</a></div>$iS->{other_footer}@;

};

# end of abmain::iXz
1;
