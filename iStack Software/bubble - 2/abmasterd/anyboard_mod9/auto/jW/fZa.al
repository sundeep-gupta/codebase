# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4879 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fZa.al)"
sub fZa {
 my ($self, $dref, $all) = @_;
 return if not $self->{forum_tag_trans};
 my $trans = $self->fRa($all);
 &$trans($dref); 
}

# end of jW::fZa
1;
