# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4946 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gFaA.al)"
sub gFaA{
 my ($self)= @_;
 my $tagt = "_ava_trans$self->{eD}"; 
 return $self->{$tagt} if $self->{$tagt};
 my @tags = split ("\n", $self->{avatar_trans});
 my $trans={};
 for(@tags) {
 my ($k, $v) = abmain::oPa($_);
 next if not $k;
	$trans->{$k} = $v;
 }   
 return $self->{$tagt} = $trans;

}

# end of jW::gFaA
1;
