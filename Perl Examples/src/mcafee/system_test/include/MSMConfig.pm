package MSMConfig;

use MSMConst;
use strict;

#sub routine to fetch variable values from config file
sub get_config {
    my($self, $param) = @_;
	my $config = $self->{'config'};
    return $config->{$param};
}

sub get_testcase_config {
	my ($self, $testcase) = @_;
    return unless $_[0];
	my $testcase_config = $self->get_config('test_case_list');
    return $testcase_config->{$testcase};
}

sub get_testcase_param {
	my ($self, $testcase, $param)  = @_;
	return $self->get_testcase_config($testcase)->{$param};
}
sub new {
	my ($package) = @_;

	my $self = {};
	bless $self, $package;
	return $self;

}

sub get_testcases {
	my ($self) = @_;
	return $self->get_config('test_case_list');
}
1;
