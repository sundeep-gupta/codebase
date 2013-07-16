# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2155 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/eOaA.al)"
sub eOaA{
 my ($self) = @_;
 return 1 if not $self->{bUz};
 return 1 if $self->{passd} && $self->{passwd} ne $self->nDz('passdir');
 return 0;
}

# end of jW::eOaA
1;
