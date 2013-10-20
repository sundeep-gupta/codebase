# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4150 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dPz.al)"
sub dPz{
 my ($self, $gV) = @_;
 my $path = $gV? $self->dEz() : $self->dFz();
 my $iurl = $gV? $self->dCz() : $self->dKz();
 open FIDX, ">$path";
 print FIDX qq(<html><frameset $self->{dAz}>);
 my @frms = ( qq(<frame name="idx" src="$iurl">), qq(<frame name="MSGA" src="$self->{uE}">));
 if($self->{reverse_frame}) {
	print FIDX (reverse @frms);
 }else {
	print FIDX (@frms);
 }
 print FIDX qq(</frameset></html>);
 close FIDX;
}

# end of jW::dPz
1;
