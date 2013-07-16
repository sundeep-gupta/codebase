package Stress::Config;

require Exporter;
our @ISA = qw(Exporter);

my $TEST_CONFIG = {
    'disk_snapshot'  => 300,
    'test_case_list' => {
			'soak_clean' => 1,
			'soak_mixed' => 1,
			'stress_clean' => 0,
			'stress_mixed' => 0,
			},
};



1;
