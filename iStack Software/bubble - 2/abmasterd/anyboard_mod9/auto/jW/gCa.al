# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2921 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gCa.al)"
sub gCa {
 my ($self, $aK, $hC) = @_;
 my $eS =  $self->nDz('msglist');
 my $db = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) });
 my $nM = $db->pXa();
 $self->{dI}= $nM;

 my $sidx = $nM - 100;
 my $tnopos = abmain::oTa(\@lB::mfs, 'aK');
 my $ptpos = abmain::oTa(\@lB::mfs, 'mM');
 my $posterpos = abmain::oTa(\@lB::mfs, 'hC');
 my $dayago = time() - 3600*24;
 my $privfilter;
 my $wh="";
 if(not $aK) {
 $privfilter = sub {
	    return $_[1] > $sidx || $_[0]->[$ptpos] > $dayago || lc($_[0]->[$posterpos]) eq $hC;
 };
 }else {
 $privfilter = sub {
	    return $_[1] > $sidx || $_[0]->[$ptpos] > $dayago || $_[0]->[$tnopos] == $aK || lc($_[0]->[$posterpos]) eq $hC;
 };
 }

 my $jKa = $db->iQa({filter=>$privfilter} ); 
 my ($fI, $entry);

 my @hS;
 for(@$jKa){
 $entry = lB->new (@$_);
 next if $entry->{fI} <=0;
 $jW::max_mno = $entry->{fI} if $entry->{fI} > $jW::max_mno;
 push @hS, $entry;
 }
 $self->lN(\@hS, undef, $aK); 
 1;
}

# end of jW::gCa
1;
