package pAa;

use strict;

use vars qw ($fhcnt $VERSION);

use Carp;
use Socket qw(PF_INET SOCK_STREAM AF_INET sockaddr_in inet_aton);
use AutoLoader 'AUTOLOAD';

sub DESTROY {
 my $self = shift;
 $self->Close();
}

1;
