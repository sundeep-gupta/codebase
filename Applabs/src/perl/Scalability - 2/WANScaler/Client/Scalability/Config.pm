package WANScaler::Client::Scalability::Config;
use strict;
use warnings;
use vars qw( @ISA $VERSION );
require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(IP_LIST_FILE ACTION_FILE CLIENT_SERVICE_NAME XMLRPC_PORT);
use constant IP_LIST_FILE => 'ip_list.txt';
use constant ACTION_FILE => 'actions.txt';

use constant CLIENT_SERVICE_NAME => 'WANScalerClient';
use constant XMLRPC_PORT => '2050';

1;