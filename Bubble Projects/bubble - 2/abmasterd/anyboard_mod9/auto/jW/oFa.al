# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 755 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/oFa.al)"
sub oFa {
 my ($self, $wW, $cG, $aK, $cat) = @_;
 my $f = abmain::wTz('news').$cat;
 my $node = lB->new($aK, 0, $cG);
 my $url = $node->nH($self, -1);
 $self->fZa(\$wW);
 $wW =~ s/\t/ /g;
 $bYaA->new($f, {index=>1, schema=>"AbNewsIndex"})->iSa(
 [$wW, $url, $self->{eD}, $self->{name}, $self->fC(), $cG, $self->{_fvp}, time()]
 );
}

# end of jW::oFa
1;
