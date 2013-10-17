package WANScaler::MSILibrary;
use Data::Dumper;
use Time::HiRes qw(gettimeofday);
use Exporter;
our @ISA = ('Exporter');
our @EXPORT = qw($msi_err);
my $msi_err = undef;
#WANScaler::MSILibrary->install('WANScalerClientWin32-release-0.0.0-700.msi');
sub install {
	my($self, $filename) = @_;
    my $log_file = 'mylog.txt';
	my $cmd = "msiexec /qn /i $filename /le $log_file /norestart ALLUSERS=1 2> err.txt";
	syswrite(\*STDOUT,$cmd);
    system $cmd;
    open(FH,$log_file);
    my @lines = <FH>;
    close(FH);
	unlink($log_file);
	unlink('err.txt');
	return [@lines];
}
1;