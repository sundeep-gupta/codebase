# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7900 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dXaA.al)"
sub dXaA{
 my ($self, $cG, $vcnt, $readers) = @_;
	my $msg= zDa->new('AbMsgList');
	my $paths = $self->zOa('');
	my $p = $paths->[0];
	$msg->aPaA("where realm =? and msg_no=?", [$p, $cG]);
	$msg->{readers}= $readers;
	$msg->{viscnt}=$vcnt;
	$msg->rRa(["readers", "viscnt"],"where realm =? and msg_no=?", [$p, $cG]);
}

# end of jW::dXaA
1;
