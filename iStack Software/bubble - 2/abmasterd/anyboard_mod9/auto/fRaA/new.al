# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/fRaA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package fRaA;

#line 14 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/fRaA.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/fRaA/new.al)"
sub new {
 my ($type, $argh) = @_;
 my $self = {};
 $self->{cgi}= $argh->{cgi};
 $self->{cgi_full}= $argh->{cgi_full};
 $self->{icon_loc}= $argh->{icon_loc};
 $self->{agent}= $argh->{agent};
 $self->{input} = $argh->{input};
 $self->{homeurl} = $argh->{homeurl};
 return bless $self, $type;
}

# end of fRaA::new
1;
