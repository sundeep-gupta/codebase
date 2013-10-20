# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5108 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/init_msg_mac_list.al)"
sub init_msg_mac_list{
	my ($self) = @_;
	return if $self->{_inited_msg_mac_list};
	my $txt = join(" ", $self->{mbar_layout}, $self->{mbbar_layout}, $self->{message_page_layout});
	study $txt;
	for my $k (@jW::gLa, @jW::mbar_tags) {
		$self->{_msg_mac_list}->{$k} =1 if $txt =~ /$k/;
	}
	$self->{_inited_msg_mac_list} =1;
	
}

# end of jW::init_msg_mac_list
1;
