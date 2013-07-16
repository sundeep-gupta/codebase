use IO::Socket::INET;
use Digest::HMAC_MD5 qw(hmac_md5_hex);


sub use_smtp {
	$| = 1;
#	my ($code, $text, $more);
#	my (%features);
	my ($proto)    = (getprotobyname('tcp'))[2];
	my ($port)     = (getservbyname('smtp', 'tcp'))[2] || 25;
	my ($smtpaddr) = ($smtp_server =~ /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/) ? pack('C4', $1, $2, $3, $4) : (gethostbyname($smtp_server))[4];
	$sendlog = "";
	$auth_ok = 0;

	# Connect to the SMTP server.
	$sock = IO::Socket::INET->new(
		PeerAddr => $smtp_server,
		PeerPort => $port,
		Proto => 'tcp',
		Timeout => 5)
		# Check if the service is available and parse any errors
		or &fatal_error("$smtp_txt{'unavail'}");

	&get_line;
	&say_hello ($smtp_server) or exit (1);

	if (defined ($features{'AUTH'}) && $smtp_auth_required) {
		# Try CRAM-MD5 if supported by the server
		if ($auth_ok == 0 && ($features{'AUTH'} =~ /CRAM-MD5/i || $smtp_auth_required == 3 || $smtp_auth_required == 4)) {
			&send_line ("AUTH CRAM-MD5\r\n");
			($code, $text, $more) = &get_line;
			if ($code != 334 && $smtp_auth_required != 4)
			{
				&fatal_error("$smtp_txt{'error'} [$code]: $smtp_txt{$code}<br /><br /><b>$smtp_txt{'5'}</b><br />$sendlog");
#				return 0;
			}
			my $response = &encode_cram_md5 ($text, $authuser, $authpass);
			&send_line ("%s\r\n", $response);
			($code, $text, $more) = &get_line;
			if ($code != 235 && $smtp_auth_required != 4)
			{
				&fatal_error("$smtp_txt{'error'} [$code]: $smtp_txt{$code}<br /><br /><b>$smtp_txt{'5'}</b><br />$sendlog");
#				return 0;
			}
			$auth_ok = 1;
		}
		# Or try LOGIN method
		elsif ($auth_ok == 0 && ($features{'AUTH'} =~ /LOGIN/i  || $smtp_auth_required == 2 || $smtp_auth_required == 4)) {
			&send_line ("AUTH LOGIN\r\n");
			($code, $text, $more) = &get_line;
			if ($code != 334 && $smtp_auth_required != 4)
			{
				&fatal_error("$smtp_txt{'error'} [$code]: $smtp_txt{$code}<br /><br /><b>$smtp_txt{'5'}</b><br />$sendlog");
#				return 0;
			}
			
			&send_line ("%s\r\n", encode_smtp64 ($authuser, ""));

			($code, $text, $more) = &get_line;
			if ($code != 334 && $smtp_auth_required != 4)
			{
				&fatal_error("$smtp_txt{'error'} [$code]: $smtp_txt{$code}<br /><br /><b>$smtp_txt{'5'}</b><br />$sendlog");
#				return 0;
			}
			&send_line ("%s\r\n", encode_smtp64 ($authpass, ""));
			($code, $text, $more) = &get_line;
			if ($code != 235 && $smtp_auth_required != 4)
			{
				&fatal_error("$smtp_txt{'error'} [$code]: $smtp_txt{$code}<br /><br /><b>$smtp_txt{'5'}</b><br />$sendlog");
#				return 0;
			}
			$auth_ok = 1;
		}
		# Or finally PLAIN if nothing else was supported.
		elsif ($auth_ok == 0 && ($features{'AUTH'} =~ /PLAIN/i || $smtp_auth_required == 1 || $smtp_auth_required == 4)) {
			&send_line ("AUTH PLAIN %s\r\n", 
			encode_smtp64 ("$authuser\0$authuser\0$authpass", ""));
			($code, $text, $more) = &get_line;
			if ($code != 235 && $smtp_auth_required != 4)
			{
				&fatal_error("$smtp_txt{'error'} [$code]: $smtp_txt{$code}<br /><br /><b>$smtp_txt{'5'}</b><br />$sendlog");
#				return 0;
			}
			$auth_ok = 1;
		}
		# Decide to complain about advertised methods not supported.
		else
		{
			&fatal_error("$smtp_txt{'error'} : $smtp_txt{'notsupported'}<br /><br /><b>$smtp_txt{'5'}</b><br />$sendlog");
#			return 0;
		}
	}
	
	# build the Date per RFC822 - uses gmtime to create date & time stamp
	($smtpsec, $smtpmin, $smtphour, $smtpmday, $smtpmon, $smtpyear, $smtpwday, $smtpyday, $smtpisdst) = gmtime($date + (3600 * $timeoffset));
	$smtpyear       = sprintf("%02d", ($smtpyear - 100));
	$smtpyear       = qq~20$smtpyear~;
	$smtptimestring = qq~$days_short[$smtpwday], $smtpmday $months[$smtpmon] $smtpyear $smtphour\:$smtpmin\:$smtpsec 0000~;

	# Fill the mail from field
	&send_line ("MAIL FROM: <$from>\r\n");
	($code, $text, $more) = &get_line;

	# Add as many addressees as needed
	foreach (split(/, /, $to)) {
		&send_line ("RCPT TO: <$_>\r\n");
		($code, $text, $more) = &get_line;
	}

	# Send message data
	&send_line ("DATA\r\n");
	($code, $text, $more) = &get_line;
	&send_line ("To: $toheader\r\n");
	&send_line ("Date: $smtptimestring\r\n");
	&send_line ("From: $fromheader\r\n");
	&send_line ("X-Mailer: YaBB SMTP\r\n");
	&send_line ("Subject: $subject\r\n\r\n");
	&send_line ("$message");
	&send_line ("\r\n.\r\n");

	# It is polite to close the door behind you
	&send_line ("QUIT\r\n");
#	&fatal_error("$sendlog");
	return 1;
}

# Get one line of response from the server.
sub get_line {
	my ($code, $sep, $text) = ($sock->getline() =~ /(\d+)(.)([^\r]*)/);
	my $more;
	$code =~ s/ //g;
	if ($sep eq "-") { $more = 1; } else { $more = 0; }
	$sendlog .= qq~S:$code $text $sep~;
	$sendlog .= qq~<br />~;
	return ($code, $text, $more);
}


# Send one line back to the server
sub send_line (@) {
	my @args = @_;
#	$args[0] =~ s/\n/\r\n/g;
	$sendlog .= qq~C:$args[0]~;
	$sendlog =~ s/\r\n//g;
	$sendlog .= qq~<br />~;
	$sock->printf (@args);
}

# Helper function to encode CRAM-MD5 challenge
sub encode_cram_md5 ($$$) {
	my ($ticket64, $username, $password) = @_;
	my $ticket = decode_smtp64($ticket64) or
		die ("Unable to decode Base64 encoded string '$ticket64'\n");
	
	my $password_md5 = hmac_md5_hex($ticket, $password);
	return encode_smtp64 ("$username $password_md5", "");
}

sub say_hello ($) {
	my ($hello_host) = $_[0];
	my ($feat, $param);
	#send RFC2821 compliant identifyer
	&send_line ("EHLO $hello_host\r\n");
	($code, $text, $more) = &get_line;
	if($code != 250){
		#try sending an old RFC281 compliant identifyer (older Exchange servers)
		&send_line ("HELO $hello_host\r\n");
	}
	($code, $text, $more) = &get_line;
	if($code == 250){
		&read_features(\%features);
	}
	return 1;
}
	
sub read_features ($) {
	my ($featref) = $_[0];
	# Empty the hash
	%{$featref} = ();
	($feat, $param) = ($text =~ /^(\w+)[= ]*(.*)$/);
	$featref->{$feat} = $param;

	# Load all features presented by the server into the hash
	while ($more == 1) {
		($code, $text, $more) = &get_line;
		($feat, $param) = ($text =~ /^(\w+)[= ]*(.*)$/);
		$featref->{$feat} = $param;
	}
	return 1;
}

1;