# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 215 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/eDaA.al)"
sub eDaA {
 my ($self)  = @_;
 my $str = $self->{name};
 $str .= " $self->{dbtype}";
 my $prec="";
 if($self->{dbtype} eq 'VARCHAR' && $self->{dbsize} eq "") {
	$self->{dbsize} = 32;
 }
 if($self->{dbsize} && $self->{dbtype} ne 'BLOB' && $self->{dbtype} ne 'INT') {
	$prec="($self->{dbsize})";
 }
 $str .=$prec;
 my $nullstr="";
 if($self->{idxtype} eq 'pk') {
	$nullstr = " PRIMARY KEY";
 }elsif ($self->{required}){
	$nullstr = " not NULL";
 }
 $str .= $nullstr;
 return $str;
}

# end of bAa::eDaA
1;
