# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 6252 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/wIz.al)"
sub wIz{
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->tGz();  
 $iS->{eveid} = $abmain::gJ{eveid};
 my $linesref = $bYaA->new(abmain::kZz($iS->nDz('evedir'), "$iS->{eveid}.sig"), {schema=>"AbEveSignup", paths=>$iS->zOa($iS->{eveid}) })->iQa({noerr=>1, where=>"eveid=$iS->{eveid}"} );
 my $eveform = aLa->new("eve", \@abmain::uHz);
 my $ef = abmain::kZz($iS->nDz('evedir'), "$abmain::gJ{eveid}.eve"); 
 $eveform->load($ef);

 my $i=0;
 my %signhash;
 for(@$linesref) {
 my ($n, $t, $inf, $com, $eveid) = @$_;
 $signhash{$n} = [$t, $inf, $com];
 }
 my $cnt = keys %signhash;
 sVa::gYaA "Content-type: text/html\n\n";
 $iS->eMaA( [qw(other_header other_footer)]);
 print "<html><head><title>Sign up list for $eveform->{eve_subject}</title>$iS->{sAz}$iS->{other_header}";
 print "<h2>$cnt members have signed up</h2>";
 my @ths = ($iS->{sH}, "Time", "Contact information", "Comments");
 my @rows;
 for(sort keys %signhash) {
 my $v=$signhash{$_};
 push @rows, [$_, abmain::dU('SHORT', $v->[0], 'oP'), $v->[1], $v->[2]];
 }
 print sVa::fMa(rows=>\@rows, ths=>\@ths, $iS->oVa());
 print "</table>$iS->{other_footer}";
}

# end of abmain::wIz
1;
