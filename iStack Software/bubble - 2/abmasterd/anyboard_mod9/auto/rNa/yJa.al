# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 480 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/yJa.al)"
sub yJa{
 my ($self, $input) = @_;
 $self->tJa() if not $self->eVa();
 my $iC = $self->{tmpldir};
 opendir DIR, $iC or error('sys', "Can't open dir $iC: $!"); 
 my @forms = grep /^(.*)\.def$/, readdir DIR;
 close DIR;

 my @fs=();
 my @rows;
 for my $xZa (@forms) {
	$xZa =~ s/\.def$//;
 next if not  -f $self->ySa($xZa, "def");
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf =$self->ySa($xZa, "fmt");
 $design->zOz();
 $design->load($fmtf);
	push @fs, [$xZa, $design->{name}];
	push @rows, qq!<input type=radio name=tmpname value="$xZa"> $design->{name} ( $xZa )<br>!;
 
 }
 my $form = aLa->new();
 $form->zNz(['', 'head', "Load from form template"]);
 $form->zNz(['_aefcmd_', 'hidden', '', "", "cDaA"]);
 $form->zNz(['xZa', 'hidden', '', "", $input->{xZa}]);
 $form->zNz(["aeftmpl", 'const', "", "Available forms", join("", @rows)]);
 $form->zQz($self->{cgi});
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print $form->form();
 print $self->{footer};
}

# end of rNa::yJa
1;
