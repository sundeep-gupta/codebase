#!/usr/bin/perl

print <<HTML;
Content-type: text/html

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html">

<body>
<table cellspacing="0" cellpadding="0" border="0">
<tr class="subhead" align="Left"><th>Name</th><th>Value</th></tr>
HTML

my $class;

foreach (sort keys %ENV) {
	next unless /^HTTP_|^REQUEST_/;
	
	print <<HTML;
<tr><td valign="top">$_</td><td>$ENV{$_}</td></tr>
HTML
}

print <<HTML;
</table>
</body>
</html>
HTML
