# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1142 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/nextseq.al)"
sub nextseq{
 my ($seqdir, $max, $seqidx) = @_;
 my $cLaA= kZz($seqdir, "data.txt$seqidx"); 
 oF(LOCK_EX, 1, $seqdir);
 my $gP;
 if(open(NUMBER,"$cLaA")) {
 	$gP = <NUMBER>;
 	close(NUMBER);
 }
 my $inc;
 $inc = $sVa::seqinc>0 ? $sVa::seqinc : 1;
 $gP = 1 if($gP<=0);
 $gP = $max  if $gP < $max;
 $gP =  ($gP == 99999999)?  1 : $gP+$inc;
 open(NUM,">$cLaA") || error('sys', "On writing $cLaA: $!");
 print NUM "$gP";
 close(NUM);
 pG(1);
 return $gP;

}

# end of sVa::nextseq
1;
