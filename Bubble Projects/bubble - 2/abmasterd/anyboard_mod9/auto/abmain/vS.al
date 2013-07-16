# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 7961 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/vS.al)"
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
#		$mail{ucfirst lc $k} = $v;
		$mail{$k} = $v;
 	}
 }
 my $smtp = $mail{Smtp} || $abmain::smtp_server;
 my $max_recip = $mail{MAX_RECIP};
 delete $mail{Smtp}; 
 delete $mail{MAX_RECIP}; 
 
 my $message	= $mail{Message} || $mail{Body} || $mail{Text};
 delete($mail{Message})
 || delete($mail{Body})
 || delete($mail{Text}); 
 
 my $wF = $mail{From};
	unless ($wF =~ /$abmain::uD/o) {
		$wH = "Bad From address: $wF ($mail{From})";
		return;
	}	# get from email address
 $wF = $1;

 $mail{'X-mailer'} = "AnyBoard $VERSION" unless $mail{'X-mailer'};

# Default MIME headers if needed
	unless ($mail{'Mime-version'}) {
		 $mail{'Mime-version'} = '1.0';
	};
	unless ($mail{'Content-type'}) {
		 $mail{'Content-type'} = 'text/plain; charset="iso-8859-1"';
	};
	unless ($mail{'Content-transfer-encoding'}) {
		 $mail{'Content-transfer-encoding'} = '8bit';
	};

# add Date header if needed
	unless ($mail{Date}) {
#		 $mail{Date} = jSz();
	};

# cleanup message, and encode if needed
 $message =~ s/^\./\.\./gm; 	# handle . as first character
 $message =~ s/\r\n/\n/g; 	# handle line ending
 $message =~ s/\n/\r\n/g;
 $message = encode_qp($message) if ($mail{'Content-transfer-encoding'} =~ /^quoted/i);

 
# cleanup smtp
 $smtp =~ s/^\s+//g;
 $smtp =~ s/\s+$//g;

 if($smtp eq $abmain::sendmail_cmd || $abmain::use_sendmail_cmd) {
 $smtp = $abmain::sendmail_cmd;
 my $cmd = $smtp;
 $cmd =~ s/\s+.*$//;
 unless (-x $cmd ) {
 $wH = "$cmd is not executable";
 return;
 }
 unless(open (MAIL, "|$smtp>$abmain::master_cfg_dir/smtp.err") ) {
 $wH = "When executing $smtp: $!";
 return;
 }
 	      if($mail{Mlist}) {
 if($mail{Bcc}) {
 	   $mail{Bcc} .= ", $mail{Mlist}";
 }else {
 	   $mail{Bcc} = $mail{Mlist};
 }
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
 my @fUa = ();
 while ($wD =~ /$abmain::jQz/go) {
 	push @fUa, $1;
 }
 unless (@fUa) { $wH .= "No recipient!"; return; }
 if($max_recip >0 && @fUa > $max_recip) { $wH .="Too many recipients"; return;}

 delete $mail{Bcc};
 delete $mail{Mlist};
 
 eval {
	use Socket;
 };

 my $proto = getprotobyname('tcp');
 #abmain::error('sys', "Fail to retrieve TCP proto: $!") if !$proto;
 $proto= 6 if not $proto;
 
# the following produced a "runtime exception" under Win95:
# my($oE) = (getservbyname('smtp', 'tcp'))[2]; 
# so I just hardcode the oE at the start of the module: 
 my $oE = $abmain::default_smtp_port;
 
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
 if($@) {
 	$wH .= "Import Sokcet module failed ($@)";
	return;
 }
	
 if (!socket(S, PF_INET, SOCK_STREAM, $proto)) {
 	$wH .= "socket failed ($!)";
 	return;
 }
 if (!connect(S, sockaddr_in($oE, $vP))) {
 	$wH .= "connect to $smtp failed ($!)";
 	return;
 }
 
 my($oldfh) = select(S); $| = 1; select($oldfh);
 
 $_ = <S>;
 if (/^[45]/) {
 	close S;
 	$wH .= "service unavailable: $_";
		return ;
	}
 
 print S "helo localhost\r\n";
 $_ = <S>;
 if (/^[45]/) {
 	close S;
 	$wH .= "SMTP error: $_";
		return ;
	}
 
 print S "mail from: <$wF>\r\n";
 $_ = <S>;
 if (/^[45]/) {
 	close S;
 	$wH .= "SMTP error: $_";
 	return;
 }
 
 my $rcpt_cnt =0;
 %mail_status = ();
 my $to;
 foreach $to (@fUa) {
 	print S "rcpt to: <$to>\r\n";
 	$_ = <S>;
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
 $_ = <S>;
 if (/^[45]/) {
 	close S;
 	$wH .= "SMTP error: $_";
 	return;
 }
 



 my $header;
 foreach $header (keys %mail) {
 	print S "$header: ", $mail{$header}, "\r\n";
 };
 

 print S "\r\n",
 		$message,
 		"\r\n\r\n.\r\n"
 		;
 
 $_ = <S>;
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

# end of abmain::vS
1;
