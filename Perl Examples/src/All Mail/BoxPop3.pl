use Mail::Box::POP3;
 my $url = 'pop3://jagdish.chittala:jagdish12@172.16.2.2';
#'pop3://user:password@pop.xs4all.nl'
 my $pop = Mail::Box::POP3->new($url);
# my $pop = $mgr->open(type => 'pop3',
 #   username => 'sundeep.gupta', password => 'hash@dollar',
  #  server_name => '172.16.2.2');
