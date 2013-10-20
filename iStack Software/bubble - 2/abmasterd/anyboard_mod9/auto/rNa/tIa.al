# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 230 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/tIa.al)"
sub tIa{
 my ($self, $input) = @_;
 my $iC = $self->{iC};
 opendir DIR, $iC or error('sys', "Can't open dir $iC: $!"); 
 my @forms = grep !/^\.\.?$/, readdir DIR;
 close DIR;
 my @rows;
 for my $xZa (@forms) {
 next if not  -f $self->uFa($xZa, "def");
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf =$self->uFa($xZa, "fmt");
 $design->zOz();
 $design->load($fmtf);
	push @rows, [$xZa, $design->{name}, $design->{publish}, $design->{vAa}, $design->{wBa}, $design->{vCa}, $design->{finboard}];
 }
 my $uNa = jEa->new($self->tTa(), {schema=>"vEa"});
 $uNa->iRa(\@rows);
}

# end of rNa::tIa
1;
