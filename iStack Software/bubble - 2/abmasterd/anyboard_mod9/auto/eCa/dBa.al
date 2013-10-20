# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 544 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/dBa.al)"
sub dBa {
	my ($shared, $dir, $kDa) = @_;
	my $kJa = $shared->{kJa};
	opendir D, $dir;
	my @files = readdir D;
	close D;
	my $e;
	my $count = 0;
	my $exclude_re = $shared->{url_exclude};
	my $exclude_re2 = $shared->{url_exclude2};
	for $e(@files) {
		if ($e =~ /^$exclude_re$/o) {
			next;
 }
		if ($e =~ /^$exclude_re2$/o) {
			next;
 }
		next if $e =~ /^\.\.?/;
		$dir =~ s!/$!!;
		my $path = $dir."/".$e;
		if (-d $path) {
			unless ($kJa) {
				next if -l $path ;
			}
			$count += dBa($shared,$path, $kDa);
		}
		elsif (-f _ ) {
			my $filemask = $shared->{filemask};
			if ($filemask) {
				next unless $e =~ $filemask;
			}
			unless ($kDa) {
				my $mt = (stat($path))[9];
				my $lmt = sVa::dU('LONG', $mt, 'oP');
				dLa($shared,$path, $lmt);
			}
			$count ++;
		}
		return if $shared->{max_entry} > 0 && $shared->{filecount} > $shared->{max_entry};
	}
	return if $shared->{max_entry} > 0 && $shared->{filecount} > $shared->{max_entry};
	return $count;
}

# end of eCa::dBa
1;
