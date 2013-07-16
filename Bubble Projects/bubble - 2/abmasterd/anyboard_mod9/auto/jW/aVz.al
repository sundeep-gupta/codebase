# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7667 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/aVz.al)"
sub aVz{
 my ($self) = @_;
 $self->oF(LOCK_EX, 4);
 my $mf = $self->nDz('aLz'); 
 open aOz, ">$mf" or 
 abmain::error('sys', "On writing file $mf: $!");
 print aOz join("\t", keys %{$self->{aLz}});
 close aOz;
 $self->pG(4);
 1;
}

# end of jW::aVz
1;
