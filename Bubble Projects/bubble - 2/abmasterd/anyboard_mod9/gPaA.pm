package gPaA;

use strict;

sub TIEHANDLE {
	my $class = shift;
	bless [], $class;
}

sub PRINT {
	my $self = shift;
	push @$self, join('', @_);
}

sub PRINTF{
	my $self = shift;
	my $fmt = shift;
	push @$self, sprintf $fmt, @_;
}

sub READLINE{
	my $self = shift;
 return join('', @$self);
}

sub yB{
	my $self = shift;
 return join('', @$self);

}	

1;
