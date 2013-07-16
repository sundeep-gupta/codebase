use strict;
use Mail::Sendmail;
#Current recipient(s): 'Sendmail Test <sendmail@alma.ch>'
#Server set to: mail.alma.ch

sendNotificationMail( 
    { 
	    'dateReceived' => '23-39-29',
		'from' => 'sundeep.753@gmail.com',
		'subject' => 'Test Subject',
	}, 
    {'notifyFromEmail'=> 'sundeep_gupta@mcafee.com',
        'emailPrefix' => 'TESTMAIL',
		'notificationEmails' => ['sundeep.techie@gmail.com'],

    }, 
	"HelloWorld");

sub sendNotificationMail {
    my ($email, $config, $message) = @_;
    if (scalar(@{$config->{'notificationEmails'}}) > 0) {
        my $mail = {
		'smtp' => 'send.one.com',
                'auth' => { 'user' => "sundeep\@funstation.in", 'password' => 'sundeep' , 'required' => 1, method=>"DIGEST-MD5"},
                'From' => 'sundeep@funstation.in', # $config->{'notifyFromEmail'},
                'Subject' => $config->{'emailPrefix'} . " : " . $email->{'hostname'},
                'Message' => $message,
   #            'Data' => $email->{'dateReceived'} . ',' . $email->{'from'} . ',' .$email->{'subject'} . ',' . $message,
        };
        for my $notificationEmail (@{$config->{'notificationEmails'}}) {
            $mail->{'To'} = $notificationEmail;
            unless (sendmail(%$mail)) {
			    print "Failed to send email\n"; print $Mail::Sendmail::error, "\n";
            }
        }
    }
}

