use Mail::Sender;

$sender = new Mail::Sender ({smtp => "smtp.applabs.com", from => 'sundeep.gupta@applabs.com'});
#$sender->MailFile({to => 'sundeep.gupta@applabs.com',subject => 'Here is the file', msg => "I'm sending you the list you wanted.",
#				  file => 'OpenMail.pl'});
$sender->Open({from => "sundeep.gupta@applabs.com" ,
				smtp    => "smtp.applabs.com"});
print "Finished";
#Open([from [, replyto [, to [, smtp [, subject [, headers]]]]]])
#new Mail::Sender ([from [,replyto [,to [,smtp [,subject [,headers [,boundary]]]]]]])
# new Mail::Sender {[from => 'somebody@somewhere.com'] , [to => 'else@nowhere.com'] [...]}
#
