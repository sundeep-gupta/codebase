# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1419 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/info_block.al)"
sub info_block {
	my ($tit, $data) = @_;
	return qq(<table class="info"><tr><td class="title">$tit</td></tr><tr><td class="data">$data</td></tr></table>);
}

# end of sVa::info_block
1;
