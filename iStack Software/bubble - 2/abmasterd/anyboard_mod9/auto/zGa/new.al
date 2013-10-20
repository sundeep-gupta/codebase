# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zGa;

#line 14 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zGa/new.al)"
sub new {
 my ($type, $realm, $opts) = @_;
 my $self = bless {}, $type;
 if($opts->{paths}) {
 	($self->{realm}, $self->{srealm} ) = @{$opts->{paths}}; 
 }else {
 	($self->{realm}, $self->{srealm} ) = sVa::zHa($realm, $opts->{base});
 }
 $self->{index} = $opts->{index} || 0;
 $self->{jMa} = $opts->{jMa};
 $self->{cmp} = $self->{jMa}? undef: sub {return $_[0] <=> $_[1];} ;
 $self->{_dbobj}= zDa->new($opts->{schema});
 return $self;
}

# end of zGa::new
1;
