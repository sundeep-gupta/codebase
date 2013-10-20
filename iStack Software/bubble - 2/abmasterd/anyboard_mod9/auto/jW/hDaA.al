# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 256 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/hDaA.al)"
sub hDaA {
 my($self) = @_;
 my @dirs;
 push @dirs, $self->{eD};
 push @dirs, ($self->nDz('hM'),
	       $self->nDz('iC'),
 $self->nDz('mK'),
 $self->nDz('updir'),
 $self->nDz('qUz'),
 $self->nDz('evedir'),
 $self->nDz('chat'),
 $self->nDz('dbdir'),
 $self->nDz('grpdir'),
 );
 push @dirs, $self->nDz('passdir');
 my @err;
 for my $e (@dirs) {
	push @err, $e if not abmain::nZa($e);
 }
 return @err;
}

# end of jW::hDaA
1;
