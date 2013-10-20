# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2539 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/eEaA.al)"
sub eEaA {
 my ($self, $fI,  $eS) = @_;
 $eS =  $self->nDz('msglist') unless($eS);
 my $vH;
 my $top;

 $vH = lB->new($fI, $fI, $fI);
 if($vH->load($self)) {
 }
 my $allinesref = 
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })
	->iQa({noerr=>1, filter=>sub { $_[0]->[0] == $vH->{aK}; }, where=>"tmno=$vH->{aK}" } );

 my @entarr;
 for(@$allinesref)
 {
 my $entry = lB->new (@$_);
 $vH = $entry if $entry->{fI} == $fI;
 push @entarr, $entry;
 }
 $self->lN(\@entarr);
 my @childs;
 $self->jP($fI, \@childs);
 my $wD = join(",", map {$_->{to}} @childs);
 return $wD;
}

# end of jW::eEaA
1;
