# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 340 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/zNz.al)"
sub zNz {
 my ($self, $f, $prefix)=@_;
 return if not $f;
 $f->[0] .= "${prefix}_" if $prefix;
 push @{$self->{zKz}->{jF}}, $f;
 $self->{zKz}->{bLa}->{$f->[0]} = bYa($f);
 $self->{zKz}->{bLa}->{$f->[0]}->{form} = $self;
 $self->{$f->[0]} = $f->[4];
}

# end of aLa::zNz
1;
