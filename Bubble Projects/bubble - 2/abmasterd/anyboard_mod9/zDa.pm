package zDa;

use Object;
use strict;
use zKa;
use aLa;
use File::Path; 

@zDa::ISA=qw(Object);

use vars qw(%tab_desc %sqls $tb_val_sets $global_val_sets %_sql_procs %precision_desc %nullable_desc);

sub aMaA{
 if( not $zDa::dbh){
 $zDa::dbh = zKa->new();
 $zDa::dbh->connect();
 }
 return $zDa::dbh;
}

END {
 if($zDa::dbh){
	$zDa::dbh->disconnect();
 }

}
sub DESTROY {
 my $self = shift;
 #aGaA();
 if($self->{_kill0}) {
	$self->{aHaA}->disconnect();
 }
 $self->{aHaA} = undef;
 $self->{_dbh} = undef;
	
}

use AutoLoader 'AUTOLOAD';
1;
