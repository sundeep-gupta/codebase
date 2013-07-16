# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9832 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nMa.al)"
sub nMa{
 my ($self, $cG, $str)=@_;
 my $cA = $self->gN($cG);
 local *kE;
 local *TRASHF;
 open(kE, "<$cA") or return;
 open TRASHF, ">>".$self->nDz('trash');
 print TRASHF "\n", $jW::trash_sep, "<<<<$str>>>>\n";
 local $_;
 while(<kE>) { print TRASHF $_;}
 close kE;
 close TRASHF;
 return 1;
}

# end of jW::nMa
1;
