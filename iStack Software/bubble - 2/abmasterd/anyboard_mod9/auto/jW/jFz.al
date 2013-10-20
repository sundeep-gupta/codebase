# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3117 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/jFz.al)"
sub jFz{
 my $pat =shift;
 my @pats = split /\s+/, $pat;
 my $expr = join '&&' => map { "m/\$pats[$_]/io" } (0..$#pats);
 return eval "sub { local \$_ = shift if \@_; $expr; }"; 
}

# end of jW::jFz
1;
