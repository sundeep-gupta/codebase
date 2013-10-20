# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2766 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/wUz.al)"
sub wUz {
 my ($self, $kQz, $fast) = @_;
 my $cnt =0;
 my $t = 0;
 $kQz = lc($kQz);
 return (0, 0) if not $kQz;
 my $entry;
 if($fast) {
 for $entry (@{$self->{pC}}) {
 if ((lc($entry->{hC}) eq $kQz && $entry->{to}) || lc($entry->{to}) eq $kQz) {
 $cnt ++;
 $t = $entry->{mM} if $entry->{mM} > $t;
 }
 } 
 }else {
 my $eS =  $self->nDz('msglist');
 my $ppos = abmain::oTa(\@lB::mfs, 'hC');
 my $topos = abmain::oTa(\@lB::mfs, 'to');
 my $tpos = abmain::oTa(\@lB::mfs, 'mM');
 my $privfilter = sub { return (lc($_[0]->[$ppos]) eq $kQz && $_[0]->[$topos]) || jW::sFa($_[0]->[$topos],  $kQz) ; };
 
	my $linesref = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->iQa({noerr=>1, filter=>$privfilter, where=>"to_user is not NULL"});
	return if not $linesref;
 for(@$linesref) {
 $cnt ++;
 $t = $_->[$tpos] if $_->[$tpos] > $t;
 }
 }
 return ($cnt, int ((time()-$t)/60.));
}

# end of jW::wUz
1;
