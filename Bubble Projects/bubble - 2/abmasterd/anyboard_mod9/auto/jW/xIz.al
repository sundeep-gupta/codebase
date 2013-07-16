# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2111 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/xIz.al)"
sub xIz{
 my($self) = @_;
 return $self->fC() if not $self->{enable_grp_intf};
 my $pre;
 $pre = "g" if $self->{aC} eq $self->{idx_file};
 return $self->lMa($pre.$self->{idx_file});
}

# end of jW::xIz
1;
