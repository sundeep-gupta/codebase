# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4192 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/vPz.al)"
sub vPz{
 my ($self) = @_;
 my $path = $self->xMz();
 my $iurl = $self->{cgi}. "?@{[$abmain::cZa]}cmd=gidx";
 my $bbsurl =  $self->fC();
 open FIDX, ">$path" or abmain::error('sys', "Fail to open file $path: $!");
 print FIDX qq(<html><head><title>$self->{name}</title>$self->{sAz}</head><frameset $self->{idx_fset_attr}>
 <frame $self->{idx_tframe_attr} name="gidx" src="$iurl">
 <frame $self->{idx_bframe_attr} name="ginfo" src="$bbsurl">
 </frameset></html>);
 close FIDX;
}

# end of jW::vPz
1;
