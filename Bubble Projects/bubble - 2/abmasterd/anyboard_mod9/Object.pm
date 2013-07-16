package Object;

@Object::ISA=qw(Clone);
use 5.005;
use strict;
use vars qw($VERSION $AUTOLOAD );

$VERSION = 1.00;

sub new {
 my ($type, $phash) = @_;
 my $self;
 $self = {};
 no strict "refs";
 #print STDERR "making $type\n";
 for(@{"$type\:\:fs"}) {
	$self->{$_} = $phash->{$_};
	
 } 
 return bless $self, $type;
}

sub AUTOLOAD {
 my ($self, $arg) = @_;
 my $class = ref $self;
 my $field = $AUTOLOAD;
 $field =~ s/^.+::(.+)$/$1/;
 if ( $field && !exists($self->{$field}) ) {
 my (undef, $file, $line) = caller(0);
 die "Undefined function $AUTOLOAD ".caller(). ",". caller(1). ", ". caller(2). ", ". caller(3);
 }
 if (@_ == 2) {
 $self->{$field} = $arg;
 }
 return $self->{$field};
}

sub DESTROY {
 return undef;
}
sub set_by_hash{
 my ($self, $hash) = @_;
 no strict "refs";
 my $type = ref $self;
 while(my ($k, $v) = each %$hash) {
		$self->{$k} = $v ;
		#$self->{$k} = $v if exists $self->{$k};
 } 
}
	
sub dump {
 my $self = shift;
 #local $Storable::forgive_me = 1;
 # my $clone = Storable::dclone($self);
 # $clone->_purge_logs;
}

1;
