package WANScaler::Client::Library;
#use lib qw(../../);
use vars qw(@ISA);
use WANScaler::Client::Scalability::Config;
use Win32::Service;
use Data::Dumper;
require Exporter;
@ISA = qw(Exporter);
#WIndows Service related constants...  from microsoft's SERVICE_STATUS
use constant SERVICE_RUNNING => 0x0004;
use constant SERVICE_START_PENDING => 0x0002;
use constant SERVICE_STOPPED => 0x0001;
use constant SERVICE_STOP_PENDING => 0x0003;

#$service_status = {
#          'ServiceSpecificExitCode' => 0,
#          'CurrentState' => 4,
#          'ServiceType' => 272,
#          'CheckPoint' => 0,
#          'ControlsAccepted' => 5,
#          'WaitHint' => 0,
#          'Win32ExitCode' => 0
#S        };

enable_client();


sub enable_client {
	my $status = {};
	Win32::Service::GetStatus('',CLIENT_SERVICE_NAME,$status);
    if ($status->{'CurrentState'} == SERVICE_RUNNING
    and $status->{'CheckPoint'} == 0
    and $status->{'WaitHint'} == 0 ) {
    	print 'Already Started';
        return 1;
    }

	my $ret = Win32::Service::StartService('',CLIENT_SERVICE_NAME);
	return $ret if $ret != 1;

    print Dumper($ret);
  	Win32::Service::GetStatus('',CLIENT_SERVICE_NAME,$status);
    print Dumper($status);

    return 1;

}

sub disable_client {
}

sub configure_client {
	# TODO:
}
sub install_client {
}
sub uninstall_client {
}

1;