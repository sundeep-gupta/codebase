# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 42 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/new.al)"
sub new {
 my $type = shift;
 my ($bBaA, $pers, $fieldarr) = @_;
 my $self = {};
 if($pers ) {
	    $self->{aHaA} =  $pers;
 }else {
	    $self->{aHaA} =  aMaA();
	    $self->{_kill0} = 0;
 }
	
 $self->{aHaA}->connect($self->{aHaA}->dsrc)
 if not $self->{aHaA}->connected();
 $self->{_dbh} = $self->{aHaA}->dsrc();
 $self->{_dbh}->{LongReadLen} = 512*1024;
 bless $self, $type;

 return $self if($bBaA eq "");

 $self->{tb} = $bBaA;
 if ($self->{_dbh} && not $fieldarr) {
	#print STDERR "caller = ", caller, "\n";
 	$fieldarr = $self->bFaA($bBaA);
 }
 $self->{fields} = $fieldarr;
 for(@$fieldarr) {
 $self->{$_} = undef;
 }
 # zQa();
 return $self;
}

# end of zDa::new
1;
