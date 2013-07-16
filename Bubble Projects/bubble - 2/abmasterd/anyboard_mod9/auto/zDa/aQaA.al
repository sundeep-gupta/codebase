# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 331 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aQaA.al)"
sub aQaA {
 my ($self, $where, $tag)=@_;
 my $stmt="delete from $self->{tb} $where";
 $sqls{$stmt}= $tag || "delete_$self->{tb}".aWaA($where);
 return $stmt;
}

# end of zDa::aQaA
1;
