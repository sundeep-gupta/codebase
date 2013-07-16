# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1687 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/wLz.al)"
sub wLz {
 my ($appname, $cgi, $vars, $dirs) = @_;
 my $i=0;
 my @sendmail_guess= ('/usr/lib/sendmail', '/usr/sbin/sendmail', '/usr/ucblib/sendmail');
 my (@rows, @rows2);
 my $pathchk;
 my $bS = $ENV{PATH_INFO};
 if($bS =~ /$ENV{SCRIPT_NAME}/) {
	$pathchk = "PATH_INFO looks bad.";
 }
 my $docroot_guess;
 if(1) {
	my $prog = $0;
	if ($prog =~ /^$appname/i && $prog !~ m!/!) {
		$prog = sVa::kZz(nFa(), $prog);
	}
	$prog =~ s/\\/\//g;
	$prog =~ s/$ENV{SCRIPT_NAME}//g;
	$docroot_guess= $prog;
 }
 push @rows2,  ["PATH_INFO", $bS, "$pathchk"];
 push @rows2, ["PATH", $ENV{PATH_TRANSLATED}, ""];
 my $test="";                  
 my $path = $ENV{PATH_TRANSLATED};
 for(@$dirs) {
 my ($varname, $vardesc, $trygen) = @$_;
 my $path = eval $varname;
 my $master_w;
 $master_w = sVa::sEa($path) if $trygen;
 $master_w = nZa($path);

 $test = "";
 if(not -e $path) {
 	$test = "<li>$vardesc $path does not exist! You must manually create it first.\n";
 }elsif(not -d $path) {
 	$test = "<li>$path is not a directory! You need to create an empty directory and assign its path to $varname. \n";
 }elsif( not $master_w ) {
 	$test .= "<li>$path is not writable! Please change the directory permission to make it writable, so the application can create files under it.\n";
 $test .= "<li>Since this is a Windows system, you can't change permission yourself, you have to ask your ISP to change the directory permission to full control for the Iusr_.\n" if $^O =~ /win/i;;
	my @darr=();
 oEa("..", \@darr, "", 0, 2);
 if(scalar(@darr)) {
		$test .= "<li>The following directories are writable:\n<pre>". join("\n", @darr[0..5]). "</pre>";
	}
 }
 if (-e $path && not -O $path) {
 	$test .= qq(<li><font color="#005555">Since $path is not owned by CGI user, you need to change directory permissions to 0777.</font>\n);
 }

 push @rows, ["<b>$vardesc</b> $varname", $path,  qq(<font color="red">$test</font>)];
 }
 push @rows,  ["CGI URL", $cgi, "Check if this matches the URL of this application. You must provide this URL when obtaining a license key."];
 push @rows, [ "Working directory", $ENV{PWD}||nFa(), "If you are not sure about the full path of the web directory, this may give you a hint"];
 push @rows,  ["<b>CGI User</b>", eval {(getpwuid($<))[0] || "unknown" }, 
 "Is the CGI user the same as your shell or ftp login ID? If not, you need to create a web directory with permissions set to 0777, then create forums under it."];
 for(@$vars) {
 my ($varname) = $_;
 my $v = eval $varname;
 my $vardesc = $varname ;
 push @rows,  ["<b><code>$vardesc</code></b>", $v, ""]; 
 }

 my $info1= sVa::fMa(rows=>\@rows, ths => [map {qq(<font color="#ffcc00">$_</font>) }("Attribute", "Value", "Comments")], sVa::oVa());

 push @rows2,  ["WEB site", $ENV{SERVER_NAME}, "If this does not match your domain name, then you must to set the fix_ variables"];
 push @rows2,  ["PERL VERSION", $], ($]< 5.004)?qq(<font color="red">Needs upgrade</font>):""];
 push @rows2, ["Script Name", $ENV{SCRIPT_NAME}, ""];
 push @rows2, ["Script File", $ENV{SCRIPT_FILENAME}, 
 "Program file=$0<br>If you are not sure about the full path of the web directory, this may give you a hint (<b>$docroot_guess</b>)."];
 push @rows2,  ["Web Server Software", $ENV{SERVER_SOFTWARE}];
 push @rows2,  ["Operating system", $^O, ""];
 push @rows2,  ["DOCROOT", $ENV{DOCUMENT_ROOT}, "Web root directory"] if -d $ENV{DOCUMENT_ROOT};
 my $sendmail_loc;
 for(@sendmail_guess) {
 $sendmail_loc = $_ if -x $_;
 }
 if($sendmail_loc) {
 	push @rows2, ["Found sendmail program", $sendmail_loc, "-t flag"];
 }

 return ($info1, sVa::fMa(rows=>\@rows2, ths => [map {qq(<font color="#ffcc00">$_</font>) }("Attribute", "Value", "Comments")], sVa::oVa()));
 
}

# end of sVa::wLz
1;
