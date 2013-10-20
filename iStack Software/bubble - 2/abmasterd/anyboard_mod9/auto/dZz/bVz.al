# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 319 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/bVz.al)"
sub bVz{
 my ($self) = @_;
 if($self->{head}->{'content-type'} =~ /multipart/i) {
 unless( ($self->{eOz})= $self->{head}->{'content-type'} =~ /boundary=\"([^"]*)\"/i ) {
 	($self->{eOz})= $self->{head}->{'content-type'} =~ /boundary=(\S+)/i;
 }
 $self->{eOz} =~ s/;.*$//;
 }
 if($self->{head}->{'content-disposition'} =~ /(inline|form-data|attachment);/i) {
 unless(($self->{eFz}) = $self->{head}->{'content-disposition'} =~ /\bfilename=\"([^"]*)\"/i){
 ($self->{eFz}) = $self->{head}->{'content-disposition'} =~ /\bfilename=(\S+)/i ;
 }
 $self->{eFz} =~ s/^.*(\\|\/)//g;
 unless(($self->{eJz})= $self->{head}->{'content-disposition'} =~ /\bname=\"([^"]*)\"/i){
 	($self->{eJz})= $self->{head}->{'content-disposition'} =~ /\bname=(\S+)/i ;
 }
 $self->{eJz} =~ s/;.*$//;
 }
 if($self->{head}->{'content-disposition'} =~ /inline;/i) {
	$self->{inline} = 1;
 }
}

# end of dZz::bVz
1;
