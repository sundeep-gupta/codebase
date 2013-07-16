#!/usr/bin/perl -w
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.6 $
# Last Modified: $Date: 2005/06/24 21:17:54 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbital/control/perl-lib/Orbital/Output.pm,v $
#
####################################################################################
##
##

# Include the following modules
use strict;
use lib qw(/usr/local/lib/perl5/5.8.6 /usr/local/orbital/console/perl-lib);
use Orbital::Config;


# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

my $CONFIG = Config::new();


#
# display_output() - Display the given data in either html or standard output
# Input:  $label - Label for output data
#         $field - Field data associated with label
# Output: String containing output data
sub display_output {
    my ($label,$field) = @_;
    
    my $stdout;  # Our data to display
    
    if (exists($ENV{'HTTP_USER_AGENT'})) {
        $stdout = <<END_OF_OUTPUT;
            <table class="testrun">
            <tr>
                <td class="trLabel">$label</td>
                <td class="trField">$field</td>
            </tr>
            </table>
END_OF_OUTPUT
    }
    else {
        $stdout = "ORBITAL>> $label: $field \n";
    }
    
    return $stdout;
}

#
# display_output_header() - Display the given data in either html or standard output
# Input:  $header - Header data to display
# Output: String containing output data
sub display_output_header {
    my ($header) = @_;
    
    my $stdout;  # Our data to display
    
    if (exists($ENV{'HTTP_USER_AGENT'})) {
        $stdout = <<END_OF_HEADER;
            <table class="testrun">
            <tr>
                <td colspan="2" class="trHeader">$header</td>
            </tr>
END_OF_HEADER
    }
    else {
        $stdout = "ORBITAL>> *** $header *** \n";
    }
    
    return $stdout;
}

#
# display_output_row() - Display the given data in either html or standard output
# Input:  $label - Label for output data
#         $field - Field data associated with label
# Output: String containing output data
sub display_output_row {
    my ($label,$field) = @_;
    
    my $stdout;  # Our data to display
    
    if (exists($ENV{'HTTP_USER_AGENT'})) {
        $stdout = <<END_OF_HEADER;
            <tr>
                <td class="trLabel">$label</td>
                <td class="trField">$field</td>
            </tr>
END_OF_HEADER
    }
    else {
        $stdout = "ORBITAL>> $label: $field \n";
    }
    
    return $stdout;
}

#
# display_output_footer() - Display the given data in either html or standard output
# Input:  Nothing
# Output: String containing output data
sub display_output_footer {    
    my $stdout;  # Our data to display
    
    if (exists($ENV{'HTTP_USER_AGENT'})) {
        $stdout = <<END_OF_FOOTER;
            </table>
END_OF_FOOTER
    }
    else {
        $stdout = "\n";
    }
    
    return $stdout;
}

#
# page_header() - Displays html header
# Input:  Nothing
# Output: String containing html header
sub page_header {
    my $html = <<END_OF_HEADER;
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/2000/REC-xhtml1-20000126/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Run Test Suite</title>
    <style type="text/css">
        \@import url($CONFIG->{'BASEURL'}includes/css/layout.css);
        \@import url($CONFIG->{'BASEURL'}includes/css/modules.css);
        \@import url($CONFIG->{'BASEURL'}includes/css/testrun.css);
    </style>
    <style type="text/css">
    <!--
        .progressbar {
            background-image: url($CONFIG->{'BASEURL'}includes/images/progressbar-bg.gif);
            background-repeat: no-repeat;
            height: 60px;
            width: 704px;
            margin-right: auto;
            margin-left: auto;
        }
    -->
    </style>
    <script src="$CONFIG->{'BASEURL'}includes/js/main.js" type="text/javascript"></script>
</head>

<body>
<div id="pageWrapper">
    <div id="pageHeader">
        <div id="headerImage"><img src="$CONFIG->{'BASEURL'}includes/images/header_bg.jpg" alt="Orbital Header Image" /></div>
        <div id="headerMenu">
            <table cellspacing="0" cellpadding="0">
            <tr>
                <td><a href="$CONFIG->{'BASEURL'}">Home</a></td>
                <td><a href="$CONFIG->{'BASEURL'}testmech/">Run Test</a></td>
                <td><a href="$CONFIG->{'BASEURL'}automation/">Smoke Test</a></td>
                <td><a href="$CONFIG->{'BASEURL'}reports/">Reports</a></td>
                <td><a href="$CONFIG->{'BASEURL'}updates/">Updates</a></td>
                <td><a href="$CONFIG->{'BASEURL'}admin/">Admin</a></td>
                <td><a href="$CONFIG->{'BASEURL'}config/">Config</a></td>
                <td><a href="$CONFIG->{'BASEURL'}support/">Support</a></td>
            </tr>
            </table>
        </div>
    </div>

    <div id="pageBody">
        <div id="orbModule">
END_OF_HEADER

    return $html;
}

#
# page_footer() - Displays html footer
# Input:  Nothing
# Output: String containing html footer
sub page_footer {
    my $html = <<END_OF_FOOTER;
        </div>
    </div>

    <div id="pageFooter">
        <span id="copyright">Copyright &copy;<script language="javascript" type="text/javascript">showYear();</script> - Orbital Data</span>
    </div>
</div>

</body>
</html>
END_OF_FOOTER

    return $html;
}

#
# progress_bar_header() - Displays header html for the test run progress bar
# Input:  $TestSuiteName - Test suite name to display
# Output: String containing html progress bar
sub progress_bar_header {
    my ($TestSuiteName) = shift;
    
    my $html = <<END_OF_HEADER;
            <div id="progressData">
                <div id="statusbox">
                    <div id="statusHeader">$TestSuiteName testing in progress.....</div>
                    <div id="statusClock">
                        <form name="clockform">
                            Elapsed Time: <input name="clocktimer" type="text" size="10" readonly="readonly" />
                        </form>
                        <script type="text/javascript">startclock();</script>
                    </div>
                    <div id="progressStats">
                        <form name="statusform">
                            <table id="formTable">
                            <tr>
                                <th>Test Run Name</th>
                                <th>Runs Left</th>
                                <th>Test Case Name</th>
                                <th>Cases Left</th>
                            </tr>
                            <tr>
                                <td class="statField"><input name="TestRunName" type="text" size="20" readonly="readonly" /></td>
                                <td class="statField"><input name="RunsLeft" type="text" size="5" readonly="readonly" /></td>
                                <td class="statField"><input name="TestCaseName" type="text" size="20" readonly="readonly" /></td>
                                <td class="statField"><input name="CasesLeft" type="text" size="5" readonly="readonly" /></td>
                            </tr>
                            </table>
                        </form>
                    </div>
                </div>
                <div class="progressbar">
                    <div class="baritems">
END_OF_HEADER

    return $html;
}

#
# progress_bar_mark() - Display progress bar mark to indicate progress towards completion
# Input:  Nothing
# Output: Standard output to screen
sub progress_bar_mark {
    my ($percent_now, $percent_last) = @_;

    my $difference = $percent_now - $percent_last;
    for (my $i=1; $i <= $difference; $i++) {
        my $html = <<END_OF_BAR;
                        <img src="$CONFIG->{'BASEURL'}includes/images/progressbar-single.gif" border="0" alt="bar mark" />
END_OF_BAR

        print $html;
    }
}

#
# progress_bar_footer() - Displays footer html for the test run progress bar
# Input:  Nothing
# Output: String containing html progress bar
sub progress_bar_footer {
    my $html = <<END_OF_FOOTER;
                    </div>
                </div>
                <div id="progressResults">
                    100\% Complete
                    <p style="font-size: 14px; padding-top: 15px;">Redirecting to results.....</p>
                </div>
            </div>
END_OF_FOOTER
}

#
# javascript_progress_stats() - Displays the current progress stats by updating the html form
# Input:  $TestRunName  - Current test run name
#         $RunsLeft     - The number or test runs left
#         $TestCaseName - Current test case name
#         $CasesLeft    - The number of test cases left
# Output: String containing javascript to be placed in html page
sub javascript_progress_stats {
    my ($TestRunName, $RunsLeft, $TestCaseName, $CasesLeft) = @_;
    
    my $html;
    
    if (exists($ENV{'HTTP_USER_AGENT'})) {
        $html = <<END_OF_HTML;
                        <script language="javascript" type="text/javascript">
                            function updateStats() {
                                document.statusform.TestRunName.value  = "$TestRunName";
                                document.statusform.RunsLeft.value     = "$RunsLeft";
                                document.statusform.TestCaseName.value = "$TestCaseName";
                                document.statusform.CasesLeft.value    = "$CasesLeft";
                            }
                            
                            // Update our progress stats
                            updateStats();
                        </script>
END_OF_HTML
    }
    else {
        $html = "\n\n\n";
    }

    return $html;
}

#
# testrun_table_header() - Function that returns a nicely formatted table containing our test case instance data
# Input:  $instance     - Hash containing test case instance data
# Output: String containing our display data
sub testrun_table_header {
    my ($instance) = @_;
    
    my $stdout;
    
    if (exists($ENV{'HTTP_USER_AGENT'})) {
        $stdout = <<END_OF_HEADER;
            <table class="testrun">
            <tr>
                <td colspan="2" class="trHeader">Test Group: $instance->{'test_group_name'}</td>
            </tr>
            <tr>
                <td class="trLabel">Instance ID:</td>
                <td class="trField">$instance->{'instance_id'}</td>
            </tr>
            <tr>
                <td class="trLabel">Test Case:</td>
                <td class="trField">$instance->{'test_case'}</td>
            </tr>
            <tr>
                <td class="trLabel">Share:</td>
                <td class="trField">$instance->{'share'}</td>
            </tr>
            </table>
END_OF_HEADER
    }
    else {
        $stdout = "ORBITAL>> ***** Test Run Instance ***** \n";
        $stdout .= "ORBITAL>> test case instance id: $instance->{'instance_id'} \n";
        $stdout .= "ORBITAL>> test case id: $instance->{'test_case_id'} \n";
        $stdout .= "ORBITAL>> test case name: $instance->{'test_case'} \n";
        $stdout .= "ORBITAL>> share name: $instance->{'share'} \n";
        $stdout .= "ORBITAL>> clients hash: $instance->{'clients'} \n";
        $stdout .= "ORBITAL>> servers hash: $instance->{'servers'} \n";
        $stdout .= "ORBITAL>> orbitals hash: $instance->{'orbitals'} \n\n";
    }

    return $stdout;
}

#
# testrun_table_footer() - Function that returns the footer of our testrun table
# Input:  Nothing
# Output: String containing our table footer html
sub testrun_table_footer {
    my $html = <<END_OF_FOOTER;
            </table>

END_OF_FOOTER

    return $html;
}

#
# display_redirect_javascript() - Returns an html string containing a javascript function that redirects to a given URL
# Input:  $timestamp - Unix timestamp value
# Output: String containing javascript that redirects user to a URL
sub display_redirect_javascript {
    my ($timestamp) = @_;
    
    my $redirect = $CONFIG->{'BASEURL'}."testmech/testResults.php?Timestamp=".$timestamp;
    my $html = <<END_OF_HTML;
<script language="javascript">
function redirectPage() {
    // Set the value of the href property of the location object to the address to which we want to redirect users
    document.location.href = "$redirect";
}

// Setup our wait time
setTimeout("redirectPage()",5000);
</script>
END_OF_HTML

    return $html;
}

#
# display_suite_list() - Return a formatted string containing a list of all test suites currently available (including id values)
# Input:  $TestSuiteList - Array reference containing a list of all test suites
# Output: String containing a list of all test suites currently available
sub display_suite_list {
    my ($TestSuiteList) = @_;
    
    my $stdout = " Test Suite Name  \t ID \n";
    $stdout .= "---------------------------------------------------------------\n";
    
    while (my($TestSuiteID,$hashref) = each(%$TestSuiteList)) {
        $stdout .= sprintf(" %-24.24s%d\n", $hashref->{'Name'}, $TestSuiteID);
    }
    $stdout .= "---------------------------------------------------------------\n\n";
    
    return $stdout;
}

#
# display_testrun_list() - Return a formatted string containing a list of all test runs currently available (including id values)
# Input:  $TestRunList - Array reference containing a list of all test runs available within a given suite
# Output: String containing a formatted list of all test runs within a given test suite
sub display_testrun_list {
    my ($TestRunList) = @_;
    
    my $stdout = "\n Test Run Name    \t\t ID \n";
    $stdout .= "---------------------------------------------------------------\n";
    
    while (my($TestRunID,$hashref) = each(%$TestRunList)) {
        $stdout .= sprintf(" %-32.32s%d\n", $hashref->{'Name'}, $TestRunID);
    }
    $stdout .= "---------------------------------------------------------------\n\n";
    
    return $stdout;
}

#
# sizeof_hash() - Returns the size of the given hash reference
# Input:  $hashref - Hash reference to the hash we need to find the size of
# Output: Integer containing the size of our hash
sub sizeof_hash {
    my ($hashref) = shift;
    
    my @keys = keys %$hashref;
    my $size = $#keys + 1;

    return $size;
}



1;

__END__
