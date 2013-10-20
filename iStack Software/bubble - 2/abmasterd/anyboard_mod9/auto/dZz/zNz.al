# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 50 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/zNz.al)"
sub zNz {
	my ($self, $name, $val, $type, $file) = @_;
 if($file && not $val) {
		if(open (F, $file)) {
			local $/=undef;
			$val = <F>;
			close F;
		}
	}
 $self->zRz( zVz dZz($name, [$val], $type||"text/plain", $file));
}

# end of dZz::zNz
1;
