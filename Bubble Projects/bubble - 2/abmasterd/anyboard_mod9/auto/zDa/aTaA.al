# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 94 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aTaA.al)"
sub aTaA{
 my ($self, $fieldshash) = @_;
 my $k;
 for(keys %$fieldshash) {
 $k = lc($_);
 next if not exists $self->{$k};
 $self->{$k} = $fieldshash->{$_};
 }
}

# end of zDa::aTaA
1;
