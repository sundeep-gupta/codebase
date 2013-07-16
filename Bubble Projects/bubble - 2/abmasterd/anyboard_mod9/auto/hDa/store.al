# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package hDa;

#line 90 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/hDa/store.al)"
sub store{
	my ($self, $file) = @_;
	$file = $self->{file} if not $file;
	local *F;
	open F, ">$file" or return;
	$self->aNa(\*F);
	close F;

} 

# end of hDa::store
1;
