# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8063 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fTa.al)"
sub fTa{
 my ($self, $where, $uf, $maxintv) = @_;
 my $chatuf = $uf || $self->nDz('onlineusr');
 $maxintv=900 if not $maxintv;
 my $t = time();
 my $to = $t -$maxintv;
 my @ulist=();
 my %namtrack=();
 my $linesref = $bYaA->new($chatuf, {schema=>"AbOnlineU", paths=>$self->dHaA($chatuf) })->iQa({noerr=>1} );
 my $l;
 while($l = pop @$linesref) {
		my ($n, $in, $t0, $addr, $loc, $fn, $track) = @$l;
		next if $t0 < $to;
		next if not $in;
 next if $where && $in ne $where;
		$self->fZz(lc($n)) if  (not $uf) && (not exists $self->{gFz}->{lc($n)});
		next if $where ne "Chat" and $self->{gFz}->{lc($n)}->[10];
 push @ulist,  [$n, $in, sprintf("%.2fmin", ($t-$t0)/60), $addr, abmain::cUz($loc, $fn||$loc), $track];
 }
 my @ths=("User", "Action", "Time", "IP", "Location", "Track");
 return (\@ulist, [jW::mJa($self->{cfg_head_font}, @ths)]);
}

# end of jW::fTa
1;
