# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 4919 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/aEz.al)"
sub aEz {
 $iS->cR();
 $iS->bI();
 my $filter=undef;

 
 my $hIz = $abmain::gJ{hIz};
 my $hJz = $abmain::gJ{hJz}||0;
 my $sti = time() - $hIz* 24 * 3600;
 $sti = -1 if not $hIz;
 my $eti = time() - $hJz* 24 * 3600;
 $filter = sub {$_[0]->[5]>=$sti && $_[0]->[5] <= $eti;};

 my $df = $iS->nDz('dmsglist');
 my $linesref = $bYaA->new($df, {index=>2, schema=>"AbMsgList", paths=>$iS->dHaA($df) })->iQa({noerr=>1, filter=>$filter});

 sVa::gYaA "Content-type: text/html\n\n";
 print qq(<html><head><title>Deletion records </title>$iS->{other_header}<center><h1>Deleted messages</h1></center>);
 print "$iS->{other_header}";
 my @ths = jW::mJa($iS->{cfg_head_font}, "Subject", "Author", "IP", "Size", "Message#", "Time");
 my @rows;
 for(@$linesref) {
 my @fields = @$_;
 next if ($fields[5] < $sti || $fields[5] > $eti);  
 push @rows, [ $fields[3], $fields[4], abmain::pT($fields[7]), $fields[6],
 $fields[2], abmain::dU('LONG', $fields[5], 'oP')
 ];
 }
 print sVa::fMa(ths=>\@ths, rows=>\@rows, $iS->oVa());
 print "$iS->{other_footer}";
}

# end of abmain::aEz
1;
