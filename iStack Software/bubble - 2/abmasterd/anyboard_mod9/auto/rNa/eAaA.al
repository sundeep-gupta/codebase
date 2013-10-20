# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 736 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/eAaA.al)"
sub eAaA{
 my ($self, $input) = @_;
 my $id = $input->{xZa};
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body><pre>";
 print $form->dCaA($id);
 print "</pre>";
 print sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'crtable', xZa=>$id}), "<center>Create table</center>");
}

# end of rNa::eAaA
1;
