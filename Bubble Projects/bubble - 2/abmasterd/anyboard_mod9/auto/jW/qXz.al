# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4845 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/qXz.al)"
sub qXz{
 my ($self, $qQz)= @_;
 my $pp = $self->qZz($qQz);
 return "$qQz does not exist" if not -f $pp;
 $self->cJ($pp, \@abmain::qSz);
 return "$self->{rFz}<p>Poll inactive!" if $self->{rBz};
 my @polls = split ("\n", $self->{qRz});
 my @ans=();
 for(@polls) {
 my ($k, $v) = abmain::oPa($_);
 abmain::jJz(\$k);
 $k =~ /(\w+)/;
 $k = $1;
 next if not $k;
 next if not $v;
 push @ans, [$k, $v]; 
 }
 my $vstr=qq(<form ACTION="$self->{cgi_full}" METHOD=POST><input type="hidden" name="cmd" value="vote">
@{[$abmain::cYa]}
 <input type="hidden" name="qQz" value="$qQz">);
 $vstr .=qq(<table $self->{polltabattr}><tr><td bgcolor="$self->{pollhbg}">$self->{rFz}</td></tr>\n);
 my $first = 1;
 my $ans_cnt = scalar(@ans);
 my $vtype="radio";
 $vtype="checkbox" if $self->{fVa};
 for(@ans) {
 $vstr .=qq(<tr><td> <input type="$vtype" name="$qQz" value="$_->[0]"> \&nbsp; $_->[1]</td>);
 $vstr .= qq(</tr>\n);
 $first = 0;
 }
 $vstr .= qq(<tr><td align="left"><input type="submit" class="buttonstyle" name="v" value="Vote"></td></tr>);
 $vstr .="</table></form>\n";
 return $vstr;
}

# end of jW::qXz
1;
