# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4960 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/uBz.al)"
sub uBz {
 my ($self, $eid) = @_;
 my $edir = $self->nDz('evedir');
 my $efile = abmain::kZz($edir, "$eid.eve");
 my $eveform = aLa->new("eve", \@abmain::uHz);
 $eveform->load($efile);

 my @rows;
 push @rows, [$eveform->{eve_subject}];
 push @rows,  ["<b>$self->{tNz}</b>", $eveform->rQa("eve_start")." <b>to</b> ". $eveform->rQa('eve_end') ];
 push @rows,  ["<b>$self->{uJz}</b>", $eveform->rQa('eve_location') ];
 push @rows,  ["<b>$self->{uUz}</b>", $eveform->{eve_description}];
 push @rows,  ["<b>$self->{uDz}</b>", $eveform->{eve_status}];
 push @rows,  ["<b>$self->{uVz}</b>", $eveform->{eve_org}];
 push @rows,  ["<b>$self->{uCz}</b>", $eveform->{eve_contact}];
 push @rows,  [abmain::cUz("#EVETOP",  "Top").'&nbsp; &nbsp;'.
 abmain::cUz($self->{cgi}. "?@{[$abmain::cZa]}cmd=tQz;eveid=$eid", "Delete") 
 . "\&nbsp;\&nbsp;\&nbsp;"
 . abmain::cUz($self->{cgi}. "?@{[$abmain::cZa]}cmd=modeveform;eveid=$eid", "Modify")
 . "\&nbsp;\&nbsp;\&nbsp;"
 . abmain::cUz($self->{cgi}. "?@{[$abmain::cZa]}cmd=tYz;eveid=$eid", $eveform->{eve_can_sign}?"Sign up":undef)
 . "\&nbsp;\&nbsp;\&nbsp;"
 . abmain::cUz($self->{cgi}. "?@{[$abmain::cZa]}cmd=vsl;eveid=$eid", $eveform->{eve_can_sign}?"List":undef)
 ]; 
 return sVa::fMa(rows=>\@rows, $self->oVa()); 
}

# end of jW::uBz
1;
