# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 838 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/mXz.al)"
sub mXz{
 my ($mail, $localf, $data) = @_;
 $mail->{'X-mailer'}="Netbula AnyBoard(TM) $VERSION";
 if($localf) {
	if(not $data) {
 	open F, $localf or return "Fail to open file, $!";
 	my @gHz = <F>;
 	close F;
 	$data = join('', @gHz);
	}else {
	}
 my $nb = "------6161616".time().$$;
 $mail->{'Content-type'} = qq(multipart/mixed; boundary="$nb");
 $localf =~ s#^.*/##;
 my $type;
 $localf =~ /\.([^.]*)$/;
 $type = $1 || "octet-stream";
 	my %mimemap=(html=>'text/html', txt=>'text/plain', conf=>'text/plain', gif=>'image/gif', jpg=>'image/jpeg', jpeg=>'image/jpeg');
 my $lRa= $mimemap{$type} || "application/$1";
 my @marr;
 push @marr, "This is a multipart message\n\n";
 push @marr, "--$nb\r\n";
 push @marr, "Content-type: text/plain\r\n\r\n";
 push @marr, $mail->{Body};
 push @marr, "\r\n--$nb\r\n";
 push @marr, "Content-type: $lRa\r\n";
 push @marr, "Content-transfer-encoding: base64\r\n";
 push @marr, qq(Content-disposition: inline; filename="$localf"\r\n\r\n);
 push @marr, dZz::nBz($data);
 push @marr, "\r\n--$nb--\r\n";
 $mail->{Body} = join('', @marr);
 }
 $mail->{Body} .= "\n-------------------\nEmail sent by AnyBoard (http://netbula.com/anyboard/)\n";
 vS($mail);
 return $wH;
}

# end of sVa::mXz
1;
