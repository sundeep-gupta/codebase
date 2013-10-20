package zKa;

use DBI;
use strict;
use vars qw($dbdsn $dbuser $dbpassword);

=item
$dbdsn= "DBI:mysql:database=ut;host=localhost";
$dbuser = "ut";
$dbpassword = "ut1";
=cut
#DBI->trace(1, "/tmp/db.log");

sub new {
	my $type = shift;
 my ($dsn) = @_;
	my $self = bless {dsn=>$dsn}, $type;
	$self->{connected}=0;
	return $self;
}

sub DESTROY {
	my ($self) = @_;
	$self->disconnect();
}

sub connect {
 my ($self, $dsrc) = @_;

 if ($dsrc && (ref $dsrc)) {
 $self->{dsrc} = $dsrc;
 $self->{connected}=1;
 return $self->{dsrc};
 }

 $self->{dsrc} = DBI->connect(
			$dbdsn, $dbuser, $dbpassword,
				{RaiseError =>1, PrintError=>0}
 );

 if(not $self->{dsrc}) {
 }
 $self->{connected}=1;
 $self->{ping_time} = time();
 $self->{auto_reconnect}= $self->{dsrc}->{mysql_auto_reconnect};
 return $self->{dsrc};
}

sub ping {
 my $self = shift;
 return $self->{dsrc}->ping() if $self->{dsrc};
}

sub disconnect {
 my $self = shift;
 $self->dsrc->disconnect() if $self->dsrc();
 $self->{connected}=0;
 $self->{dsrc}=undef;
}

sub connected{
 my $self = shift;
 return $self->{connected};
}

sub commit{
 my $self = shift;
 $self->dsrc->commit();

}

sub rollback{
 my $self = shift;
 $self->dsrc->rollback();

}
sub dsrc{
	my $self =shift;
	my $t = time();
	if($t- $self->{ping_time} > 300) {
		$self->ping();
		$self->{ping_time} = $t;
	}
	return $self->{dsrc};
}

sub getDataSources {
	my @drivers = DBI->available_drivers();
	my $dshash={};
	for my $dr (@drivers) {
		eval {
			my @dss = DBI->data_sources($dr);
			$dshash->{$dr} = [@dss];
		};
	}
	return $dshash;
}

=item

my $dh = getDataSources();
for my $k (keys %$dh) {
	print $k, "\n";;
	print join(" ", @{$dh->{$k}});
}

my $dbh = zKa->new();
$dbh->connect();
=cut
1;
