# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2527 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gB.al)"
sub gB{
 my ($self, $fI) = @_;

 my $entry = lB->new($fI, $fI, $fI);
 if($entry->load($self)) {
	return $entry->{body};
 }else {
 	my $aline = $self->yO($fI);
 	return ($aline =~ /<!--$fI\{-->(.*)\n<!--$fI\}-->/s)? $1: "";
 }
}

# end of jW::gB
1;
