# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 237 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/bDa.al)"
sub bDa {
 my ($self, $v)  = @_;
 $v = $self->{val} if $v eq "";
 my $t = $self->{type};

 if( ref($v) eq 'ARRAY') {
 	$v = $v->[0];
 }
 if($t eq 'date') {
	return sVa::aKaA($v, 'date');

 }elsif($t eq 'time') {
	return sVa::aKaA($v, 'time');
 }
 if($self->{aDa}) {
	return $self->{aDa}->($v);
 }
 return $self->bCa($v);
}

# end of bAa::bDa
1;
