# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 1161 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/uJa.al)"
sub uJa{
 my ($self, $id) = @_;
 my @links=();
 my $isadm = $self->eVa();
 my (@wNa, @forms, @usrs);
 if($isadm) {
 if($id) {
 	push @wNa,
 	['def', sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'wLa', uVa=>$id}), "Define form")],
 	['conf', sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uBa', uVa=>$id}), "Configure form")], 
 	['defview', sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id, vYa=>1}), "Default view")];
 }else {
 	push @wNa,
 	['', sVa::cUz(
		sVa::sTa($self->{cgi}, {_aefcmd_=>"uYa", uWa=>"lXa"}), "Create New Form")];
 }
 }
 if($id) {
 push @forms,
 	['submit',sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id}), "Form Submission")], 
 	['didx', sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'dataidx', uVa=>$id}), "Data index")];
 }
 push @usrs,
 	['allforms', sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'wIa'}), "All forms")], 
 	['main', sVa::cUz($self->{uQa}, "Main page")];
 push @usrs, ['logout', $self->{vSa}." ($self->{wOa})"] if $self->{wOa};
 push @usrs, ['login', sVa::cUz($self->{wCa}, "Login") ] if not $self->{wOa};
 return (@forms, @wNa, @usrs);
}

# end of rNa::uJa
1;
