# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4813 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/zF.al)"
sub zF{
 my ($self)= @_;
 my $mdir = $self->nDz('hM');
 $mdir =~ s#/?$##;
 while(<$mdir/*>) {
 unlink $_;
 }
}

# end of jW::zF
1;
