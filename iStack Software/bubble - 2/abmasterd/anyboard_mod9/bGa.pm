package bGa;

use vars qw(@ISA);

use bAa;

BEGIN {
@ISA = qw(bAa);
}

sub new {
	my $type = shift;
	my ($k, $t, $a, $v, $r) = @_;
 	my $self = new bAa(@_);
	my @a=();
	if(ref $a eq 'ARRAY') {
		@a = @$a;
	}else {
		@a = bAa::zPz($a);
	}
 my ($opt, $lab);
	my $cnt = @a;
	my $i;
	for($i=0; $i<$cnt; $i+=2) {
		$opt = $a[$i];
		next if not defined($opt);
		$lab = $a[$i+1];
		$self->{cUa}->{$opt} = $lab;
		push @{$self->{cIa}}, $opt;

	}
	return bless $self, $type;
}

sub bDa{
	my ($self, $v) = @_;
	$v = $self->{val} if not defined $v;
	return $self->{cUa}->{$v} || $v;
}

sub to_links{
	my ($self, $v, $lnkfunc)  = @_;
 my %links;
	for(@{$self->{cIa}}) {
		my $lab = $self->{cUa}->{$_};
 if ($v ne $_) {
 	$links{$_} = sVa::cUz($lab, &$lnkfunc($_));
		}else {
 	$links{$_} =  "<b>$lab</b>";
		}
	}
	return \%links; 
}

1;

