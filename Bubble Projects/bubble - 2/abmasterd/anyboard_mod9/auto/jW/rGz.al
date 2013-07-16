# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7967 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/rGz.al)"
sub rGz {
 my ($self, $qQz, $ans) = @_;
 my $pp = $self->qZz($qQz);

 $self->cJ($pp, \@abmain::qSz);
 abmain::error('deny', "Poll not activated!") if $self->{rBz};
 if ($self->{pollreqlog}){ 
 	$self->gCz();
 }
 if($self->{fVa}) {
		my @ans = split "\0", $ans;
		$ans = join(" ", @ans) if @ans;
 }
 $self->gOaA();

 my $domain;
 $domain=  abmain::lWz("",1) if $self->{qVz};
 abmain::error('deny') if $self->{rIz} && not $domain ;

 my $pd = $self->rJz($qQz);
 if($self->{qWz}) {
 	    my $jKa =  $bYaA->new($pd, {schema=>"AbVotes", paths=>$self->zOa($qQz) })->iQa({noerr=>1, where=>"raddr='$ENV{REMOTE_ADDR}' and poll_id='$qQz'"});
 for my $row(@$jKa) {
 my $pQ = $row->[2];
 abmain::error('inval', "Duplicated vote detected") if $pQ eq $ENV{REMOTE_ADDR};
 }
 }
 
 $bYaA->new($pd, {schema=>"AbVotes", paths=>$self->zOa($qQz)})->iSa(
 [$ans, time(), $ENV{REMOTE_ADDR}, $domain,  $self->{fTz}->{name}, $abmain::ab_track, $qQz]
 );
 if( (stat($self->qYz($qQz)))[9] < time() - 30 || $abmain::use_sql ) {
 	$self->rAz($qQz); 
 		$self->rPz();
 }
}

# end of jW::rGz
1;
