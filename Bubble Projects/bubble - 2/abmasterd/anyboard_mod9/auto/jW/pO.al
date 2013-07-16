# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2565 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/pO.al)"
sub pO {
 my ($self, $fI,  $eS, $thread, $yB, $get_tops) = @_;
 $eS =  $self->nDz('msglist') unless($eS);
 my $vH;
 my $top;

 $vH = lB->new($fI, $fI, $fI);
 if($vH->load($self)) {
 }else {
 		my $aB = $self->gN($fI);
 		open pK, "<$aB" or return;
 	while(<pK>) {
 	     if(/<!--X=([^\n]+)-->/) {
 		       $vH=  lB->new ( split /\t/, $1);
 		       $self->{dA}->{$vH->{fI}} = $vH;
		       last;
 	    }
 }
 close pK;
 }
 
 if($yB) {
 unless($vH->load($self)) {
 	$vH->{_data} = $self->yO($vH->{fI});
 }
 }
 
 return $vH unless($thread);

 my $allinesref;
 if(not $get_tops) {
 $allinesref = 
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })
	->iQa({noerr=>1, filter=>sub { $_[0]->[0] == $vH->{aK}; }, where=>"tmno=$vH->{aK}" } );
 }else {
 $allinesref = 
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })
	->iQa({noerr=>1, filter=>sub { $_[0]->[0] == $vH->{aK} || $_[0]->[1] ==0; }, where=>"tmno=$vH->{aK} or pmno=0" } );

 }

 my @entarr;
 for(@$allinesref)
 {
 my $entry = lB->new (@$_);
 if($yB) {
 unless($entry->load($self)) {
 	$entry->{_data} = $self->yO($entry->{fI});
 }
 }
 $vH = $entry if $entry->{fI} == $fI;
 #$self->{dA}->{$entry->{fI}} = $entry;
 #$self->{eN}->nB($self, $entry);
 push @entarr, $entry;
 }
 $self->lN(\@entarr);
 return $vH;
}

# end of jW::pO
1;
