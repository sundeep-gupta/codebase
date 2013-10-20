# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1913 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/tQa.al)"
sub tQa{
	my ($year, $month, $itemhash, $lnksub, $capt, $attr) = @_;
	require POSIX;
	my $y = $year - 1900;
	my $m = $month -1;
	my $d;
	my @monarr;

	my @weekarr= map{"\&nbsp;"} 0..6;
	my ($sec,$min,$hour,$mday0,$mon0,$year0,$mD,$bQ,$isdst) = localtime(time());
	for($d=1; $d<=33; $d++) {
		my $t = POSIX::mktime(0,0,0,$d, $m, $y);
		my ($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst) = localtime($t);
		my $tstamp = bAaA($t);
		my $ts = substr($tstamp, 0, 8);
		if($mon > $m || $year > $y){
			push @monarr, [@weekarr] if $mD != 0;
			last;
		}
		my $today=0;
		$today = 1 if ($year0 == $year && $mon==$mon0 && $nQ == $mday0);
		$nQ = "<b>$nQ</b>"if $today;
		my $lnk;
		if($lnksub) {
			$lnk = &$lnksub($nQ, $tstamp);
		}
		$weekarr[$mD] = ($lnk || $nQ);
		if($itemhash->{$ts}) {
			$weekarr[$mD] .="<br>".$itemhash->{$ts};
	        }
		if($today) {
			$weekarr[$mD] = [ $weekarr[$mD], 'class="TodayCell"'];
		}
		
		if($mD ==6) {
			push @monarr, [@weekarr];
			@weekarr= map{"\&nbsp;"} 0..6;
		}
	}
	return sVa::fMa(rows=>\@monarr, 
			ths=>["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
			capt=>$capt,
			$attr? %$attr: sVa::oVa(),
			);
}

# end of sVa::tQa
1;
