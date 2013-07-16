# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4210 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/hCa.al)"
sub hCa{
 my ($self, $name) = @_;
 my @menus =(
 ["Today's new messages",  $self->{cgi}. "?@{[$abmain::cZa]}cmd=find;hIz=1"],
 [$self->{kRz},  $self->{cgi}. "?@{[$abmain::cZa]}cmd=myforum"],
 [$self->{uH} => $self->{cgi}. "?@{[$abmain::cZa]}cmd=form"],
 [$self->{sK},  $self->{cgi}. "?@{[$abmain::cZa]}cmd=yV"],
 [$self->{fKz}, $self->{cgi}. "?@{[$abmain::cZa]}cmd=dW"],
 ['Modify registration', $self->{cgi}. "?@{[$abmain::cZa]}cmd=xV"],
 ["Forum Archive", $self->pRa()],
 [$self->{wV} => $self->{cgi}. "?@{[$abmain::cZa]}cmd=log"],
 ['Help', $abmain::uE]
 );
 my $str=qq! function loadMenu$name() { window.m$name = new Menu("$name");!;

 $str .= qq! window.pmenu=new Menu("pm"); window.pmenu.oKz("Click $self->{uH} to add new message"); !;
 for(@menus) {
 next if ($_->[1] =~ /myforum$/) && not $self->{kWz};
 $_->[0] =~ s/'/\\'/g;
 $str.= qq!window.m$name.oKz('$_->[0]', "location='$_->[1]'");!;
 }
 $str .=qq!
 	 m$name.fontColor = "#ffffff";
 	 m$name.bgColor = "#AAAAAA";
 	 m$name.pNz = "#000000";
 	 m$name.nYz = "#6699CC";
 	 m$name.nZz();
 m$name.enableTracker = true;
 !;
 $str .= qq!}\n!;
 
}

# end of jW::hCa
1;
