use Log::Log4perl;
my $log_conf = q/ 
log4perl.appender.Logfile.filename = newfile.log
/;


Log::Log4perl::init("logger.conf");
#Log::Log4perl::init(\$log_info);
my $logger = Log::Log4perl::get_logger();

$logger->info("Starting $0");
$logger->error("Bad thing happened");

