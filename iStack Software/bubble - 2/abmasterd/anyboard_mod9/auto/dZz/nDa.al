# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 195 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/nDa.al)"
sub nDa{
 my $self = shift;
 return $self->{eAz} if $self->{eAz};
 my @data;
 my $i=$self->{eKz};
 if($self->{head}->{'content-transfer-encoding'} =~ /^base64/i) {
 return mIa($self->{gHz}, $i, $self->{eLz});

 }elsif($self->{head}->{'content-transfer-encoding'} =~ /^quoted/i) {
 for(;$i<$self->{eLz}; $i++) {
 push @data, oZa($self->{gHz}->[$i]);
 }
 }else {
 for(;$i<$self->{eLz}; $i++) {
 if($i==($self->{eLz}-1)){
 $self->{gHz}->[$i] =~ s/\r\n$//;
 $self->{gHz}->[$i] =~ s/\n$//;
 }
 push @data, $self->{gHz}->[$i];
 }
 }
 
 $self->{eAz} = join('', @data);
 return $self->{eAz};
}

# end of dZz::nDa
1;
