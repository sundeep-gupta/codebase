package jPa;

sub LOCK_SH {1}; sub LOCK_EX {2}; sub LOCK_UN {8};

sub new {
 my ($type, $file, $mode) = @_;
 $file =~/(.*)/; $file = $1;
 my $lf = $file."_lck";
 $mode = LOCK_EX if ((!$mode) || not -f $lf);
 my $lock_fh= "lT$file";
 $lock_fh =~ s#\W#_#g;
 $lock_fh = eval "\\*$lock_fh";
 if($mode == LOCK_EX) {
 	open ($lock_fh, ">>$lf") or return;
 }else {
 	open ($lock_fh, "$lf") or return;
 }
 eval {
 my $rem=0;
	 local $SIG{ALRM} = sub { die "lock_operation_timeout ($lf)" };
 $rem = eval 'alarm 20' if $sVa::use_alarm;
 flock ($lock_fh, $mode) or sVa::error('sys', "Fail to lock $lf: $!");
 eval "alarm $rem" if $sVa::use_alarm;
 };
 if ($@ =~ /operation_timeout/) {sVa::error('sys', "Lock operation timed out. Go back and retry.<!--$@-->");  }
 my $self = bless {}, $type;
 $self->{lock_fh} = $lock_fh;
 return $self;
 
}

sub DESTROY{
 my ($self) = @_;
 my $lock_fh=$self->{lock_fh};
 return if not $lock_fh;
 flock ($lock_fh, LOCK_UN);
 close $lock_fh;
}

1;

