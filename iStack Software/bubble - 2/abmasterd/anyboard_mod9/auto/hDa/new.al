# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package hDa;

#line 13 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/hDa/new.al)"
sub new {
	my $type = shift;
	my $self = {};
	@{$self}{@fs} = @_;
	$self->{entry_hash} = {}; 
	$self->{jSa} = 0;
	bless $self, $type;
	if($self->{file} && -r $self->{file}) {
		$self->load();
	}
	return $self;
}

# end of hDa::new
1;
