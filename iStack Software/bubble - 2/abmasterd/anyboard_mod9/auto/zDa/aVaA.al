# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 300 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aVaA.al)"
sub aVaA {
 my ($self, $fieldsref, $where, $kvhash, $tag)=@_;
 my $stmt = "update $self->{tb}\n";
 my $cnt = @{$fieldsref};
 my $k;
 $kvhash = $self if not $kvhash;
 for(my $i=0; $i<$cnt; $i++) {
 $stmt .= "set " if $i==0;
 $k = $fieldsref->[$i];
	if($kvhash->{$k} =~ /^sqlfunc:(.*)/i) {
		$stmt .="$k = $1";
	}else {
		$stmt .= "$k = ?";
 }
 $stmt .=",\n" unless $i == $cnt-1;
 }
 $stmt .= "\n$where";
 $sqls{$stmt} = $tag ||"update_$self->{tb}_".join("_", map {lc($_)} @$fieldsref )."_".aWaA($where);
 #   print STDERR $stmt,"\n";
 return $stmt;
}

# end of zDa::aVaA
1;
