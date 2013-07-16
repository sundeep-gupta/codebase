package WANScaler::Library::Logger;
use vars qw(@ISA) ;
require Exporter;
@ISA = ('Exporter');
our @Export = ('logwrite');
sub logwrite {
	my ($handle, $msg) = @_;
    syswrite($handle, $msg."\n");
}
1;