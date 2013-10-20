# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 28 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/zVz.al)"
sub zVz{
 my ($type, $name, $dataref, $ct, $file) = @_;
 my $self = {};
 $self->{gHz}= $dataref if $dataref;
 $self->{ePz}=0;
 $self->{eKz}=0;
 $self->{eLz} = 1;
 $self->{parts}=[];
 $self->{head}={};
 $self->{head}->{'content-type'} = "$ct";
 $self->{eJz} = $name;
 $self->{eFz} = $file;
 return bless $self, $type;
}

# end of dZz::zVz
1;
