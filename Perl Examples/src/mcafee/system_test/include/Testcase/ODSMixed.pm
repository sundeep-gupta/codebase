package Testcase::ODSMixed;
use Testcase::ODS;
use MSMConst;
use strict;

our @ISA = ('Testcase::ODS');
sub new {

	my ($package, $rh_config, $log, $msm, $result_log) = @_;
	my $self = Testcase::ODS->new($rh_config, $log, $msm, $result_log);
    bless $self, $package;
    return $self;
}
sub init {
    my ($self) = @_;
    Testcase::ODS::init($self);

    my $source_dir = $self->{'config'}->{'source_dir'}; # Must be exact path rel to script command path
    my $data_dir   = $self->{'config'}->{'data_dir'};   
    my $log        = $self->{'log'};    
    unless ( -e $source_dir ) {
        $log->error("Testcase initialization error: $source_dir does not exist") if $log;
        return 0;
    }
    unless ($data_dir) {
        $log->error("Testcase initialization error: $data_dir not defined") if $log;
        return 0;
    }
        
    $data_dir = "$DATA_DIR/$data_dir";
    rmdir($data_dir) if -e $data_dir;
    mkdir($data_dir);
	print "unloading scan manager\n";
	`sudo launchctl unload /Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist`;
	print "Copying the payload";
    `cp -R $source_dir $data_dir`;
	print "loading the scanmanager\n";
	`sudo launchctl load /Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist`;
	print "Sleeping 200 sec assuming service to come up.\n";
	sleep 200;
}

sub execute {
    my ($self)     = @_;
    my $data_dir   = $self->{'config'}->{'data_dir'};
    my $log        = $self->{'log'};
    my $result_log = $self->{'result_log'};
    my $start_time = time();
    $log->info("Starting ODSMixed Scan") if $log;
    $self->_start_ods_scan($data_dir);
    $log->info("ODS Scan completed") if $log;
    $result_log->append( {'ODSMixed' => time() - $start_time } ) if $result_log;
    return 1;
}
