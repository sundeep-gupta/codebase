# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 1514 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/rVa.al)"
sub rVa{
 my ($self, $id) = @_;
 sVa::gYaA "Content-type: text/html\n\n";
	print $self->{header};
 print sVa::tWa();
 my $nav = $self->yMa('def', $id);
 print $nav, qq(<br>);
 
	print qq(<blockquote><h2>Step 1: Define form elements</h2>);
 print qq(<br>In this step, you add form elements to the form.</blockquote>); 

 my @cmds =();
 my $addel =  sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'cCaA', uVa=>$id}), "Add a field to the form");
 my $loadtl = sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'bSaA', xZa=>$id}), "Load from form template");
 push @cmds, $addel, $loadtl;
 push @cmds,  sVa::hFa(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id, vYa=>1}), "Preview form", "fv"); 
 push @cmds, sVa::hFa(sVa::sTa($self->{cgi}, {_aefcmd_=>'crsql', xZa=>$id}), "Show table SQL", "sql");
	
	my $cmdstr = join(" | ", @cmds);
 my $fadm = $self->dPaA($id, $cmdstr);

 if($fadm) {
 		print $fadm;
 }else {
		print qq(<center>The form is empty, click on the link below to add fields to it</center><br/>);
		print "<li>$addel";
		print "<li>$loadtl";
		
 }

	print "<p><p><hr width=90% noshade/>";
	print "<blockquote>";
 print sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"uBa", uVa=>$id}), "<h3>Step 2. Configure the form</h3>");
 print qq(<blockquote>After finished adding fields to the form in step 1, you set various properties for the form, such as setting up required fields, notification email address and layout the form page.</blockquote>); 
	print "</blockquote>";
	print "<hr width=90% noshade/>";
	print "<blockquote>";
 print sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'vGa', uVa=>$id}), "<h3>Step 3. Publish the form</h3>");
 print qq(<blockquote>This page provides the instructions on how to publish the form.</blockquote>); 
	print "</blockquote>";
 
	print $self->{footer};
}

# end of rNa::rVa
1;
