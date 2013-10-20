# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 62 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/zRz.al)"
sub zRz {
 my ($self, @parts) = @_;
 for(@parts) {
 	push @{$self->{parts}}, $_;
	next if not $_->{eJz};
	$self->{parthash}->{$_->{eJz}} = $_ if $_->{eJz};
 }
}

# end of dZz::zRz
1;
