# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 235 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/gKaA.al)"
sub gKaA {
 my ($self, $iS,  $entry) = @_;
 return if $entry->{fI} <=0;
 if($iS->{allow_subcat} && (not defined($entry->{scat})) && $iS->{scat_fix} ne "") { 
		$entry->{scat} = $iS->{scat_fix};
 } 
 my $aI = $self;
 for( @{$aI->{bE}}) {
	if($_->{fI} eq $entry->{jE}) {
 		push @{$_->{bE}}, $entry;
		return;
	}
 }
 push @{$aI->{bE}}, $entry;
}

# end of lB::gKaA
1;
