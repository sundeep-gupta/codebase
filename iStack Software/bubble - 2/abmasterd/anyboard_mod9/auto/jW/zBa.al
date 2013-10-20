# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7565 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/zBa.al)"
sub zBa{
 my ($self, $cG, $suf, $one) = @_;
 
 if($one) {
		my $msg= zDa->new('AbMsgList');
		my $paths = $self->zOa('');
		my $p = $paths->[0];
		$msg->aPaA("where realm =? and msg_no=?", [$p, $cG]);
 	$self->{ratings2}->{$cG}= join("\t", $msg->{rate}, $msg->{cnt}, $msg->{viscnt}, $msg->{fpos}, undef, $msg->{readers});
		return 1;
		
 }
 1;
}

# end of jW::zBa
1;
