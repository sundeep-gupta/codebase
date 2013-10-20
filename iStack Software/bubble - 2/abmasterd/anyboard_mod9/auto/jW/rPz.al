# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7949 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/rPz.al)"
sub rPz {
 my ($self) = @_;
 $self->oF(LOCK_EX, 6);
 my $srf = abmain::kZz($self->nDz('qUz'), $self->{pollidxfile}||"index.html");
 open F2, ">$srf" or abmain::error('sys', "On writing file $srf: $!");
 $self->eMaA( [qw(other_header other_footer)]);
 print F2 "<html><head>$self->{sAz}\n<title> Polls for $self->{name}</title>$self->{other_header}";
 my $all= eval { $self->rQz() };
 print F2 $all;
 print F2 $self->{other_footer};
 close F2;
 $self->pG(6);
 $self->oF(LOCK_EX, 6);
 open F2, ">".abmain::kZz($self->nDz('qUz'), "index.js");
 print F2 abmain::rLz($all);
 close F2;
 $self->pG(6);
}

# end of jW::rPz
1;
