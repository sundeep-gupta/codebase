# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8003 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/rAz.al)"
sub rAz {
 my ($self, $qQz) = @_;
 my $pp = $self->qZz($qQz);
 $self->cJ($pp, \@abmain::qSz);
 my $pd = $self->rJz($qQz);
 my $ps = $self->qYz($qQz);
 my %ans=();
 my $tot =0;
 my $jKa =  $bYaA->new($pd, {schema=>"AbVotes", paths=>$self->zOa($qQz) })->iQa({noerr=>1});
 for my $jRa (@$jKa) {
 next if $jRa->[0] eq '';
 my @myans = split " ", $jRa->[0];
 @myans = ($jRa->[0]) if not @myans;
 for(@myans) {	
 	$ans{$_}++;
 	$tot ++;
 }
 }
 open F, ">$ps" or abmain::error('sys', "On writing file $ps: $!");
 print F "total=$tot\n";
 for (keys %ans) {
 print F "$_=$ans{$_}\n";
 }
 close F;
 return $tot;
}

# end of jW::rAz
1;
