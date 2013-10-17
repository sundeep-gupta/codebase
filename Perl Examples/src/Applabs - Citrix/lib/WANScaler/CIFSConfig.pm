#!/usr/bin/perl
package WANScaler::CIFSConfig;
use strict;
use vars qw(@ISA);
require Exporter;
@ISA = ('Exporter');
our @EXPORT = qw (START_DRIVE_LETTER START_INDEX END_INDEX INPUT_FILE_NAME
				  SHARE_COUNT $n_e_gateway $machine_start_address
                  $network_address $third_octet
                  );

use constant START_DRIVE_LETTER => 'G';
use constant START_INDEX 		=> 0;
use constant END_INDEX		 	=> 5;
use constant INPUT_FILE_NAME 	=> 'thinktime.txt';
use constant SHARE_COUNT		=> 20;

use constant LARGE_FILES_DIR 	=> 'LargeFiles45';
use constant SMALL_FILES_DIR 	=> 'SmallFiles';
use constant BROWSE_DIR			=> 'Browse';

my $n_e_gateway = '10.1.1.200';
my $network_address = '10.1.';
my $third_octet = 4;
my $machine_start_address = 30;

1;