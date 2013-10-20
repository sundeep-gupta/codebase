# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 362 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/bHaA.al)"
sub bHaA{
 my ($self, $tag) = @_;
 my $stmt = "insert into $self->{tb}\n(\n". join (",\n  ", @{$self->{fields}});
 $stmt .= "\n)\nvalues (\n" .join(",\n", 
 map {(defined $self->{$_}) && $self->{$_} =~ /^sqlfunc:(.*)/i ? $1 : '  ?'} @{$self->{fields}});
 $stmt .= ")";
 $sqls{$stmt} = $tag || "insert_$self->{tb}";
 return $stmt;
}

# end of zDa::bHaA
1;
