use Net::SMTP::Receive;

MyMailReceiver->showqueue();
MyMailReceiver->runqueue();
MyMailReceiver->server({IPAddr=>"smtp.applabs.com",port => 25});
