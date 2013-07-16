# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7738 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/zFa.al)"
sub zFa{
 my ($self, $cG, $loc, $one) = @_;
	if($one) {
 	my @rata = split /\t/, $self->{ratings2}->{$cG};
		my $i;
		for($i=0; $i<6; $i++) {
			$rata[$i]= undef if not defined($rata[$i]);
		}
		my $msg= zDa->new('AbMsgList');
		my $paths = $self->zOa('');
		my $p = $paths->[0];
		$msg->aPaA("where realm =? and msg_no=?", [$p, $cG]);
		return 1;
 }
	return 1;
}

# end of jW::zFa
1;
