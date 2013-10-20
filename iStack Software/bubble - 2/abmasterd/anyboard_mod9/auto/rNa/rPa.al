# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 344 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/rPa.al)"
sub rPa {
 my ($self, $input) = @_;
 my $id = $input->{uVa};
 error("inval", "Invalid form id, must be alphanumeric") 
	if not rJa($id);
 error("inval", "Invalid form id, must start with a letter") if  $id !~ /^[a-z_]/i;
 my $vOa = sVa::kZz($self->{iC}, $id);
 my $uUa = sVa::kZz($vOa, 'data');
 mkdir $vOa, 0755 or error('sys', "Can't make form directory: $!");
 mkdir $uUa, 0755 or error('sys', "Can't make form directory: $!");

 my $formdefpath = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->zNz(["aefpid", "hidden", "", "Primary key", "", "", 0, "INT", undef, "pk"]);
 $form->cCa($formdefpath);
 $self->rVa($id);
 $self->tIa();

} 

# end of rNa::rPa
1;
