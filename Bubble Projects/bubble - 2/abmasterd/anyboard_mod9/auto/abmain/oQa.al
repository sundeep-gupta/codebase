# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 4970 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/oQa.al)"
sub oQa {
	my ($dir, $dirn, $dirdesc, $eonly) = @_;
 if(not -d $dir) {
 abmain::cTz(
qq!<blockquote>
<h1>Checking setting for <i>$dirdesc</i> </h1>
<font color="red">$dirdesc does not exist</font><p>
$dirdesc was set to [ <b>$dir</b> ] in the Anyboard script ($0),
however, this directory does not exist on your web server. Please create a directory, 
make it writable (e.g., chmod 0777 directory_name), 
and assign its path to the $dirn variable in the script.<p>
<a href="$iS->{cgi}?@{[$abmain::cZa]}cmd=init">I have made the above changes, let me try again</a></blockquote>!, "Must create $dirdesc");
 abmain::iUz();
 }
 return if $eonly;
 if(not nZa($dir)) {
 abmain::cTz(
qq!<h1>Checking setting for <i>$dirdesc</i> </h1>
<blockquote><h1><font color="red">$dir is not writable</font></h1>
$dirdesc $dir is not writable by Anyboard.
Please change its permissions to make it writable <li>UNIX: chmod 0777 $dir; <li>Windows: ask your ISP to set access to full control by Iusr_ ).<p>
<a href="$iS->{cgi}?@{[$abmain::cZa]}cmd=init">I have made the above changes, try again</a></blockquote>!, "$dirdesc not  writable");
 abmain::iUz();
 }

}

# end of abmain::oQa
1;
