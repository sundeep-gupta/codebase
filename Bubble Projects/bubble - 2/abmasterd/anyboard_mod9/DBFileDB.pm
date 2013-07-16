package DBFileDB;


use jFa;
use DB_File;
@DBFileDB::ISA = qw(jFa);

sub pXa{
 my ($self) =@_;
 my $jTa = $self->{tb}."_dbf";
 my %hash;
 if(not tie %hash, "DB_File", $jTa, O_CREAT|O_RDONLY, 0644, $DB_BTREE) {
	return;
 }
 my $cnt = scalar(keys %hash);
 untie %hash;
 return $cnt;
}

sub iQa{
 my ($self, $opts) =@_;
 my %hash;
 my $index = $self->{index} ||0;
 $DB_BTREE->{'compare'} = $self->{cmp}; 
 
 my $jTa = $self->{tb}."_dbf";
 if(not tie %hash, "DB_File", $jTa, O_CREAT|O_RDONLY, 0644, $DB_BTREE) {
	unless($opts && $opts->{noerr} ) {
			abmain::error("sys", $opts->{kG}. "($!: $jTa)");
 }
	return;
 }
 my @rows=();
 my $filter = $opts->{filter};
 my $row;
 my $cnt=0;
 my $filtcnt=0;
 my $max = $opts->{maxret};
 my $sidx = $opts->{sidx} || 0;
 my @mykeys = keys %hash;
 my $eidx = $opts->{eidx} || scalar(@mykeys);
 my $idx=0;
 for($idx=$sidx; $idx<$eidx; $idx++){
	$row = [split /\t/, $hash{$mykeys[$idx]}];
	if($filter && not &$filter($row, $idx)) {
		$filtcnt++;
		next;
 }
	push @rows, $row;
	$cnt ++;
 last if $max >0 && $cnt > $max;
 }
 untie %hash;
 return wantarray? (\@rows, $cnt, $filtcnt) : \@rows;
}

sub kEa{
 my ($self, $rowrefs, $opts, $clear) =@_;
 my %hash;
 my $index = $self->{index} ||0;
 $DB_BTREE->{'compare'} = $self->{cmp}; 
 
 my $jTa = $self->{tb}."_dbf";
 if(not tie %hash, "DB_File", $jTa, O_CREAT|O_RDWR, 0644, $DB_BTREE) {
	unless($opts && $opts->{noerr} ) {
			abmain::error("sys", $opts->{kG}. "($!: $jTa)");
 }
	return;
 }
 %hash= () if $clear;
 for(@$rowrefs) {
 	$hash{$_->[$index]}= join("\t", @$_);
 }
 untie %hash;
 return scalar(@$rowrefs);
}

sub jXa{
 my ($self, $rowrefs, $opts) =@_;
 return $self->kEa($rowrefs, $opts);
}

sub jLa{
 my ($self, $ids, $opts, $clear) =@_;
 my $jTa = $self->{tb}."_dbf";
 my %hash;
 $DB_BTREE->{'compare'} = $self->{cmp}; 
 
 if(not tie %hash, "DB_File", $jTa, O_CREAT|O_RDWR, 0644, $DB_BTREE) {
	unless($opts && $opts->{noerr} ) {
			abmain::error("sys", $opts->{kG}. "($!: $jTa)");
 }
	return;
 }
 %hash= () if $clear;
 my $cnt =0;
 for(@$ids) {
 if(exists $hash{$_}) {
 		delete $hash{$_};
		$cnt ++;
 }
 }
 untie %hash;
 return $cnt;
}

1;
