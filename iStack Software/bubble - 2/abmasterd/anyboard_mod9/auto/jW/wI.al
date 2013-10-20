# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 955 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/wI.al)"
sub wI{ 
 my ($self, $n, $p, $e, $gIz) = @_;
 my %mail;
 $mail{From} = $self->{notifier};
 $mail{To} = $e;
 $mail{Subject} = "Welcome to $self->{name}, $n";
 $mail{Cc} = $self->{admin_email} if $self->{fBz}; 
 my $on =$n;
 $n = &abmain::wS($n);

 $mail{Body} = qq(
 Welcome, $on!
 You are registered with $self->{name} 
 Username: $on 
 Password: $p
 Email:    $e
 URL:      @{[$self->fC()]}
 );
 $mail{Body} .=qq(

 To activate your account, please visit the following URL 
 $self->{cgi_full}?@{[$abmain::cZa]}cmd=activate;uname=$n;vkey=$gIz

 Some email programs may corrupt the long URL above, in that case,
 please go the page 
 $self->{cgi_full}?@{[$abmain::cZa]}cmd=tIz 
 and enter Username: $on, Validation key: $gIz
 
 After activating your account, you will be asked to use your user name and password to login.

 If you do not know what this is about, please contact the forum administrator. 
 $self->{cgi_full}

 ) if $gIz;

 $mail{Body} .= $self->{welcome_email};

 $mail{Smtp}=$self->{cQz};

 $abmain::wH = "E-mail validation disabled";
#x1
#x1
 return $abmain::wH;
} 

# end of jW::wI
1;
