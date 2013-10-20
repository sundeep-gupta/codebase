# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 49 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/new.al)"
sub new {
 my $type = shift;
 my $self = {};
 @{$self}{@mfs} = @_;
 $self->{jE} = 0 if ($self->{jE}||0) == ($self->{fI}||0);
 $self->{bE} = [];
 $self->{to}=~ s/^\s+//;
 $self->{to}=~ s/\s+$//;
 $self->{to}=~ s/^,+$//;
 return bless $self, $type;
}

# end of lB::new
1;
