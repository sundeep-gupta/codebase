package fJaA;

use strict;

@fJaA::ftypes=qw(FILE DEVICE FIFO SYMLINK DIR);

sub new {
 my ($type, $root, $path) = @_;
 my $self;
 $self = {};
 $self->{_path} = $path;
 $self->{_root} = $root;
 return bless $self, $type;
}
sub list {
 my ($self) = @_;

};

sub path{
 my ($self, $ndir) = @_;
 if (@_ == 2) {
 $self->{_path} = $ndir;
 }
 return $self->{_path};
 
}

sub root{
 my ($self, $ndir) = @_;
 if (@_ == 2) {
 $self->{_root} = $ndir;
 }
 return $self->{_root};
 
}

sub gCaA {
	my ($self, $xO) = @_;
	$xO =~ s!.*/!!;
	$xO =~ s!.*\\!!;
	$xO =~ s!^\.\.$!!;
	return sVa::kZz($self->root(), $self->path(), $xO);
}

sub goto_self {
	my ($self) = @_;

}

sub eXaA {
	my ($self, $subdir, $mod) = @_;
}

sub remove_subdir {
	my ($self, $subdir) = @_;
}

sub chmod_files {
	my ($self, $perm, @files) = @_;

}

sub del_files {
 my ($self, @files) = @_;

}

sub tZa {
 my ($self, $xO, $data, $perm) = @_;

}

sub output_file{
 my ($self, $xO, $nA) = @_;
}

sub find_files {
 my ($self, $testfunc) = @_;
}

sub get_last_error{
 my ($self) = @_;
 return $self->{_error};
 

}

1;
