# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 88 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aEaA.al)"
sub aEaA{
 my ($self, $fields, $vals) = @_;
 $fields = $self->{fields} if not $fields;
 @$self{@$fields} = @$vals;
}

# end of zDa::aEaA
1;
