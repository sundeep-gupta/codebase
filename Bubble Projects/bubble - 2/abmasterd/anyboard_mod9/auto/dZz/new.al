# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 8 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/new.al)"
#IF_UT use SelfLoader;
#IF_UT 1;
#IF_UT __DATA__

sub new {
 my ($type, $lref, $ep) = @_;
 my $self = {};
 $self->{gHz}= $lref;
 $self->{ePz}=0;
 $self->{eKz}=0;
 if($lref) {
 	$self->{eLz} = $ep? $ep: scalar @$lref;
 }
 $self->{parts}=[];
 $self->{eOz}="";
 $self->{head}={};
 $self->{eCz}=0;
 return bless $self, $type;
}

# end of dZz::new
1;
