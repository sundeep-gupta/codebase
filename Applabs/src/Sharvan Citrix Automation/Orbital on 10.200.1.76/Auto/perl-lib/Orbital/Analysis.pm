#!/usr/local/bin/perl
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.19 $
# Last Modified: $Date: 2005/08/18 23:56:23 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbital/control/perl-lib/Orbital/Analysis.pm,v $
#
####################################################################################
##
##

use lib qw(/usr/local/lib/perl5/5.8.6 /usr/local/orbital/console/perl-lib);
use strict;
use Orbital::Config;
use Orbital::Database;
use Orbital::Output;
use Data::Dumper;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# results_analysis() - Method that analyzes our results from the Visual Test scripts and returns the analysis (pass/fail)
# Input:  $testrun_results  - Hash reference containing the results from the test run instance
#         $instance_details - Hash containing extra information about the test run instance (i.e. start time, end time, etc.)
# Output: Hash containing our analyzed results
sub results_analysis {
    my($testrun_results,$instance_details) = @_;

    # Analyzed results data structure to return
    my %analyzed_results;

    # Define the default analysis type
    my $analysis_type;

    # Display results header
    print display_output_header("Analysis Results") if ($CONFIG->{'VERBOSE'} > 0);
    
    # Iterate through each instance
    while(my($instance_id, $instance) = each(%$testrun_results)) {

        my $result;  # Result of whether a test passed or failed
        my @reason;  # List of reasons why a test failed. (If test passed, this is empty)
        my $analysis_status = "pass";  # We set our initial analysis status as pass, till a failure occurs, then we fail
        my @elapsed_times = ();        # This is a list of elapsed time values for each Visual Test script run (only for client machines)
        
        # Iterate through each machine set (either client/server pairs or clients-to-server sets)
        while(my($set_count, $set_results) = each(%$instance)) {
            my $client = $set_results->{'client'};   # Client machine(s) results
            my $server = $set_results->{'server'};   # Server machine(s) results

            # Put all machine results into an array
            my @machine_results;

            # Reset our default analysis type
            $analysis_type = "COMPARISON";
            
            # Define our current machine results data structure
            my $client_data_structure;
            my $server_data_structure;
            
            # If our data structure is an array, count the number of elements in the array
            my $client_element_count = 0;
            my $server_element_count = 0;
            my $client_ecount_defined = "false";
            my $server_ecount_defined = "false";

            # Fetch all client machine results (should default to at least 1 machine)
            CLIENT_RESULTS:
            while(my($machine_count,$machine) = each(%$client)) {
                # Check what kind of data structure exists as our analysis item
                if (ref($machine->{'analysis_elements'}->{'analysis_item'}) eq 'HASH') {
                    # Check if any analysis items exist
                    if (exists($machine->{'analysis_elements'}->{'analysis_item'}->{'type'}) && $machine->{'analysis_elements'}->{'analysis_item'}->{'type'} eq "none") {
                        $analysis_type = "SOLE_COMPARISON";
                    }
                    
                    # Define our client results data structure
                    $client_data_structure = "HASH";
                }
                if (ref($machine->{'analysis_elements'}->{'analysis_item'}) eq 'ARRAY') {
                    $client_data_structure = "ARRAY";
                    
                    # Find out how many elements are in the array
                    # NOTE: The number of elements for each client should be the same
                    if ($client_ecount_defined eq "false") {
                        my $temporary = $machine->{'analysis_elements'}->{'analysis_item'};
                        my @temp_client = @$temporary;
                        $client_element_count = $#temp_client + 1;
                        $client_ecount_defined = "true";
                    }
                }
                
                push @machine_results, $machine;
            }

            # Fetch all server machine results (should default to at least 1 machine)
            SERVER_RESULTS:
            while(my($machine_count,$machine) = each(%$server)) {
                # Check what kind of data structure exists as our analysis item
                if (ref($machine->{'analysis_elements'}->{'analysis_item'}) eq 'HASH') {
                    # Check if any analysis items exist
                    if (exists($machine->{'analysis_elements'}->{'analysis_item'}->{'type'}) && $machine->{'analysis_elements'}->{'analysis_item'}->{'type'} eq "none") {
                        # If there were no client results, and no server results, then there is nothing to compare
                        if ($analysis_type eq "SOLE_COMPARISON") {
                            $analysis_type = "NONE_COMPARISON";
                        }
                    }

                    $server_data_structure = "HASH";
                }
                if (ref($machine->{'analysis_elements'}->{'analysis_item'}) eq 'ARRAY') {
                    $server_data_structure = "ARRAY";
                    
                    # Find out how many elements are in the array
                    # NOTE: The number of elements for each server should be the same
                    if ($server_ecount_defined eq "false") {
                        my $temporary = $machine->{'analysis_elements'}->{'analysis_item'};
                        my @temp_server = @$temporary;
                        $server_element_count = $#temp_server + 1;
                        $server_ecount_defined = "true";
                    }
                }
                
                push @machine_results, $machine;
            }

            # If the data structures differ for our clients and servers, then so does our analysis type
            # NOTE: Data structures are defined explicitly throughout the control structure or not at all
            if (defined($client_data_structure) && defined($server_data_structure) && ($client_data_structure ne $server_data_structure)) {
                # If the client is a HASH and the server an ARRAY, make sure this is not a sole_comparison
                if ($analysis_type ne "SOLE_COMPARISON") {
                    $analysis_type = "COPY_COMPARISON";
                }
            }
            
            # If both data structures are arrays, then check to see if we are dealing with 'sets' of files
            if (defined($client_data_structure) && defined($server_data_structure) && ($client_data_structure eq "ARRAY") && ($server_data_structure eq "ARRAY")) {
                if (($server_element_count/$client_element_count == 1/2) || ($server_element_count/$client_element_count == 2/3)) {
                    $analysis_type = "SET_COMPARISON";
                }
            }

            print display_output_row("Analysis Type Defined",$analysis_type) if ($CONFIG->{'VERBOSE'} > 0);

            # -----------------------------------------------------------------
            # Analysis Tests:
            # -----------------------------------------------------------------
            my $tmp_result;   # Temporary variable to hold the current machine set result
            my $tmp_reason;   # Temporary array ref to hold the current machine set reason for failure (if any)

            if ($analysis_type =~ /(SOLE_COMPARISON)/i) {
                ($tmp_result,$tmp_reason) = sole_comparison(\@machine_results);
            }
            elsif ($analysis_type =~ /(COPY_COMPARISON)/i) {
                ($tmp_result,$tmp_reason) = copy_comparison(\@machine_results);
            }
            elsif ($analysis_type =~ /(NONE_COMPARISON)/i) {
                ($tmp_result,$tmp_reason) = none_comparison(\@machine_results);
            }
            elsif ($analysis_type =~ /(SET_COMPARISON)/i) {
                ($tmp_result,$tmp_reason) = set_comparison(\@machine_results,$server_element_count,$client_element_count);
            }
            else {
                ($tmp_result,$tmp_reason) = comparison(\@machine_results);
            }

            print display_output_row("Analysis Results for Instance ID",$instance_id) if ($CONFIG->{'VERBOSE'} > 0);
            print display_output_row("Analysis Results for [$analysis_type]",$tmp_result) if ($CONFIG->{'VERBOSE'} > 0);

            if ($tmp_result eq "fail") {
                $analysis_status = "fail";
                push(@reason, @$tmp_reason);
            }
            # -----------------------------------------------------------------
        }

        # Define our pass/fail results and details for the instance
        my %instanceResults;
        $instanceResults{'result'}        = $analysis_status;
        $instanceResults{'reason'}        = \@reason;
        $instanceResults{'analysis_type'} = lc($analysis_type);
        $instanceResults{'start_time'}    = $instance_details->{$instance_id}->{'start_time'};
        $instanceResults{'end_time'}      = $instance_details->{$instance_id}->{'end_time'};
        $instanceResults{'date'}          = $instance_details->{$instance_id}->{'date'};
        $instanceResults{'test_status'}   = $instance_details->{$instance_id}->{'test_status'};
        $instanceResults{'timestamp'}     = $instance_details->{$instance_id}->{'timestamp'};
        $instanceResults{'test_suite_id'} = $instance_details->{$instance_id}->{'test_suite_id'};
        $instanceResults{'CPU'}           = $instance_details->{$instance_id}->{'CPU'};
        $instanceResults{'build'}         = $instance_details->{$instance_id}->{'build'};
        $instanceResults{'elapsed_times'} = $instance_details->{$instance_id}->{'elapsed_times'};
        
        my $last_insert_id = add_results($instance_id,\%instanceResults);
        
        # Results to return for display
        $analyzed_results{$instance_id} = \%instanceResults;
    }
    
    print display_output_footer() if ($CONFIG->{'VERBOSE'} > 0);
    
    return (\%analyzed_results);
}

#
# comparison() - Run a comparison for all results within a machine set and return whether it passed or failed comparison
# Input:  $machine_results - List containing hash references to all our results for the current machine set 
#                            (contains results from both client and server machines
# Output: Returns a result (pass/fail) for the current machine set, and if there are failures, a list of reasons why
sub comparison {
    my($machine_results) = shift;

    my @machines = @$machine_results;

    my $result = "pass";        # Result of the comparison (pass/fail)
    my @reason;                 # If comparison failed, list of reasons why
    my $comp_key;               # Comparison key used to compare our other hashes/arrays against
    my $key_defined = "false";  # Has our hash comparison key been defined yet (true/false)

    # Make sure we have multiple items to compare
    if ($#machines < 1) {
        $result = "fail";
        push @reason, "There were no machine results to compare. Only one machine result existed.";
        return ($result,\@reason);
    }

    COMPARISON:
    for (my $i=0; $i <= $#machines; $i++) {
        # If a 'result' does not exist, this is probably due to a timeout issue. We fail and move on
        unless (defined($machines[$i]->{'result'})) {
            $result = "fail";
            push @reason, "Result Not Defined. Possible Timeout.";
            next COMPARISON;
        }
        
        # If our current machine has already failed through Visual Test, then capture it, and move on
        if ($machines[$i]->{'result'} eq "fail") {
            $result = "fail";
            push @reason, $machines[$i]->{'reason'};
            next COMPARISON;
        }
        
        # We setup our comparison key
        if ($key_defined eq "false") {
            $comp_key = (defined($machines[$i]->{'analysis_elements'}->{'analysis_item'})) ? $machines[$i]->{'analysis_elements'}->{'analysis_item'} : $machines[$i]->{'comp_elements'}->{'comp_item'};
            $key_defined = "true";
            next COMPARISON;
        }
        
        # We setup our comparison item
        my $comp_item = (defined($machines[$i]->{'analysis_elements'}->{'analysis_item'})) ? $machines[$i]->{'analysis_elements'}->{'analysis_item'} : $machines[$i]->{'comp_elements'}->{'comp_item'};

        # Determine what kind of comparison needs to be done based upon data structure
        if (ref($comp_key) eq 'HASH') {
            my($tmp_result,$tmp_reason) = hash_comparison($comp_key, $comp_item);
            if ($tmp_result eq "fail") {
                $result = "fail";
                push @reason, @$tmp_reason;   # Hash A is not equal to Hash B
                last COMPARISON;
            }
        }
        if (ref($comp_key) eq 'ARRAY') {
            my($tmp_result,$tmp_reason) = array_comparison($comp_key, $comp_item);
            if ($tmp_result eq "fail") {
                $result = "fail";
                push @reason, @$tmp_reason;   # Array A was not equal to Array B
                last COMPARISON;
            }
        }
    }
    
    return ($result,\@reason);
}

#
# hash_comparison() - Compare two hashes against each other to make sure all elements are the same, and return a 'pass' or 'fail' value
# Input:  $comp_key  - Hash reference that is used as a comparison key
#         $comp_item - Hash reference to compare against the key
# Output: String containing a 'pass' or 'fail' value
sub hash_comparison {
    my($comp_key, $comp_item) = @_;

    # Dereference our hashes
    my %comp_key = %$comp_key;
    my %comp_item = %$comp_item;

    my $result = "pass";   # Returns pass or fail on comparison
    my @reason;            # If comparison failed, list of reasons why

    # Iterate through each value of our "hash key" and compare it with our "hash item"
    HASHCOMP:
    while(my($key, $value) = each(%comp_key)) {
        if ($key eq "checksum") {
            # If the same key doesn't exist in the comparison hash, we fail automatically
            unless (exists($comp_item{$key})) {
                $result = "fail";
                push @reason, "The hash key [$key] did not exist for HASH B.";
                #print "ERROR>> hash_comparison() -> The hash key [$key] did not exist for HASH B. \n" if ($DEBUG > 1);
                next HASHCOMP;
            }
            # Next, check to make sure the checksum values are the same
            unless ($value eq $comp_item{$key}) {
                $result = "fail";
                push @reason, "The checksum values for HASH A [$value] did not match values for HASH B [".$comp_item{$key}."].";
                #print "ERROR>> hash_comparison() -> The checksum values for HASH A [$value] did not match values for HASH B [".$comp_item{$key}."]\n" if ($DEBUG > 1);
                next HASHCOMP;
            }
            #print "DEBUG>> HASH A [$key]: ".$value." \t HASH B [$key]: ".$comp_item{$key}."\n" if ($DEBUG > 1);
        }
        if ($key eq "path") {
            # If the same key doesn't exist in the comparison hash, we fail automatically
            unless (exists($comp_item{$key})) {
                $result = "fail";
                push @reason, "The hash key [$key] did not exist for HASH B.";
                #print "ERROR>> hash_comparison() -> The hash key [$key] did not exist for HASH B. \n" if ($DEBUG > 1);
                next HASHCOMP;
            }
            
            # Compare our directory structures
            my($tmp_result,$tmp_reason) = directory_comparison($comp_key{$key}, $comp_item{$key});
            if ($tmp_result eq "fail") {
                $result = "fail";
                push @reason, "The directory structure of ARRAY A did not match the directory structure of ARRAY B.";
                next HASHCOMP;
            }
        }
    }

    return ($result,\@reason);
}

#
# array_comparison() - Compare two arrays against each other to make sure all elements are the same, and return a 'pass' or 'fail' value
# Input:  $comp_key  - Array reference that is used as a comparison key
#         $comp_item - Array reference to compare against the key
# Output: String containing a 'pass' or 'fail' value
sub array_comparison {
    my($comp_key, $comp_item) = @_;

    # Dereference our arrays
    my @comp_key = @$comp_key;
    my @comp_item = @$comp_item;
    
    my $result = "pass";   # Returns pass or fail on comparison
    my @reason;            # If comparison failed, list of reasons why

    # Check to make sure the size of both arrays are the same
    if ($#comp_key != $#comp_item) {
        $result = "fail";
        push @reason, "The size of ARRAY A did not match the size of ARRAY B.";
        #print "ERROR>> array_comparison() -> The size of ARRAY A did not match the size of ARRAY B.\n" if ($DEBUG > 0);
        return ($result,\@reason);
    }

    # Iterate through all of our elements
    for (my $i=0; $i <= $#comp_key; $i++) {
        #print "DEBUG>> ARRAY A: ".$comp_key[$i]->{'filename'}." \t ARRAY B: ".$comp_item[$i]->{'filename'}."\n" if ($DEBUG > 1);
        
        # If our comparison type is a 'checksum' perform a string comparison
        if ($comp_key[$i]->{'type'} eq "checksum") {
            unless ($comp_key[$i]->{'checksum'} eq $comp_item[$i]->{'checksum'}) {
                $result = "fail";
                push @reason, "The checksum value for ARRAY A did not match the checksum value for ARRAY B.";
                #print "ERROR>> array_comparison() -> The checksum value for ARRAY A did not match the checksum value for ARRAY B.\n" if ($DEBUG > 0);
            }
            #print "DEBUG>> CHECKSUM A = ".$comp_key[$i]->{'checksum'}." \t CHECKSUM B: ".$comp_item[$i]->{'checksum'}."\n" if ($DEBUG > 1);
        }
    }
    
    return ($result,\@reason);
}

#
# sole_comparison() - Run a comparison for all results for a sole machine (client or server)
# Input:  $machine_results - List containing hash references to all our results for the current machine set 
#                            (contains results from the server machine)
# Output: Returns a result (pass/fail) for the current machine set, and if there are failures, a list of reasons why
sub sole_comparison {
    my($machine_results) = shift;

    my @machines = @$machine_results;

    my $result = "pass";        # Result of the comparison (pass/fail)
    my @reason;                 # If comparison failed, list of reasons why
    my $comp_key;               # Comparison key used to compare our other hashes/arrays against
    
    SOLE_COMPARISON:
    for (my $i=0; $i <= $#machines; $i++) {
        # Has our hash comparison key been defined yet (true/false)
        my $key_defined = "false";
        
        # If a 'result' does not exist, this is probably due to a timeout issue. We fail and move on
        unless (defined($machines[$i]->{'result'})) {
            $result = "fail";
            push @reason, "Result Not Defined. Possible Timeout.";
            last SOLE_COMPARISON;
        }
        
        # If our current machine has already failed through Visual Test, then capture it, and move on
        if ($machines[$i]->{'result'} eq "fail") {
            $result = "fail";
            push @reason, $machines[$i]->{'reason'};
            last SOLE_COMPARISON;
        }
        
        if (ref($machines[$i]->{'analysis_elements'}->{'analysis_item'}) eq 'HASH') {
            # If the current machine has no results, then move on to the next machine
            if (exists($machines[$i]->{'analysis_elements'}->{'analysis_item'}->{'type'}) && $machines[$i]->{'analysis_elements'}->{'analysis_item'}->{'type'} eq "none") {
                next SOLE_COMPARISON;
            }
        }

        # Define our analysis elements
        my $tmp_elements = (defined($machines[$i]->{'analysis_elements'}->{'analysis_item'})) ? $machines[$i]->{'analysis_elements'}->{'analysis_item'} : $machines[$i]->{'comp_elements'}->{'comp_item'};
        my @analysis_elements = @$tmp_elements;
        
        # Iterate through our analysis items and compare
        ANALYSIS_ITEM:
        for (my $i=0; $i <= $#analysis_elements; $i++) {
            # We setup our comparison key
            if ($key_defined eq "false") {
                $comp_key = $analysis_elements[$i];
                $key_defined = "true";
                next ANALYSIS_ITEM;
            }
            
            # We setoup our comparison item
            my $comp_item = $analysis_elements[$i];
            
            # If our comparison type is a 'checksum' perform a string comparison
            if ($comp_key->{'type'} eq "checksum") {
                unless ($comp_key->{'checksum'} eq $comp_item->{'checksum'}) {
                    $result = "fail";
                    push @reason, "The checksum value for ARRAY CELL A did not match the checksum value for ARRAY CELL B.";
                    #print "ERROR>> sole_comparison() -> The checksum value for ARRAY CELL A did not match the checksum value for ARRAY CELL B.\n" if ($DEBUG > 0);
                }
                #print "DEBUG>> CHECKSUM CELL A = ".$comp_key->{'checksum'}." \t CHECKSUM CELL B: ".$comp_item->{'checksum'}."\n" if ($DEBUG > 1);
            }
        }
    }
    
    return ($result,\@reason);
}

#
# copy_comparison() - Compare the results from each file copied on both client and server machines
# Input:  $machine_results - List containing hash references to all our results for the current machine set 
#                            (contains results from both client and server machines)
# Output: Returns a result (pass/fail) for the current machine set, and if there are failures, a list of reasons why
sub copy_comparison {
    my($machine_results) = shift;

    my @machines = @$machine_results;

    my $result = "pass";        # Result of the comparison (pass/fail)
    my @reason;                 # If comparison failed, list of reasons why
    my $comp_key;               # Comparison key used to compare our other hashes/arrays against
    my $key_defined = "false";  # Has our hash comparison key been defined yet (true/false)
    my @analysis_elements;      # Array containing all of our hash comparison items for both client and server machines
    
    COPY_COMPARISON:
    for (my $i=0; $i <= $#machines; $i++) {
        # If a 'result' does not exist, this is probably due to a timeout issue. We fail and move on
        unless (defined($machines[$i]->{'result'})) {
            $result = "fail";
            push @reason, "Result Not Defined. Possible Timeout.";
            last COPY_COMPARISON;
        }
        
        # If our current machine has already failed through Visual Test, then capture it, and move on
        if ($machines[$i]->{'result'} eq "fail") {
            $result = "fail";
            push @reason, $machines[$i]->{'reason'};
            last COPY_COMPARISON;
        }

        # Check what kind of data structure exists from our machine results
        if (ref($machines[$i]->{'analysis_elements'}->{'analysis_item'}) eq 'HASH') {
            push(@analysis_elements, $machines[$i]->{'analysis_elements'}->{'analysis_item'});
        }
        if (ref($machines[$i]->{'analysis_elements'}->{'analysis_item'}) eq 'ARRAY') {
            my $tmp_elements = $machines[$i]->{'analysis_elements'}->{'analysis_item'};
            push(@analysis_elements, @$tmp_elements);
        }
    }

    # Make sure we have multiple items to compare
    if ($#analysis_elements < 1) {
        $result = "fail";
        push @reason, "There were no file items to compare. Only one analysis item existed.";
        return ($result,\@reason);
    }

    # Iterate through our analysis items and compare
    ANALYSIS_ITEM:
    for (my $i=0; $i <= $#analysis_elements; $i++) {
        # We setup our comparison key
        if ($key_defined eq "false") {
            $comp_key = $analysis_elements[$i];
            $key_defined = "true";
            next ANALYSIS_ITEM;
        }

        # We setoup our comparison item
        my $comp_item = $analysis_elements[$i];

        # If our comparison type is a 'checksum' perform a string comparison
        if ($comp_key->{'type'} eq "checksum") {
            unless ($comp_key->{'checksum'} eq $comp_item->{'checksum'}) {
                $result = "fail";
                push @reason, "The checksum value for ARRAY CELL A did not match the checksum value for ARRAY CELL B.";
                #print "ERROR>> copy_comparison() -> The checksum value for ARRAY CELL A did not match the checksum value for ARRAY CELL B.\n" if ($DEBUG > 0);
            }
            #print "DEBUG>> CHECKSUM CELL A = ".$comp_key->{'checksum'}." \t CHECKSUM CELL B: ".$comp_item->{'checksum'}."\n" if ($DEBUG > 1);
        }
    }
    
    return ($result,\@reason);
}

#
# directory_comparison() - Compare two arrays against each other to make sure all elements are the same, and return a 'pass' or 'fail' value
# Input:  $comp_key  - Array reference that is used as a comparison key
#         $comp_item - Array reference to compare against the key
# Output: String containing a 'pass' or 'fail' value
sub directory_comparison {
    my($comp_key, $comp_item) = @_;

    # Dereference our arrays
    my @comp_key = @$comp_key;
    my @comp_item = @$comp_item;
    
    my $result = "pass";   # Returns pass or fail on comparison
    my @reason;            # If comparison failed, list of reasons why

    # Check to make sure the size of both arrays are the same
    if ($#comp_key != $#comp_item) {
        $result = "fail";
        push @reason, "The size of ARRAY A did not match the size of ARRAY B.";
        #print "ERROR>> directory_comparison() -> The size of ARRAY A did not match the size of ARRAY B.\n" if ($DEBUG > 0);
        return ($result,\@reason);
    }

    # Iterate through all of our elements
    for (my $i=0; $i <= $#comp_key; $i++) {
        #print "DEBUG>> ARRAY A: ".$comp_key[$i]." \t ARRAY B: ".$comp_item[$i]."\n" if ($DEBUG > 1);

        unless ($comp_key[$i] eq $comp_item[$i]) {
            $result = "fail";
            push @reason, "The directory path for ARRAY A did not match the directory path for ARRAY B.";
            #print "ERROR>> directory_comparison() -> The directory path for ARRAY A did not match the directory path for ARRAY B.\n" if ($DEBUG > 0);
        }
    }
    
    return ($result,\@reason);
}

#
# none_comparison() - There are no analysis comparisons because there are no items to compare, so we default our status = pass
# Input:  $machine_results - List containing hash references to all our results for the current machine set 
#                            (contains results from both client and server machines)
#                            NOTE: If any results are sent back, this means that a new analysis type must be defined, because this
#                            method handles no results from any machine
# Output: Returns a result (pass/fail) for the current machine set, and if there are failures, a list of reasons why
sub none_comparison {
    my($machine_results) = shift;

    my @machines = @$machine_results;
    my $result   = "pass";        # Result of the comparison (pass/fail)
    my @reason;                   # If comparison failed, list of reasons why

    NONE_COMPARISON:
    for (my $i=0; $i <= $#machines; $i++) {
        # If a 'result' does not exist, this is probably due to a timeout issue. We fail and move on
        unless (defined($machines[$i]->{'result'})) {
            $result = "fail";
            push @reason, "Result Not Defined. Possible Timeout.";
            last NONE_COMPARISON;
        }

        # If our current machine has already failed through Visual Test, then capture it, and move on
        if ($machines[$i]->{'result'} eq "fail") {
            $result = "fail";
            push @reason, $machines[$i]->{'reason'};
            last NONE_COMPARISON;
        }
        
        # If the current machine has no results, then move on to the next machine
        if (exists($machines[$i]->{'analysis_elements'}->{'analysis_item'}->{'type'}) && $machines[$i]->{'analysis_elements'}->{'analysis_item'}->{'type'} eq "none") {
            next NONE_COMPARISON;
        }
                
        # NOTE: There should be no items left, however if there are, make note of it as an anomaly
        push @reason, "Warning! An anomaly occurred in the NONE_COMPARISON where analysis items where found when none should exist.";
    }
    
    return ($result,\@reason);
}

#
# set_comparison() - Run a comparison for all results within a machine set and return whether it passed or failed comparison
# Input:  $machine_results - List containing hash references to all our results for the current machine set 
#                            (contains results from both client and server machines
#         $server_count    - String containing the number of elements per server results array
#         $client_count    - String containing the number of elements per client results array
# Output: Returns a result (pass/fail) for the current machine set, and if there are failures, a list of reasons why
sub set_comparison {
    my($machine_results,$server_count,$client_count) = @_;

    my @machines = @$machine_results;

    my $result = "pass";            # Result of the comparison (pass/fail)
    my @reason;                     # If comparison failed, list of reasons why
    my $comp_key;                   # Comparison key which contains multiple sets and used to extract the true comparison key set
    my @key_set = ();               # This is the true set of files that need to be compared
    my $keyset_defined = "false";   # Has our true key set been defined yet (true/false)
    my $key_defined = "false";      # Has our array comparison key been defined yet (true/false)

    # Make sure we have multiple items to compare
    if ($#machines < 1) {
        $result = "fail";
        push @reason, "There were no machine results to compare. Only one machine result existed.";
        return ($result,\@reason);
    }

    SETCOMP:
    for (my $i = $#machines; $i >= 0; $i--) {
        # If a 'result' does not exist, this is probably due to a timeout issue. We fail and move on
        unless (defined($machines[$i]->{'result'})) {
            $result = "fail";
            push @reason, "Result Not Defined. Possible Timeout.";
            next SETCOMP;
        }
        
        # If our current machine has already failed through Visual Test, then capture it, and move on
        if ($machines[$i]->{'result'} eq "fail") {
            $result = "fail";
            push @reason, $machines[$i]->{'reason'};
            next SETCOMP;
        }
        
        # We setup our comparison key
        if ($key_defined eq "false") {
            $comp_key = $machines[$i]->{'analysis_elements'}->{'analysis_item'};
            $key_defined = "true";
            next SETCOMP;
        }
        
        # We setup our comparison item
        my $comp_item = $machines[$i]->{'analysis_elements'}->{'analysis_item'};

        my @comparison_key = @$comp_key;
        my @comparison_item = @$comp_item;
        
        # Check and make sure that we are dealing with server/client sets and not two equal client sets
        if ($#comparison_key == $#comparison_item) {
            $result = "fail";
            push @reason, "The first two sets matched in size, so there is either more than one server machine OR the wrong analysis was selected.";
            last SETCOMP;
        }
        
        # The numerator must always be less than the denominator
        # NOTE: The first item should be the server set and the size should be less than any client set
        if ($#comparison_key > $#comparison_item) {
            $result = "fail";
            push @reason, "The number of server sets was greater than the number of client sets.";
            last SETCOMP;
        }
        
        # Has our true key set been defined yet? (The true key set contains only 1 set of files that all other items need to be compared against)
        if ($keyset_defined eq "false") {
            ####################
            ##
            ## DEFINE OUR TRUE COMPARISON KEY SET
            ##
            # Check to see whether we are dealing with integers or floating point numbers by the ratio: server to client
            my $ratio = $server_count/$client_count;
            
            if (isFloat($ratio)) {
                # We need to find out how many files are in each set
                if ($ratio == 2/3) {
                    my $filecount = $server_count/2;
                    
                    # We splice our comparison key into two parts: 1) the true comparison key set, and 2) the other sets
                    @key_set = splice(@comparison_key, 0, $filecount);
                    
                    my($tmp_result,$tmp_reason) = array_comparison(\@key_set, \@comparison_key);
                    if ($tmp_result eq "fail") {
                        $result = "fail";
                        push @reason, @$tmp_reason;   # Array A was not equal to Array B
                        last SETCOMP;
                    }
                    
                    # If we PASS, then we have defined our true comparison key
                    $keyset_defined = "true";
                }
                else {
                    $result = "fail";
                    push @reason, "The ratio type for this analysis has not yet been defined. [floating] = [" . ($#comparison_key + 1) . "/" . ($#comparison_item + 1) . "]";
                    last SETCOMP;
                }
            }
            elsif (isInteger($ratio)) {
                # We need to find out how many files are in each set
                if ($ratio == 1/2) {
                    push @key_set, @comparison_key;
                    $keyset_defined = "true";
                }
                else {
                    $result = "fail";
                    push @reason, "The ratio type for this analysis has not yet been defined. [integer] = [" . ($#comparison_key + 1) . "/" . ($#comparison_item + 1) . "]";
                    last SETCOMP;
                }
            }
            else {
                $result = "fail";
                push @reason, "The ratio (server/client) of the resulting set was neither an integer or floating point number.";
                last SETCOMP;
            }
            ##
            ####################
        }
        
        # Once we have defined our true comparison key set, let's evaluate the other items
        if ($keyset_defined eq "true") {
            my $cell = 0;   # This counter refers to which cell element we are currently at for the true comparison key
            
            # Iterate through all of our elements
            for (my $j=0; $j <= $#comparison_item; $j++) {
                #print "DEBUG>> ARRAY A: ".$key_set[$cell]->{'filename'}." \t ARRAY B: ".$comparison_item[$j]->{'filename'}."\n" if ($CONFIG->{'DEBUG'} > 0);
                
                # If our comparison type is a 'checksum' perform a string comparison
                if ($key_set[$cell]->{'type'} eq "checksum") {
                    unless ($key_set[$cell]->{'checksum'} eq $comparison_item[$j]->{'checksum'}) {
                        $result = "fail";
                        push @reason, "The checksum value for ARRAY A did not match the checksum value for ARRAY B. [SETCOMP]";
                        last SETCOMP;
                    }
                    #print "DEBUG>> CHECKSUM A = ".$key_set[$cell]->{'checksum'}." \t CHECKSUM B: ".$comparison_item[$j]->{'checksum'}."\n" if ($CONFIG->{'DEBUG'} > 0);
                }
                
                # Increment our cell count, or rollback to zero if we have reached the end
                if ($cell == $#key_set) {
                    $cell = 0;
                }
                else {
                    $cell++;
                }
            }
        }
    }
    
    return ($result,\@reason);
}

#
# isInteger() - Returns true if the given value is an integer
# Input:  $str - String containing a numerical value
# Output: Returns true on success or false on failure
sub isInteger {
    my($str) = shift;

    $str =~ /^[\-\+]?\d+$/;
}

#
# isFloat() - Returns true if the given value is a floating point number
# Input:  $str - String containing a numerical value
# Output: Returns true on success or false on failure
sub isFloat {
    my($str) = shift;

    return 1   if $str =~ /^[\-\+]?\d+\.?(\d+)?$/;
    $str =~ /^[\-\+]?(\d+)?\.\d+$/;
}


1;

__END__
