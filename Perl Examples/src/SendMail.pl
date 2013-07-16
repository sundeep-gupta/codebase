 use Mail::Sendmail;

  %mail = ( smtp	=> "smtp.applabs.com",
	    To      => 'sundeep.gupta@applabs.com',
            From    => 'sundeep.gupta@applabs.com',
            Message => "This is a very short message"
           );

  sendmail(%mail) or die $Mail::Sendmail::error;

  print "OK. Log says:\n", $Mail::Sendmail::log;