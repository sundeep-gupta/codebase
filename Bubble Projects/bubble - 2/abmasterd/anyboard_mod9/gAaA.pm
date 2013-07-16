package gAaA;

use fJaA;
@gAaA::ISA=qw(fJaA);
use sVa;
use strict;

sub list {
 my ($self) = @_;
 my $dir = sVa::kZz($self->{_root}, $self->path()) ;
 local *DIR;
 if( not (opendir DIR, $dir ) ) {
	$self->{_error} = "Fail to open directory: $!";
	return;
 }
 my $ent ;
 my $path;
 my @dlist;
 my $type;
 while ($ent = readdir (DIR)) {
	$path = sVa::kZz($dir, $ent);
 my $type = undef;
	if(-f $path) {
		$type = 'TFILE';
	}elsif(-d $path) {
		$type = 'TDIR';
	}elsif(-s $path) {
		$type = 'TSLINK';
	}else {
		$type = 'TDEVICE';
	}
 my @stats = stat($path) ;
 push @dlist, [
 $path, 
 $ent,
		      $type,
		      $stats[2] &07777, #permission
 $stats[4], # gJz
 $stats[5], # gid
 $stats[7], # size
		      $stats[9], # mtime
		      $stats[10], # ctime
		      ];
 }
 closedir DIR;
 return @dlist;
}

sub get_size {
 my ($self) = @_;
 my $dir = sVa::kZz($self->{_root}, $self->path()) ;
 return sVa::hAaA($dir);

}

sub goto_self {
	my ($self) = @_;
	return chdir sVa::kZz($self->{_root}, $self->path());
}

sub eXaA{
	my ($self, $subdir, $mod) = @_;
	my $dir = sVa::kZz($self->{_root}, $self->path(), $subdir);
	if (not mkdir $dir, $mod) {
		$self->{_error} = "Fail to create directory: $! ($dir)";
		return;
	}
	return 1;
}

sub remove_subdir{
	my ($self, $subdir) = @_;
	my $dir = $self->gCaA($subdir);
	if(not rmdir $dir) {
		$self->{_error} = "Fail to remove directory: $! ($dir)";
		return;
	}
	return $subdir;
}

sub chmod_files {
	my ($self, $perm, @files) = @_;
	my @paths = map { $self->gCaA($_) } @files;
	if( not chmod $perm, @paths) {
		$self->{_error} = "Fail to chmod permission: $!";
		return;
	}
	return 1;
}

sub del_files {
	my ($self, @files) = @_;
	my @paths = map { $self->gCaA($_) } @files;
	if(not unlink @paths) {
		$self->{_error} = "Fail to delete file: $!";
		return;
	}
	return 1;
}

sub tZa {
 my ($self, $xO, $data, $perm, $maxsize) = @_;
 if($xO eq '') {
	$self->{_error} ="Missing filename";
	return;
 }
 my $path = $self->gCaA($xO);
 if($maxsize ne '' && length($data) > $maxsize) {
	$self->{_error} ="Not enough free space: ($xO)";
	return;
 }
 local *FH;
 if(not open FH, ">$path") {
	$self->{_error} ="Fail to open file: $! ($xO)";
	return;
 }
 binmode FH;
 print FH $data;
 close FH;
 $self->chmod_files($perm, $xO) if $perm ne "";
 return 1;
}

sub output_file {
 my ($self, $xO, $nA) = @_;
 my $path = $self->gCaA($xO);
 local *FH;
 if(not open FH, "<$xO") {
	$self->{_error} ="Fail to open file: $! ($xO)";
	return;
 }
 binmode FH;
 my $buf;
 while(sysread FH, $buf, 4096*4) { print $nA $buf;}
 close FH;
 return 1;
}
	

			 
1;
 
		       
			
	
 
 
 
	
