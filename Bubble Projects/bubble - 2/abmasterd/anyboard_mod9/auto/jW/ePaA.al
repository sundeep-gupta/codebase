# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7890 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/ePaA.al)"
sub ePaA{
 my ($self, $cG) = @_;
	my $msg= zDa->new('AbMsgList');
	my $paths = $self->zOa('');
	my $p = $paths->[0];
	$msg->aPaA("where realm =? and msg_no=?", [$p, $cG]);
	$msg->{readers}="";
	$msg->rRa(["readers"],"where realm =? and msg_no=?", [$p, $cG]);
}

# end of jW::ePaA
1;
