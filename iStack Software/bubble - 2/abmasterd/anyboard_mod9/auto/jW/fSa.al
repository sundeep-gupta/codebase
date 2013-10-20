# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8085 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fSa.al)"
sub fSa{
 my ($self, $name, $where, $uf) = @_;
 my $chatuf = $uf || $self->nDz('onlineusr');
 my $maxintv=900;
 my $t = time();
 my $to = $t -$maxintv;
 $self->oF(LOCK_EX, 14);
 my $linesref = $bYaA->new($chatuf, {schema=>"AbOnlineU", paths=>$self->dHaA($chatuf) })->iQa({noerr=>1} );
 my @linesx=();
 my @ulist=();
 for(@$linesref) {
		my ($n, $in, $t0, $addr, $loc, $xO, $track) = @$_;
		next if $t0 < $to;
		next if not $in;
 next if lc($n) eq lc($name) && $in eq $where && $loc eq $self->fC();
		push @linesx, $_;
 }
 push @linesx, [$name, $where, $t,  $ENV{REMOTE_ADDR}, $self->fC(), $self->{name}, $abmain::ab_track];
 $bYaA->new($chatuf, {schema=>"AbOnlineU", paths=>$self->dHaA($chatuf) })->iRa(\@linesx);

 $self->pG(14);
 if($self->{publish_ulist} && $chatuf ne abmain::wTz('onlineusr')) {
		$self->fSa($name, $where, abmain::wTz('onlineusr'));
 } 
} 

# end of jW::fSa
1;
