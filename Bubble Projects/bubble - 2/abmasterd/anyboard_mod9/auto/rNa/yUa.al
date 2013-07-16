# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 897 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/yUa.al)"
sub yUa{
 my ($self, $id) = @_;
 error("inval", "Invalid form id, must be alphanumeric") if $id =~ /\W/;

 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);
 my $idstr = $design->{frepfids};
 $idstr =~ s/^\s*//;
 $idstr =~ s/\s*$//;
 return split /\s+/, $idstr;
} 

# end of rNa::yUa
1;
