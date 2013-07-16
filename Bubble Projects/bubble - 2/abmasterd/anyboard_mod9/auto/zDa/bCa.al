# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 229 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/bCa.al)"
sub bCa{
 my ($self) = @_;
 my $str = $self->{tb}.":\n";
 for(@{$self->{fields}}) {
	$str .= $_."=$self->{$_}\t";
 }
 $str;
}

# end of zDa::bCa
1;
