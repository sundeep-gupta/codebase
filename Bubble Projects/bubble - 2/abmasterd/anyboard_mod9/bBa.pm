package bBa;

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
	my ($bZa, $lab);
 $bZa = '';
 $sep = '<br/>' if not $sep;
 my @strs=();
	for(@{$self->{cIa}}) {
		$sel="";
		$lab = $self->{cUa}->{$_};
		$sel =' checked="checked"' if $_ eq $v;
		my $id = "r".rand();
		$id=~s/\W//g;
		my $js =qq@if(window.xx_rad) window.xx_rad.className=''; window.xx_rad=document.getElementById('$id');  window.xx_rad.className='checkedRadio'; @;
		push @strs, qq(<input type="radio" onclick="$js" name="$self->{name}$ksuffix" class="input_radio" value="$_"$sel/><span id="$id">$lab</span> );
	}
	my $max;
	$max = 'max' if scalar(@strs) > 10;
	return qq(<div class="radio_group_$max">).$bZa.join($sep, @strs)."</div>";
}

1;

