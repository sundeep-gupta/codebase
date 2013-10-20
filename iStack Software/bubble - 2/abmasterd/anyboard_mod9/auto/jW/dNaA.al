# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 6522 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dNaA.al)"
sub dNaA{
 my ($self, $form) = @_;
 $self->eMaA( [qw(other_header other_footer)]);
 sVa::gYaA "Content-type: text/html\n\n";
 print qq(<html><head>\n$self->{sAz}\n$self->{other_header});
 $form->zQz($self->{cgi});
 print $form->form();
 print $self->{other_footer};
}

# end of jW::dNaA
1;
