# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 124 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/aNa.al)"
sub aNa{
 my ($self, $nA, $new_bd) = @_;
 unless (@{$self->{parts}}) {
 if($self->{head}->{'content-type'}) {
 print $nA qq(Content-type: $self->{head}->{'content-type'}\n);
 }
 if($self->{eJz}) {
 print $nA qq(Content-disposition: form-data; name=$self->{eJz}\n);
 }
 print $nA "\n";
 print $nA $self->nDa();
 return;
 }
 if($new_bd || !$self->{eOz}) {
 	  my $r = rand();
 $r =~ s/\./_/g;
 $self->{eOz} = "YXASASA".time().$r;
 }
 print $nA qq(Content-type: multipart/form-data; boundary=$self->{eOz}\n);
 if($self->{eJz}) {
 print $nA qq(Content-disposition: form-data; name=$self->{eJz}\n);
 }
 if($self->{head}->{'content-disposition'}) {
 
 }
 for(@{$self->{parts}}) {
	next if not $_;
	print $nA "\n--$self->{eOz}\n";
 $_->aNa($nA, $new_bd);
 }
 print $nA "\n--$self->{eOz}--\n";
}

# end of dZz::aNa
1;
