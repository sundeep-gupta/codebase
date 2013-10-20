# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 1191 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/tBa.al)"
sub tBa {
 my ($self, $input) = @_;
 my $id = $input->{uVa};
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->zNz([_aefcmd_=>"hidden", "", "", "submit"]);
 $form->zNz([uVa=>"hidden", "", "", "$id"]);
 $form->zQz($dLz);
 my $wGa = $form->aSa();
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);
 $form->bSa($design->{vNa}||$wGa);
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print sVa::tWa();
 my $nav = $self->yMa('', $id);
 print $nav, qq(<br>);
 print qq(<h1>Publish the form $design->{name}</h1>);
 print qq(<h2>Direct link to rNa</h2>);
 print "<ul>";
 print "<li> Use custom design: ",sVa::hFa(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id}), 
 		                        sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id}) ), 
 "</li>";
 print "<li> Use default design: ",
 sVa::hFa(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id, vYa=>1}), 
 		                        sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id, vYa=>1}) ), 
 "</li>";

 print "</ul>";
 print "If you see missing fields in the custom design, you must edit the form template to include them";

 print qq(<h2>Form HTML which can be copied and pasted to a web page</h2>);
 my $cTa=$form->form();
 $cTa =~ s/</&lt;/g;
 print qq(<form><textarea rows="16" cols="70">), $cTa, qq(</textarea></form>);
 print qq(<h2>Link for viewing submitted data</h2>);
 print sVa::hFa(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'dataidx', uVa=>$id}), 
 		                        sVa::sTa($self->{cgi_full}, {_aefcmd_=>'dataidx', uVa=>$id}) );

 print qq(<br><hr width="90%" noshade><br>);
 
 print $self->{footer};
} 

# end of rNa::tBa
1;
