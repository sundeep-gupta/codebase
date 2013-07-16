# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 158 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/eEz.al)"
sub eEz {
 my $self = shift;
 my @data;
 for(my $i=$self->{ePz};$i<$self->{eKz}; $i++) {
 push @data, $self->{gHz}->[$i];
 }
 return join('', @data);
 
}

# end of dZz::eEz
1;
