# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5306 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yLa.al)"
sub yLa {
 my ($self, $form) = @_;
 $self->eMaA( [qw(other_header other_footer form_banner)]);

my $header =$self->{other_header};
my $footer =$self->{other_footer};
my $xstyle ;
$xstyle = abmain::htmla_code() if $abmain::htmla;
my $gU = qq(<html> <head><title>Post: $self->{name}</title>);
if(length($header)< 5 ) {
$gU .= qq( 
$self->{sAz}
$xstyle
</head><body> <center>
<h1> <font COLOR="#DC143C">$self->{name}</font> </h1>
<HR NOSHADE WIDTH="80%"> </center>
<br/>
);
}else {

 $header =~ s!</head>!$self->{sAz}$xstyle</head>!i;
 $gU .= $header;
}

$gU .= $self->{form_banner};
 

$gU .= qq@
 <a name="post"></a>
@;

$gU .= $form;

my $inithtmla;
if($abmain::htmla) {
	$inithtmla=qq!\n<script type="text/javascript" defer="1"> HTMLArea.replace("htmlbody");</script>\n!;
}

$gU .= $inithtmla;

if(length($footer)<10) {
	$gU .= qq(<p><hr><p></body></html>);
}else {

 $gU .= $footer;
}

return $gU;

}

# end of jW::yLa
1;
