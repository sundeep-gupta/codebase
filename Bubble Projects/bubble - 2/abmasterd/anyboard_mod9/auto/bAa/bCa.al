# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 257 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/bCa.al)"
sub bCa{
 my ($self, $v, $enc)  = @_;
 $v = $self->{val} if $v eq "";
 my $t = $self->{type};
 if(($t eq 'file' || $t eq 'ifile') && ref($v) eq 'ARRAY') {
 	$v = $v->[0];
 }elsif($t eq 'kAa' || $t eq 'checkbox') {
 	my @vs = split "\0", $v;
 	$v = join("\t", @vs);
 }
 $v = sVa::wS($v) if $enc;
 return $v;
}   

# end of bAa::bCa
1;
