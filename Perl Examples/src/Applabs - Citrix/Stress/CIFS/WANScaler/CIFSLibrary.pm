#!/usr/bin/perl
package WANScaler::CIFSConfig;
use strict;
use vars qw(@ISA @EXPORT);
require Exporter;
@ISA = ('Exporter');
our @EXPORT = qw (START_DRIVE_LETTER START_INDEX END_INDEX INPUT_FILE_NAME N_E_GATEWAY BROWSE_DIR
				  SHARE_COUNT $n_e_gateway $machine_start_address
                  $network_address $third_octet LARGE_FILES_DIR SMALL_FILES_DIR

                  );
#my @_constants {
use constant { START_DRIVE_LETTER => 'G',
				START_INDEX 		=> 0,
				END_INDEX		 	=> 5,
				INPUT_FILE_NAME 	=> 'thinktime.txt',
				SHARE_COUNT			=> 40,
                N_E_GATEWAY 		=> '10.1.1.200',
				LARGE_FILES_DIR 	=> 'LargeFiles45',
				SMALL_FILES_DIR 	=> 'SmallFiles',
				BROWSE_DIR			=> 'Browse',
             };

my $n_e_gateway = '10.1.1.200';
my $network_address = '10.1.';
my $third_octet = 4;
my $machine_start_address = 30;
1;