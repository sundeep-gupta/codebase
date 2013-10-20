#!/usr/bin/perl
use CGI qw(:standard);

print header;
print start_html(-head=>meta({-http_equiv => 'refresh',
                                    -content    => '15'}));
$status2 = `/usr/local/bin/sudo -u root ipfw pipe show`;
my @fields = split(/\s+/,$status2);
print "<table cellspacing=0 cellpadding=4 border=0>
	<tr>
		<td bgcolor=gray colspan=2 align=center><b>current dummynet status</b></td>
	</tr>
	<tr>
		<td align=right><b>Bandwidth:</b></td><td>$fields[1]";
if ($fields[1] =~ /unlimited/){
	print "</td>";
} else {
	print " $fields[2]</td>";
}
print "</tr>
	<tr>
		<td align=right><b>Delay:</b></td><td>";
if ($fields[1] =~ /unlimited/) {
	print "$fields[2] $fields[3]</td>";
} else {
	print "$fields[3] $fields[4]</td>";
}
print "</tr>
	<tr>
		<td align=right><b>Queue Slots:</b></td><td>";
if ($fields[1] =~ /unlimited/) {
	print "$fields[4]</td>";
} else {
	print "$fields[5]</td>";
}
print "</tr>
	<tr>
		<td align=right><b>Packet Loss Rate:</b></td>";
if ($fields[1] =~ /unlimited/) {
	if ($fields[6] =~/\./) {
		$plr = $fields[6];
	} else {
		$plr = 0;
	}
} else {
	if ($fields[7] =~/\./) {
		$plr = $fields[7];
	} else {
		$plr = 0;
	}
}
print "<td>$plr</td>
	</tr>
	</table>";

print "$status";
print "epoch time: " . time();
print end_html;
exit;
