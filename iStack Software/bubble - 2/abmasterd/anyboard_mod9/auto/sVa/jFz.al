# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1827 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/jFz.al)"
sub jFz{
 my $pat =shift;
 $pat =~ s/^\s+//;
 $pat =~ s/\s+$//;
 my @pats = split /\s+/, $pat;
 my $expr = join '&&' => map { "m/\$pats[$_]/imo" } (0..$#pats);
 return eval "sub { local \$_ = shift if \@_; $expr; }"; 
}

# end of sVa::jFz
1;
