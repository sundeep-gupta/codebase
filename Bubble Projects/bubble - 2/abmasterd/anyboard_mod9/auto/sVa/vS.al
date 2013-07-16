# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 912 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/vS.al)"
sub vS {
	
 $wH = '';
 local $_;

 local *mail;
 
# redo hash, arranging keys case
 my %mail2=(); my ($k, $v);
 if (ref $_[0] eq 'HASH') {
 *mail = $_[0];
 }else {
 *mail = \%mail2;
 	 while (@_){
 $k = shift @_;
 $v = shift @_;
		$mail{ucfirst lc $k} = $v;
 	}
 }
 my $smtp = $mail{Smtp} || $smtp_server ||"localhost";
 
 my $message	= $mail{Message} || $mail{Body} || $mail{Text};
 
 my $wF = $mail{From};
	unless ($wF =~ /$uD/o) {
		$wH = "Bad From address: $wF ($mail{From})";
		return;
	}	# get from email address
 $wF = $1;

 $mail{'X-mailer'} = "AnyEmail $VERSION" unless $mail{'X-mailer'};
 $mail{'X-Sender-x'} = unpack("h*", $main::ENV{REMOTE_ADDR});
	unless ($mail{'Mime-version'}) {
		 $mail{'Mime-version'} = '1.0';
	};
	unless ($mail{'Content-type'}) {
		 $mail{'Content-type'} = 'text/plain';
	};
	unless ($mail{'Content-transfer-encoding'}) {
		 $mail{'Content-transfer-encoding'} = '8bit';
	};

	unless ($mail{Date}) {
		 $mail{Date} = jSz();
	};

 $mail{To} =~ s/\n|\r/ /g;

# cleanup message, and encode if needed
 $message =~ s/^\./\.\./gm; 	# handle . as first character
 $message =~ s/\r\n/\n/g; 	# handle line ending
 $message =~ s/\n/\r\n/g;
 $message = encode_qp($message) if ($mail{'Content-transfer-encoding'} =~ /^quoted/i);

 
# cleanup smtp
 $smtp =~ s/^\s+//g; # remove spaces around $mail{Smtp}
 $smtp =~ s/\s+$//g;

 if($mail{sendmail_cmd}) {
 my $cmd =  $mail{sendmail_cmd};
 $cmd =~ s/\s+.*$//;
 unless (-x $cmd ) {
 $wH = "$cmd is not executable";
 return;
 }
 unless(open (MAIL, "|$mail{sendmail_cmd}>/tmp/smtp.err") ) {
 $wH = "When executing $smtp: $!";
 return;
 }
 	      if($mail{Mlist}) {
 	  $mail{Bcc} .= ", $mail{Mlist}";
 	      }
 my $msg = 
 	"To: $mail{To}\r\n".
 	"Cc: $mail{Cc}\r\n".
 	"Bcc: $mail{Bcc}\r\n".
 	"From: $wF\r\n".
 	"Return-Path: $wF\r\n".
 	"Subject: $mail{Subject}\r\n\r\n".
 	"$message";
 print MAIL $msg;
 close (MAIL);
 return;
 }
 
# Get recipients
# my $wD = join(' ', $mail{To}, $mail{Bcc}, $mail{Cc});
# Nice and short, but gives 'undefined' errors with -w switch,
# so here's another way:
 my $wD = "";
 $wD   .= $mail{To}        if defined $mail{To};
 $wD   .= " " . $mail{Bcc} if defined $mail{Bcc};
 $wD   .= " " . $mail{Cc}  if defined $mail{Cc};
 if($mail{Mlist}) {
 $wD .= " ".$mail{Mlist};
 }
 my @recipients = ();
 while ($wD =~ /$uD/go) {
 	push @recipients, $1;
 }
 unless (@recipients) { $wH .= "No recipient!"; return; }

 
 my $proto = getprotobyname('tcp');
 $proto= 6 if not $proto;
 
# the following produced a "runtime exception" under Win95:
# my($oE) = (getservbyname('smtp', 'tcp'))[2]; 
# so I just hardcode the oE at the start of the module: 
 my $oE = $default_smtp_port || 25;
 
 my($vP) =
 	($smtp =~ /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/)
 	? inet_aton($smtp)
 	: (gethostbyname($smtp))[4];
 
 unless (defined($vP)) {
 	$wH .= "smtp host \"$smtp\" unknown";
 	return;
 }
 
# Add info to log variable
 $vV .= "Server: $smtp Port: $oE\n"
 		   . "From: $wF\n"
 		   . "Subject: $mail{Subject}\n"
 		   . "To: ";
	
	# open socket and start mail session

 local *S;
	
 if (!socket(S, PF_INET, SOCK_STREAM, $proto)) {
 	$wH .= "socket failed ($!)";
 	return;
 }
 if (!connect(S, sockaddr_in($oE, $vP))) {
 	$wH .= "connect to $smtp failed ($!)";
 	return;
 }
 
 my($oldfh) = select(S); $| = 1; select($oldfh);
 
 my $smtpcon =\*S;
 $_ = gUaA($smtpcon);
 if (/^[45]/) {
 	close S;
 	$wH .= "service unavailable: $_";
		return ;
	}
 
 print S "helo localhost\r\n";
 $_ = gUaA($smtpcon);
 if (/^[45]/) {
 	close S;
 	$wH .= "SMTP error: $_";
		return ;
	}
 
 print S "mail from: <$wF>\r\n";
 $_ = gUaA($smtpcon);
 if (/^[45]/) {
 	close S;
 	$wH .= "SMTP error: $_";
 	return;
 }
 
 my $rcpt_cnt =0;
 my %mail_status = ();
 my $to;
 foreach $to (@recipients) {
 	print S "rcpt to: <$to>\r\n";
 	$_ = gUaA($smtpcon);
 	if (/^[45]/) {
 		$wH .= "Mail rejected for recipient ($to), SMTP server replied with error: $_\n";
 		$vV .= "!Failed: $to\n    ";
 $mail_status{$to} = "Failed: $_";
 	}
 	else {
 		$vV .= "$to\n    ";
 $rcpt_cnt ++;
 $mail_status{$to} = "Successful";
 	}
 }
 if($rcpt_cnt ==0) {
 close S;
 return;
 }
 
# send headers

 print S "data\r\n";
 $_ = gUaA($smtpcon);
 if (/^[45]/) {
 	close S;
 	$wH .= "SMTP error: $_";
 	return;
 }
 
 #Is the order of headers important? Probably not! 

 # print headers
 my @no_headers=qw(Smtp Body Message Text Mlist Bcc);
 my %no_header= map {$_=>1} @no_headers;

 foreach my $header (keys %mail) {
	next if $no_header{$header};
	$mail{$header} =~ s/\r?\n//g;
 	print S "$header: ", $mail{$header}, "\r\n";
 };
 
 #send message body and quit
 print S "\r\n",
 		$message,
 		"\r\n\r\n.\r\n"
 		;
 
 $_ = gUaA($smtpcon);
 if (/^[45]/) {
 	close S;
 	$wH .= "transmission of message failed: $_";
 	return ;
 }
 
 print S "quit\r\n";
 $_ = <S>;
 
 close S;
 return 1;
}

# end of sVa::vS
1;
