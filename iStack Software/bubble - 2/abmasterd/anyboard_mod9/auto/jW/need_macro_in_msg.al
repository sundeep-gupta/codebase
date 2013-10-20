# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5120 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/need_macro_in_msg.al)"
sub need_macro_in_msg {
	my ($self, $mac) = @_;
	if(not $self->{_inited_msg_mac_list}) {
		$self->init_msg_mac_list();
	}
	return $self->{_msg_mac_list}->{$mac};
}

# end of jW::need_macro_in_msg
1;
