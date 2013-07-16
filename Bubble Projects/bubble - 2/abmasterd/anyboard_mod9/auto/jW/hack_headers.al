# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1345 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/hack_headers.al)"
sub hack_headers{
 my ($self) = @_;
 if($self->{forum_footer} ne "" || $self->{forum_layout}) {
	$self->{forum_header} = qq(<html><head></head><body>) if $self->{forum_header} !~ /<html>/i;
	$self->{forum_layout} = qq(FORUM_TOP_BANNER<br/>FORUM_MSG_AREA<br/>FORUM_BOTTOM_BANNER)
			 if $self->{forum_layout} !~ /FORUM_MSG_AREA/;
	$self->{forum_layout_new} = $self->{forum_header}.$self->{forum_layout}.$self->{forum_footer}; 
 }
 $self->{forum_layout_new} =~ /(<html>.*?<body.*?>)(.*)$/is;
 $self->{forum_layout} = $2;
 $self->{forum_header} = $1;

 if($self->{other_footer} ne "" || $self->{other_header} ne "") {
	$self->{other_page_layout} = qq(<html><head>).$self->{other_header}.qq(PAGE_CONTENT).$self->{other_footer}; 
 }
 $self->{other_page_layout} =~ /<html>.*?<head>(.*?)\bPAGE_CONTENT\b(.*)$/is;
 $self->{other_header} = $1;
 $self->{other_footer} = $2;

 if($self->{msg_footer} ne "" || $self->{msg_header} ne "") {
	$self->{msg_template} = qq(<html><head>).$self->{msg_header}.qq(PAGE_CONTENT).$self->{msg_footer}; 
 }
 $self->{msg_template} =~ /<html>.*?<head>(.*?)\bPAGE_CONTENT\b(.*)$/is;
 $self->{msg_header} = $1;
 $self->{msg_footer} = $2;
}

# end of jW::hack_headers
1;
