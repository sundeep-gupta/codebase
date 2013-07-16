# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 255 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aGaA.al)"
sub aGaA {
 my @gHz;
 push @gHz,"%zDa::_sql_procs= (\n";
 for(my ($sql, $k) = each %zDa::sqls) {
 if($_sql_procs{$k} && nsp($_sql_procs{$k}) ne nsp($sql) ) {
 $k.="_1";
 } 
 next if $k !~ /\w/;
 $_sql_procs{$k} = $sql;
 }
 for (sort keys %_sql_procs) {
 next if $_ !~ /\w/;
 push @gHz, $_, "=> \nq{";
 push @gHz, $_sql_procs{$_};
 push @gHz, "},\n\n";
 }
 push @gHz, "\n);\n";
 open DF, ">/tmp/bill2.pl";
 print DF @gHz;
 close DF;
 chmod 0777, "/tmp/bill2.pl"; 
}

# end of zDa::aGaA
1;
