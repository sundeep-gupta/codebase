package cEa;

use vars qw(@ISA);

use bGa;
BEGIN{
@ISA=qw(bGa);
}

sub new {
	my $type = shift;
	my $self = new bGa(@_);
	return bless $self, $type;
}

sub aYa{
	my ($self, $v, $sep, $ksuffix) = @_;
	$v = $self->{val} if not defined $v;
 my $sel;
	my ($opt, $lab);
	my %vhas;
	my $bZa;
	for(split ("\t|\0", $v)) {
			$vhas{$_}=1;
	}
 $bZa = '';
 $sep = '<br/>' if not $sep;
 my @strs=();
	for(@{$self->{cIa}}) {
		$sel="";
		$lab = $self->{cUa}->{$_};
		$sel =' checked="checked"' if $vhas{$_};
		push @strs, qq(<input type="checkbox" class="input_checkbox" name="$self->{name}$ksuffix" value="$_"$sel/>$lab );
	}
	my $max;
	$max = 'max' if scalar(@strs) > 10;
	return qq(<div class="checkbox_group_$max">).$bZa.join($sep, @strs)."</div>";
}

sub bDa{
	my ($self, $v) = @_;
	$v = $self->{val} if not defined $v;
	my @vs = split ("\t|\0", $v);
	if(not $self->{cUa}) {
		return join("; ", @vs);
	}
	return join("; ", @{$self->{cUa}}{@vs});
}

1;

