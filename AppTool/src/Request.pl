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

BEGIN {
    push @INC, "Library/Perl-Lib";
    push @INC, "Library/Perl-Lib/Modules";
}

use Modules::Config;
use Modules::Logger;
use Modules::IO;
use Modules::Request;
use Modules::Extension;
use Getopt::Long;
use Pod::Usage;
use threads;
use Tie::Hash;
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

# Fetch our global configuration information
my $CONFIG = Config::new();

my $IO = IO::new();

my $EXT = Extension::new();

# -----------------------------------------------------------
# MAIN:
# -----------------------------------------------------------

# Define our options
my $action   = "";     # Command type to be executed
my $item     = "";     # Item to execute command on
my $option   = "";     # Option value passed to command
my $path     = "";     # [Optional] Full path name of the command to execute
my $file     = "";     # [Optional] File name of the command to execute
my $flags    = "";     # [Optional] String containing the flags to be passed to the command

# NOTE: To run multiple commands use the following format:
#       caller.pl --action=command --item=multiple
# This will pull commands from the default input spreadsheet, or a file you specify
GetOptions (
    "action=s" => \$action,
    "item=s"   => \$item,
    "option:s" => \$option,
    "path:s"   => \$path,
    "file:s"   => \$file,
    "flags:s"  => \$flags
);

# Let's lowercase our input variables
$action   =~ tr/[A-Z]/[a-z]/;
$item     =~ tr/[A-Z]/[a-z]/;
$option   =~ tr/[A-Z]/[a-z]/;

# If they don't give us the correct parameters, then send a how-to
if (($action eq "") || ($item eq "")) {
    pod2usage(-exitstatus => 0);
}

# Check to see if we have a list of commands to perform. If so, fetch them and
# package them up into an XML string
my $parameters;
my $request_xml = xml_request_header();
if (($action eq "command") && ($item eq "multiple")) {
    my $commandList = $IO->getCommands();
    foreach my $command (@$commandList) {
        if (($command->{'Path'} ne "") && ($command->{'File'} ne "")) {
            $flags = (defined($command->{'Flags'}) && $command->{'Flags'} ne "") ? $command->{'Flags'} : "";
            $option = (defined($command->{'Options'}) && $command->{'Options'} ne "") ? $command->{'Options'} : "";
            my $params = {
                "path"    => $command->{'Path'},
                "file"    => $command->{'File'},
                "flags"   => $flags,
                "program" => $option
            };
            $parameters = $IO->fetchCommandParams($command->{'Action'},$command->{'Item'},$params);
            $request_xml .= package_request($parameters);
        }
        else {
            $parameters = $IO->fetchCommandParams($command->{'Action'},$command->{'Item'},$command->{'Options'});
            $request_xml .= package_request($parameters);
        }

    }
}
else {
    # Fetch our command parameters
    if (($path ne "") && ($file ne "")) {
        my $params = {
            "path"    => $path,
            "file"    => $file,
            "flags"   => $flags,
            "program" => $option
        };
        $parameters = $IO->fetchCommandParams($action,$item,$params);
        $request_xml .= package_request($parameters);
    }
    else {
        $parameters = $IO->fetchCommandParams($action,$item,$option);
        $request_xml .= package_request($parameters);
    }

}
$request_xml .= xml_request_footer();

# Fetch a list of all computers to send command to
my $computerList = $IO->getComputers();
my @computers = @$computerList;
my $size = $#computers + 1;

# Capture the start time
my $startTime = time();
print "Execution Start Time: \t $startTime \n";
print "Found $size computer(s)...... continuing.....\n\n";

my $thread_count = 0;
my @thread_list;
my @client;

# Send request to each computer
foreach my $computer (@$computerList) {
    # Encapsulate our client xml request into a thread
    my $client_ip = $computer->{'IPaddress'};
    my $client_machine = {
        "host" => $client_ip,
        "port" => "8888",
        "path" => "/"

    };

    # Dynamically configure our XML request per machine
    my $params = {
        "USER_COUNT" => $thread_count + 1
    };
    my $tmp_request_xml = $request_xml;
    $tmp_request_xml = $EXT->interpolate_xml_request($params,$tmp_request_xml);

    # Put our threads into an array
    $client[$thread_count] = $client_ip;
    my ($thr) = threads->create( \&send_request, $tmp_request_xml, $client_machine);
    $thread_list[$thread_count] = $thr;
    $thread_count++;

    print "[Thread]: XML request sent to " . $client_ip . "\n";
}

# Output status of threads
print "\n[Status]: Completed sending request to $thread_count out of $size client machine(s).... continuing.... \n\n";

# Harvest our threads
my $count = 0;
for (my $i=0; $i <= $#thread_list; $i++) {
    # Fetch our client thread and any output (We assume the results are complete, since we've gotten this far)
    my @retval = $thread_list[$i]->join();
    my $client_response = join("", @retval);
    my $response = parse_xml_response($client_response);

    # Fetch our results for the current thread, but also check for multiple commands.
    # If multiple commands exist, display the status for each
    if (ref($response->{'command'}) eq 'ARRAY') {
        my $commandList = $response->{'command'};
        foreach my $command (@$commandList) {
            # Find our results for the current thread
            my($tmp_result,$tmp_reason) = result_status($command);

            print "Results for command: " . $command->{'action'} . " " . $command->{'item'} . "\n";
            print "Result Status for " . $client[$i] . " : [$tmp_result] \n";
            if (defined($tmp_reason)) {
                print "Result Reason for " . $client[$i] . " : [$tmp_reason] \n";
            }
        }
    }
    else {
        # Find our results for the current thread
        my $tmp_response = (defined($response->{'command'}) && $response->{'command'} ne "") ? $response->{'command'} : $response->{'BODY'};
        my($tmp_result,$tmp_reason) = result_status($tmp_response);
        my $tmp_action = (defined($response->{'command'}->{'action'}) && $response->{'command'}->{'action'} ne "") ? $response->{'command'}->{'action'} : "Unknown action";
        my $tmp_item   = (defined($response->{'command'}->{'item'}) && $response->{'command'}->{'item'} ne "") ? $response->{'command'}->{'item'} : "Unknown item";

        print "Results for command: $tmp_action $tmp_item \n";
        print "Result Status for " . $client[$i] . " : [$tmp_result] \n";
        if (defined($tmp_reason)) {
            print "Result Reason for " . $client[$i] . " : [$tmp_reason] \n";
        }
    }

    $count++;
}

print "\n[Status]: Completed receiving response $count out of $size client machine(s).... continuing.... \n\n";

# Capture the end time
my $endTime = time();

print "Execution End Time: \t $endTime \n";
print "Execution Elapsed Time: \t " . ($endTime - $startTime) . " secs. \n";
print "Execution 100\% Complete.\n\n";

exit;


__END__


=head1 Request.pl - Sends an XML request to a list of client machines and executes the
given command on the machine.

=head1 SYNOPSIS

Request.pl --action=[action] --item=[item] --option=[option]

=head1 ACTION

=over 8

=item B<--action=[action]>

This represents the type of command to be executed on the client machine.
A list of command types are listed below:

=over 8

=item B<add>

Will add the given B<--item=[item]> to the client machine.

Supports the following B<item> values:

=over 8

=item B<userdata> - Not yet implemented

=item B<profile>

=item B<registry> - Not yet implemented

=back 2

=item B<delete>

Will delete the given B<--item=[item]> from the client machine.

Supports the following B<item> values:

=over 8

=item B<userdata>

=item B<profile>

=item B<registry>

=back 2

=item B<monitor>

Will monitor the client machine using the given monitor type represented by B<--item=[item]>.

Supports the following B<item> values:

=over 8

=item B<performance>

=back 2

=item B<collect>

Will capture the given information type represented by B<--item=[item]>.

Supports the following B<item> values:

=over 8

=item B<metrics>

=back 2

=back 2

=head1 OPTION

=item B<--option=[option]>

Depending on the command type, there can be additional options sent as part of the command.
For example, if the command is "monitor", you send an option to either "start" or "stop" the monitor.
Another example is if the command is "capture" with the item being "metrics", you can issue
an option to capture "performance".

=head1 FILE

=item B<--file=[file (optional)]>

You can optionally specify an input file to use instead of the default. The default input file is
defined within the configuration file B<Automation/Perl-Lib/Persystent/Config.pm>

=back

=cut

