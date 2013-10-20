package bNa;

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
	my ($self, $v, $extra, $ksuffix) = @_;
	$v = $self->{val} if not defined $v;
 my $sel;
	my $mult ="";
	$mult = ' MULTIPLE' if $self->{type} eq 'kAa';
 $mult .=" $extra" if $extra;
	my $bZa = qq(<select class="afselect" name="$self->{name}$ksuffix"$mult>);
	my ($opt, $lab);
	my %vhas;
	for(split ("\t|\0", $v)) {
			$vhas{$_}=1;
	}
	my $i=0;
	for(@{$self->{cIa}}) {
		$i++;
		$sel="";
		$lab = $self->{cUa}->{$_};
		$lab = '-----' if $lab eq '';
		$sel =' SELECTED' if $vhas{$_};
		my $idx = $i%2;
		my $cls;
		if($sel ne '') {
			$cls = "option_selected";
		}else {
			$cls = "option_select_$idx";
		}
		$bZa .= qq(<option class="$cls" value="$_"$sel>$lab</option>);
	}
	$bZa .=qq(</select>\n);
	return $bZa;
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
		
