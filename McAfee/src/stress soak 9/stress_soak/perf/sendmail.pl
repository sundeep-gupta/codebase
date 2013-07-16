#!/usr/bin/perl
use Mail::Sender;
$receiver = $ARGV[0];
 $sender = new Mail::Sender
  {smtp => '172.16.222.23', from => 'PSS_Results@virex.com'};
 $sender->MailFile({to => $receiver,
  subject => 'PSS Report File ( Keep it safe)',
  msg => "I'm sending you the list you wanted.",
  file => 'perfresult.txt' }

);cd
