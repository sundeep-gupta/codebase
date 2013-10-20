# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2390 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/cIz.al)"
sub cIz {
 my ($self) = @_;
 opendir DIR, $self->nDz('iC') or abmain::error('sys', "Fail to open directory: $!");
 my @files = grep { /\.dat$/ } readdir (DIR);
 closedir (DIR);
 return \@files;
}

# end of jW::cIz
1;
