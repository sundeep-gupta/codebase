package hIaA;

use IO::Select;
use strict;
sub TIEHANDLE {
	my ($class, $handle, $timeout) = @_;
	my $self = bless {}, $class;
	$self->{timeout} = $timeout;
	$self->{hHaA} = $handle;
	$self->{buf}= undef;
	$self->{hJaA} = 0;
	$self->{line_max} = 4*4096;
 	$self->{sel} = IO::Select->new($handle);
	return $self;
}

sub hMaA {
	my ($self) = @_;
	return length($self->{buf}) - $self->{hJaA};
}

sub hGaA {
	my ($self, $len) = @_;
	return if $self->{hNaA};
	return if $self->{hKaA};
	my $buf;
	if($self->hLaA($buf, $len,0) ==0) {
		return 0;
	}
	$self->{buf} .= $buf;
	if($self->{hJaA} > 1024){
		$self->compact_buf();
	}
	return length($buf);
}

sub compact_buf{
	my ($self) = @_;
	$self->{buf} = substr($self->{buf}, $self->{hJaA});
	$self->{hJaA}=0;
}
sub READ{
	my ($self, $length, $offset) = @_[0,2,3];
	my $bufref = \$_[1];
	my $len = $self->hMaA();
	if($len < $length) {
		my $rdcnt = $self->hGaA($length-$len);
	}
	$len = $self->hMaA();
	if($length < $len) {
			$len = $length;
	}
	return 0 if $len == 0;
	substr($$bufref, $offset) = substr($self->{buf}, $self->{hJaA}, $len); 
	$self->{hJaA} += $len;
	return $len;
}

sub READLINE{
	my ($self) = @_;
	my $pos;
	while( -1 == ($pos = index($self->{buf}, "\n", $self->{hJaA}) ) && $self->hMaA() < $self->{line_max}) {
		my $rdcnt = $self->hGaA(4096);
		last if not $rdcnt ;
	}
	my $line = undef;
	my $len =0;
	if($pos >=0) {
		$len = $pos - $self->{hJaA} +1;
	}else {
		$len = $self->hMaA();
	}
	return undef if $len <=0;
	$line = substr ($self->{buf}, $self->{hJaA}, $len);
	$self->{hJaA} += $len;
	return $line;

}

sub hLaA{
	my ($self, $bbb, $length, $offset) = @_;
	return 0 if ($self->{hKaA} || $self->{hNaA});
	my $bufref = \$_[1];
	my @ready = $self->{sel}->can_read( $self->{timeout} );
	if(scalar(@ready)>0) {
		my $cnt = sysread($self->{hHaA}, $$bufref, $length, $offset); 
		if($cnt <=0) {
			$self->{hKaA} = 1;
		}
		return $cnt;
			
	}else {
		if(eof($self->{hHaA})) {
		}else{
			print STDERR "$$ Timeout", caller(5), "\n";
			$self->{hNaA}=1;
		}
		return 0;
	}
}
sub BINMODE {
	my $self = shift;
	binmode $self->{hHaA};
}

sub PRINT {
	my $self = shift;
 print {$self->{hHaA}} @_ ;	
}

sub WRITE {
	my $self = shift;
	syswrite($self->{hHaA}, $_[0], $_[1], $_[2]);
}

sub EOF {
	my $self = shift;
	return $self->{hNaA} || eof($self->{hHaA});
}

sub CLOSE {
	my $self = shift;
	return close($self->{hHaA});
}

sub DESTROY {
	my $self = shift;
	$self->CLOSE;
}

sub PRINTF{
	my $self = shift;
 printf {$self->{hHaA}} @_;	
}

1;
