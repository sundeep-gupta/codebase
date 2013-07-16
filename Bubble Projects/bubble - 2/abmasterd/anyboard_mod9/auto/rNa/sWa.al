# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 330 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/sWa.al)"
sub sWa {
 my ($self, $name, $bXaA, $msg, $multicnt)= @_;
 my $wDa = $wMa{$name};
 error('inval', "Invalid form name") if not $wDa;
 my $form = new aLa($name, $wDa->[0], $self->{cgi});
 $form->aAa($bXaA, 1) if $bXaA; 
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print $msg;
 $form->sRa('dupcnt', $multicnt);
 print $form->form();
 print $self->{footer};
}

# end of rNa::sWa
1;
