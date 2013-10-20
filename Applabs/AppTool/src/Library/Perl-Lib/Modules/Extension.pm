#!/usr/bin/perl -w
#
# Copyright:     AppLabs Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision:  $
# Last Modified: $Date:  $
# Modified By:   $Author:  $
# Source:        $Source:  $
#
####################################################################################
##
##


package Extension;

use System::Environment;
use Modules::Config;
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
# Input:  None
# Output: Object for Extension module
sub new {
    
    my $EXT = {
        "REPOSITORY_XLS" => $CONFIG->{'CONFIG_PATH'} . "repository.xls",
        "REPOSITORY_INI" => $CONFIG->{'TEST_CONFIG_PATH'} . "config.ini"
    };
    
    bless $EXT, 'Extension';   # Tag object with pkg name
    return $EXT;
}

#
# interpolate_xml_request() - 
# Input:
# Output: 
sub interpolate_xml_request {
    my($self) = shift;
    my($params,$request_xml) = @_;
    
    my $student = $self->getStudentInfo($params->{'USER_COUNT'});
    
    my $first_name  = $student->{'first_name'};
    my $last_name   = $student->{'last_name'};
    my $group_id    = $student->{'group_id'};
    my $student_id  = $student->{'student_id'};
    my $product_id  = $student->{'product_id'};
    my $exercise_id = $student->{'exercise_id'};
    
    #$request_xml =~ s/__FIRST_NAME__/$first_name/;
    #$request_xml =~ s/__LAST_NAME__/$last_name/;
    $request_xml =~ s/__GROUP_ID__/$group_id/;
    $request_xml =~ s/__STUDENT_ID__/$student_id/;
    $request_xml =~ s/__PRODUCT_ID__/$product_id/;
    $request_xml =~ s/__EXERCISE_ID__/$exercise_id/;
    
    return ($request_xml);
}

#
# getStudentInfo() - Function that captures the student information for the given user.
# Input:  $self - Object
#         $user_count - Integer representing the row that the user exists in the spreadsheet.
# Output: Hash reference containing the student information.
sub getStudentInfo {
    my($self) = shift;
    my($user_count) = shift;
    
    my $worksheetName = "Students";
    
    # Create new spreadsheet object
    my $xls = new Spreadsheet::BasicRead($self->{'REPOSITORY_XLS'}) || die "Could not open '" . $self->{'REPOSITORY_XLS'} . "': $! \n";
    
    # Set the heading row to 0
    $xls->setHeadingRow(0);
    
    # Set the heading row to 0
    $xls->setHeadingRow(0);
    
    # Reset back to the first worksheet
    $xls->setCurrentSheetNum(0);
    
    my $numSheets = $xls->numSheets();
    
    my $student;
    
    WORKSHEET:
    for (my $i=0; $i < $numSheets; $i++) {
        # Make sure we actually have a valid worksheet
        unless (defined($xls->currentSheetName())) {
            next WORKSHEET;
        }
        
        # Reset back to the first row of the sheet
        $xls->setRow(0);
        
        if ($xls->currentSheetName eq $worksheetName) {
            $student = {
                "group_id"    => $xls->cellValue($user_count, 0),
                "student_id"  => $xls->cellValue($user_count, 1),
                "product_id"  => $xls->cellValue($user_count, 2),
                "exercise_id" => $xls->cellValue($user_count, 3),
                "last_name"   => $xls->cellValue($user_count, 4),
                "first_name"  => $xls->cellValue($user_count, 5),
            };
            
            last WORKSHEET;
        }
        
        $xls->getNextSheet();
    }
    
    return ($student);
}



1;

__END__
