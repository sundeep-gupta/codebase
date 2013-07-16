package WANScaler::Utils::Log;
use Sys::Hostname;

sub new {
	my $package = shift;
    my $file_name = shift;
	my $self = {};
    open(FH,'>'.$file_name);
    $self->{'LOG_FILE'} = FH;
	bless $self;
}
sub log_info {
	my $self = shift;
	my $message = shift;
    $message = '[INFO] ['.&get_local_ip.'] ['.&get_date_time.'] '.$message;
	syswrite($self->{'LOG_FILE'},$message."\n");
}
sub log_error {
	my $self = shift;
	my $message = shift;
    $message = '[ERROR] ['.&get_local_ip.'] ['.&get_date_time.'] '.$message;
	syswrite($self->{'LOG_FILE'},$message."\n");
}

sub log_result {
	my $self = shift;
	my $message = shift;
    $message = '[RESULT] ['.&get_local_ip.'] ['.&get_date_time.'] '.$message;
	syswrite($self->{'LOG_FILE'},$message."\n");
}

sub get_local_ip {
	my $addr = gethostbyname(&Sys::Hostname::hostname);
	my ($name,$aliases,$addrtype,$length,@addrs)= gethostbyname(&Sys::Hostname::hostname);
	return join('.',unpack('C4',$addrs[0]));
}
sub get_date_time {
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
	return  sprintf "%2d/%02d/%4d %02d:%02d:%02d",$mday,$mon,$year+1900,$hour,$min,$sec;
}
sub get_time {
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
	return  sprintf "%02d:%02d:%02d",$hour,$min,$sec;

}
1;
__END__ {
	close $self->{'LOG_FILE'};
}