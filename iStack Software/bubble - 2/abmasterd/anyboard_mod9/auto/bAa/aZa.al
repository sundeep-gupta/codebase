# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 162 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/aZa.al)"
sub aZa{
 my ($self, $vform, $k) = @_;
 if($self->{type} eq 'date' || $self->{type} eq 'time') {
 	$self->{val} = xUz($vform, $k||$self->{name});
 	return $self->{val};
 }else {
 	return $self->{val} = $vform->{$k||$self->{name}};
 }
}

# end of bAa::aZa
1;
