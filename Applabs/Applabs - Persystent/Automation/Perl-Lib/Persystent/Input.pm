#!/usr/bin/perl -w
#
# Copyright:     AppLabs Technologies / Persystent Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision:  $
# Last Modified: $Date:  $
# Modified By:   $Author:  $
# Source:        $Source:  $
#
####################################################################################
##
##


package Input;

use lib "C:\\persystent\\Automation\\Perl-Lib\\";
use Persystent::Config;
use Spreadsheet::BasicRead;   # Requirement (install from CPAN)
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();


# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input:  $fileName - File name of the input file
#         $filePath - Path of where the input file is located (relative or full path)
# Output: Object for input of data to cgi-scripts
sub new {
    my ($fileName, $filePath) = @_;
    
    unless (defined($fileName)) {
        $fileName = $CONFIG->{'DEFAULT_INPUT_FILE'};
    }
    
    unless (defined($filePath)) {
        $filePath = $CONFIG->{'DEFAULT_INPUT_PATH'};
    }
    
    my $INPUT = {
        "FILENAME"    => $fileName,
        "FILEPATH"    => $filePath,
        "SPREADSHEET" => "",
        "WORKSHEET"   => "ALL"
    };
    
    bless $INPUT, 'Input';   # Tag object with pkg name
    return $INPUT;
}

#
# readInput() - Read the input file and output the data into an associative array
# Input:  $INPUT - Input data object
# Output: Associative array containing the contents of the input file
sub readInput {
    my $INPUT = shift;
    
    my $inputFile = $INPUT->{'FILEPATH'} . $INPUT->{'FILENAME'};
    
    # Create new spreadsheet object
    my $xls = new Spreadsheet::BasicRead($inputFile) || die "Could not open '$inputFile': $!";
    
    # Set the heading row to 0
    $xls->setHeadingRow(0);
    
    # Collect our spreadsheet into our object
    $INPUT->{'SPREADSHEET'} = $xls;
}

#
# getComputers() - Get a list of all computers that we will communicate with
# Input:  $INPUT - Input data object
# Output: Array containing a list of all computers (client machines)
sub getComputers {
    my $INPUT = shift;
    
    my $xls = $INPUT->{'SPREADSHEET'};
    
    my $numSheets = $xls->numSheets();
    
    # Print the number of sheets
    print "There are ", $xls->numSheets(), " worksheets in the spreadsheet\n" if ($CONFIG->{'DEBUG'} > 1);
    
    # Array containing a list all computers
    my @computers;
    
    COMPUTER:
    for (my $i=0; $i < $numSheets; $i++) {
        # Print the name of the current sheet
        print "Current worksheet name is ", $xls->currentSheetName(), "\n" if ($CONFIG->{'DEBUG'} > 1);
        
        # Reset back to the first row of the sheet
        $xls->setRow(0);
        
        if ($xls->currentSheetName eq "Computers") {
            # Capture the headers and put into an associative array
            my $heading = $xls->getFirstRow();
            my %headers;
            my $cellCount = 0;
            foreach my $cell (@$heading) {
                print "Header[$cellCount] = $cell \n" if ($CONFIG->{'DEBUG'} > 1);
                $headers{$cell} = $cellCount++;
            }
            
            # Capture all records of the current sheet
            my $row = 0;
            while (my $data = $xls->getNextRow()) {
                # Define our details associative array
                my %details;
                
                # Capture our computer details
                my $itemCount = 0;
                foreach my $item (@$data) {
                    foreach my $header (keys %headers) {
                        if ($headers{$header} eq $itemCount) {
                            $details{$header} = $item;
                            print "KEY = $header \t VALUE = $item \n" if ($CONFIG->{'DEBUG'} > 1);
                        }
                    }
                    $itemCount++;
                }
                
                $computers[$row] = \%details;
                $row++;
            }
            
            last COMPUTER;
        }
        
        $xls->getNextSheet();
    }
    
    return (\@computers);
}


1;

__END__
