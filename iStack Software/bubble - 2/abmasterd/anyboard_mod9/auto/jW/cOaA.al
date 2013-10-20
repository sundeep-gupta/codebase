# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8584 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/cOaA.al)"
sub cOaA {
	my ($self, $cLaA, $to, $infohash) = @_;
 	my $f = $self->bJa($to, 'mbox');
	my $db = $bYaA->new($f, {schema=>"AbMsgBox", paths=>$self->dHaA($f), index=>5 });
	my $filter = sub { $_[0]->[0] == $cLaA && lc($_[0]->[1]) eq lc($to); };
	my $jKa = $db->iQa({noerr=>1, filter=>$filter, where=>qq(msg_no=$cLaA and rcptuid='$to') });
 	return  if not ($jKa && scalar(@$jKa));
 my $jRa = $jKa->[0];
	if(exists ($infohash->{read_time})) {
		$jRa->[9] = $infohash->{read_time};
 }
	if(exists ($infohash->{reply_time})) {
		$jRa->[10] = $infohash->{reply_time};
 }
	if(exists ($infohash->{modify_time})) {
		$jRa->[11] = $infohash->{modify_time};
 }
	if(exists ($infohash->{msg_subj})) {
		$jRa->[4] = $infohash->{msg_subj};
 }
	$db->jXa([$jRa]);
}

# end of jW::cOaA
1;
