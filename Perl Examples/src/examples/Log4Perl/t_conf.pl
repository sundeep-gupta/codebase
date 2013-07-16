#!/usr/bin/perl
use Log::Log4perl;
my $file = "test.log";
  my $conf = <<SUN;
    log4perl.category.Foo.Bar          = INFO, Logfile, Screen

    log4perl.appender.Logfile          = Log::Log4perl::Appender::File
    log4perl.appender.Logfile.filename = $file
    log4perl.appender.Logfile.layout   = Log::Log4perl::Layout::PatternLayout
    log4perl.appender.Logfile.layout.ConversionPattern = [\%r] \%F \%L \%m\%n

    log4perl.appender.Screen         = Log::Log4perl::Appender::Screen
    log4perl.appender.Screen.stderr  = 0
    log4perl.appender.Screen.layout = Log::Log4perl::Layout::SimpleLayout
SUN

Log::Log4perl::init(\$conf);
my $logger = Log::Log4perl::get_logger();

$logger->info("Starting $0");
$logger->error("Bad thing happened");
