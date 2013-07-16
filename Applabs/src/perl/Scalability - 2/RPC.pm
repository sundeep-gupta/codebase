package RPC;
use vars qw( @ISA $VERSION );
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(try_this);

sub   try_this {
  	return 'You are calling me';
  }
