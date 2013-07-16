
package Virex;
require Exporter;

use Time::Local;
use MSMConfig;

my $ROOT_DIR = $MSMConfig::ROOT_DIR;
print "ROOT DIR is $ROOT_DIR\n";
# Author: Harish Garg, Shreyas Rao, Sanjeev Gupta McAfee, Inc.
# 

our @ISA       = qw(Exporter);
our @EXPORT    = qw( ConfigReaderValue  Plister CreateFilesPSS);    # Symbols to be exported by default
our $VERSION   = 1.00;         # Version number

#####################################
# Sub-routine to find out whether a sample scan results in a detection or not. expects path to the engine log and the sample path

# Expects the dat and gives back the logid

# Open Files one by one for on access scanner to catch. expects the sample path

#####################################
#sub routine to fetch variable values from config file
sub ConfigReaderValue() {
    my($config) = @_;
    return $MSMConfig::rh_config->{$config};
}
#***************************************************************************************************
#***************************************************************************************************
#sub routine to calculate time taken for a scan

sub CreateFilesPSS() {

    my $type = shift;

    # Delete the existing files and create the directory.
    `rm -rf $DATA_DIR/oas_test`;
    mkdir ("$DATA_DIR/oas_test");

    for (my $i = 0 ; $i <= 100000; $i++) {
        print "10000 files written...\n" unless ( $i % 10000);
        open(FP,"> $DATA_DIR/oas_test/$type.$i");   
        print FP $CLEAN_DATA if $type eq $OAS_CLEAN_TEST;
        print FP $MIXED_DATA if $type eq $OAS_MIXED_TEST;
        close (FP);
    }

}


#*******************************************************************************************
#*******************************************************************************************
#changes a plist file and enables it for Virex

sub ChangePlist() {
    print "IN PLIST SUBROUTINE \n";
    my( $opt,$pref_opt) = @_;
    print "$ENV{ROOT_PATH}/PrefChanger -k $opt -v $pref_opt\n"; 
    system("$ENV{ROOT_PATH}/PrefChanger -k $opt -v $pref_opt");


# sleeping for 5 mins because OAS scanner lots of time to come back
sleep 50;

}
#*******************************************************************************************


