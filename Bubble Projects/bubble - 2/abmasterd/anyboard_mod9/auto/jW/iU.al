# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 10223 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/iU.al)"
sub iU {
 my ($self, $max, $seqd) = @_;
 my $seqdir = $seqd || $self->{seqdir};
 my $cLaA = $self->nDz('cLaA', $seqdir);
 
 $self->oF(LOCK_EX, 1, $seqdir);
 if(open(NUMBER,"$cLaA")) {
 	$gP = <NUMBER>;
 	close(NUMBER);
 }
 $gP = 1 if($gP<=0);
 $gP = $max  if $gP < $max;
 my $r = int (rand()*100) || 1;
 $r = 1 if $gP <20 || not $jW::random_seq;
 $gP =  ($gP == 99999999)?  1 : $gP+$r;
 my $num2;
 if($gP == 1 ) {
 	if(open(NUMBER,"${cLaA}2")) {
 		$num2 = <NUMBER>;
 	$gP = $num2 + 5 if $num2>1;
 		close(NUMBER);
 }
 }
 open(NUM,">$cLaA") || abmain::error('sys', "On writing file $cLaA: $!");
 print NUM "$gP";
 close(NUM);
 open(NUM,">${cLaA}2") || abmain::error('sys', "On writing file $cLaA: $!");
 print NUM "$gP";
 close(NUM);
 $self->pG(1);
 return $gP;
}

1;
1;
# end of jW::iU
