# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1371 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/jLz.al)"
sub jLz {
 my $self = shift;
 my ($m, $p, @moders , @jTz, @kFz, @jHz, @jOz, @mod_can_polls);
 while( ($m, $p) = each  %{$self->{moders}}) {
 push @moders, $m;
 push @jTz, $p->[0];
 push @kFz, $p->[1];
 push @jHz, $p->[2];
 push @jOz, $p->[3];
 push @mod_can_polls, $p->[4];
 }
 $self->{moderator}= join("\t", @moders);
 $self->{moderator_email}= join("\t", @jTz);
 $self->{vI}= join("\t", @kFz);
 $self->{vM}=join("\t", @jHz);
 $self->{vN}=join("\t", @jOz);
 $self->{mod_can_dopoll}=join("\t", @mod_can_polls);
}

# end of jW::jLz
1;
