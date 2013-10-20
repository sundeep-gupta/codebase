package jFa;


sub new {
 my ($type, $tb, $opts) = @_;
 my $self = bless {}, $type;
 $self->{tb} = $tb;
 $self->{index} = $opts->{index} || 0;
 $self->{jMa} = $opts->{jMa};
 $self->{cmp} = $self->{jMa}? undef: sub {return $_[0] <=> $_[1];} ;
 return $self;
}
sub iSa{
 my ($self, $jRa, $opts) =@_;
 return $self->kEa([$jRa], $opts);
}

sub iRa{
 my ($self, $jKa, $opts) =@_;
 return $self->kEa($jKa, $opts, 1);
}

sub jHa{
 my ($self, $jRa, $opts) =@_;
 return $self->jXa([$jRa], $opts);
}

sub jNa{
 my ($self, $rowrefs, $opts, $clear) =@_;
 my @ids;
 my $index = $self->{index} ;
 for(@$rowrefs) {
 		push @ids, $_->[$index];
 }
 return $self->jLa(\@ids, $opts, $clear);
}

sub kCa {
 my ($self, $id) = @_;
 my $jKa = $self->iQa(
 {noerr=>1, 
 filter=>
 $self->{jMa}? sub { $_[0]->[$self->{index}] eq $id; }
 : sub { $_[0]->[$self->{index}] == $id; }
 });
 return if not ($jKa && scalar(@$jKa));
 return $jKa->[0];
}

sub iQa{
 my ($self, $opts) =@_;
 return;
}

sub kEa{
 my ($self, $rowrefs, $opts, $clear) =@_;
}

sub jLa{
 my ($self, $ids, $opts, $clear) =@_;
}
 

sub jXa{
 my ($self, $rowrefs, $opts) =@_;
}
sub pXa{
}

1;
