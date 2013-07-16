use Mail::Procmail;

# Set up. Log everything up to log level 3.
print "Initializing with loglevel 3\n";
my $m_obj = pm_init ( loglevel  => 3 , debug=>1, verbose=>1);
# Pre-fetch some interesting headers.
print "Getting header now!\n";
my $m_from              = pm_gethdr("from");
print "Header is $m_from\n";
my $m_to                = pm_gethdr("to");
my $m_subject           = pm_gethdr("Subject");
print $m_subject;
