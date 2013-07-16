# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 291 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aNaA.al)"
sub aNaA {
 my ($self, $fieldsref, $where, $tag)=@_;
 my $stmt;
 $stmt = "select ". join (",\n", map{ (defined $self->{$_}) && $self->{$_} =~ /^sqlfunc:(.*)/i ? $1: $_} @{$fieldsref});
 $stmt .= "\nfrom $self->{tb} \n$where";
 $sqls{$stmt}= $tag || "fetch_$self->{tb}".aWaA($where);
 #   print STDERR $stmt, "\n";
 return $stmt;
}

# end of zDa::aNaA
1;
