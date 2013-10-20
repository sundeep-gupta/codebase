# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8931 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/cCz.al)"
sub cCz {
 my ($self, $wW, $name, $body, $pt, $cat, $attachs) = @_;
 $self->cR() if not $self->{_noreload_cfg};
 my $title = $self->{name};
	my $gP = $self->iU();
	my $nM = @{$self->{pC}};
 my $iphex = abmain::bW($ENV{'REMOTE_ADDR'}); 
 my $bXz = $self->{bXz} = {};
 my $idx = int rand() * $nM;
 $bXz->{name} = $name;
 $bXz->{wW} = $wW;
 $bXz->{body}= $body;
 $bXz->{url}="http://netbula.com/anyboard";
 $bXz->{url_title}="AnyBoard";
 $bR =$gP;
 $pF = 0;
 if($nM >0) {
 $idx = -1 if rand() < 0.15;
 }
	$aI = $self->{pC}->[$idx] if $idx >=0 ;
 if($idx >=0 && $aI) {
 $pF = $aI->{fI} ;
 $bR=$aI->{aK};
 }
 for(@$attachs) {
 		my $fattach = $_;
		next if not $_->[0];
 		my $cA = $self->cPz($fattach->[0]);
 		open(kE, ">$cA" ) or next;
 		binmode kE;
 		print kE $fattach->[1];
 		close kE;
 }
 
 if($self->{aWz}) {
		$self->vHz($gP);
	}
 
	$self->hGa(aK=>$bR, jE=>$pF, fI=> $gP, wW=>$wW,hC=>$name, 
 mM=>$pt, size=>length($body), pQ=>abmain::bW($ENV{'REMOTE_ADDR'}), scat=>$cat, kRa=>$abmain::VERSION||8); 
	$self->kA(1,1);
 
}

# end of jW::cCz
1;
