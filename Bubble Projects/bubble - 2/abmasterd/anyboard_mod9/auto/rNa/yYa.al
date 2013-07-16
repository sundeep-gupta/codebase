# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 1335 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/yYa.al)"
sub yYa{
 my ($self, $input) = @_;
 my $tn = $input->{tmpname};
 my $xZa = $input->{xZa};
 error("miss", "No template selected")  if $tn eq "";
 error("inval", "No form selected")  if $xZa eq "";
 my $def = $self->ySa($tn, "def");
 my $fmt = $self->ySa($tn, "fmt");
 my $mydef = $self->uFa($xZa, "def");
 my $myfmt = $self->uFa($xZa, "fmt");
 sVa::rSa($def, $mydef);
 sVa::rSa($fmt, $myfmt);
 $self->rVa($xZa);
}

# end of rNa::yYa
1;
