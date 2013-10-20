# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package qWa;

#line 95 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/qWa/new.al)"
sub new {
 my ($type, $argh) = @_;
 my $self = {};
 $self->{siteidx}= $argh->{siteidx};
 $self->{siteidxcfg}= $argh->{siteidxcfg};
 $self->{cgi}= $argh->{cgi};
 $self->{cgi_full}= $argh->{cgi_full};
 $self->{img_top} = $argh->{img_top};
 $self->{input} = $argh->{input};
 $self->{homeurl} = $argh->{homeurl};
 return bless $self, $type;
}

# end of qWa::new
1;
