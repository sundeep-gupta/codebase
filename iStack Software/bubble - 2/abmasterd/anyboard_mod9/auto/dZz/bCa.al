# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 82 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/bCa.al)"
sub bCa{
 my ($self, $new_bd) = @_;
 my @gHz;
 my @hlines;
 unless (@{$self->{parts}}) {
 if($self->{head}->{'content-type'}) {
 push @gHz, qq(Content-type: $self->{head}->{'content-type'}\n);
 }
 if($self->{eJz}) {
	     if($self->{eFz} ne "") {
 push @hlines, qq(Content-disposition: form-data; name=$self->{eJz}; filename="$self->{eFz}"\n);
 }else {
 push @hlines, qq(Content-disposition: form-data; name=$self->{eJz}\n);
 }
 }
 push @gHz, "\n";
 push @gHz, $self->nDa();
 return join("", @hlines, @gHz);
 }
 if($new_bd || !$self->{eOz}) {
 	  my $r = rand();
 $r =~ s/\./_/g;
 $self->{eOz} = "YXASASA".time().$r;
 }
 push @hlines, qq(Content-type: multipart/form-data; boundary=$self->{eOz}\n);
 if($self->{eJz}) {
 push @hlines, qq(Content-disposition: form-data; name=$self->{eJz}\n);
 }
 if($self->{head}->{'content-disposition'}) {
 
 }
 for(@{$self->{parts}}) {
	next if not $_;
	push @gHz, "\n--$self->{eOz}\n";
 push @gHz, $_->bCa($new_bd);
 }
 push @gHz, "\n--$self->{eOz}--\n";
 my $line = join("", @gHz);
 my $len = length($line);
 return join ("", @hlines, "Content-length: $len\n", $line);
}

# end of dZz::bCa
1;
