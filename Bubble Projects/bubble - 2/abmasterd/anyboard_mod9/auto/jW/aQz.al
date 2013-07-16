# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7586 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/aQz.al)"
sub aQz{
 my ($self) = @_;
 $self->oF(LOCK_SH, 4);
 open aOz, "<@{[$self->nDz('aLz')]}" or return;
 my @gHz = <aOz>;
 close aOz;
 $self->pG(4);
 my @aRz = split /\s+/, join ("", @gHz);
 for(@aRz) {
 next if not $_;
 $self->{aLz}->{$_} = 1;
 }
 1;
}

# end of jW::aQz
1;
