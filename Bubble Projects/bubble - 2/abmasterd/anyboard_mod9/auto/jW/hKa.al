# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8629 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/hKa.al)"
sub hKa {
 my ($self, $vH) = @_;
 return if not $vH->{to};
 for my $to (split /\s*,\s*/, $vH->{to}) {
 	my $f = $self->bJa($to, 'msg');
 	$vH->store($self, $f);
 }
}

# end of jW::hKa
1;
