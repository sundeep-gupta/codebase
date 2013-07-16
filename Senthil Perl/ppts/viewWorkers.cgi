#!/usr/bin/perl -w
######################################################
#                 modifyWorkers.cgi - PPTS
######################################################
# Copyright   :   (c)2000 Whetstone Logic, Inc.
# Date Started:   August 12, 2000
# Description :   This script updates worker's info on 
#                 database.
# Author(s)   :   Anderson Silva
# Email(s)    :   anderson@wslogic.com
######################################################

use strict;
use CGI_Lite;
use Conf::Configuration;

my $user = get_form();

show_worker_info($user); 


###########################
### FUNCTION DEFINTIONS ###
###########################

###########################
# Name       : get_form()
# Parameters : void
# Return     : form fields as hash
# Description: This function validates the data from 
# the form. And that the script is only accessed via
# POST. And make sure no escape characters are 
# entered.
###########################

sub get_form
{
	my $cgi = new CGI_Lite;
	
	### Make sure it is accessed by POST
        if($cgi->is_error()) {
        $cgi->return_error($cgi->get_error_message);
        }
 
        my %form = $cgi->parse_form_data('GET');
        
        ### Check escape characters
        foreach my $key (keys %form) 
        {
		next if (ref ($form{$key}));
                if (defined ($form{$key}) && (is_dangerous($form{$key})))
                {
			$form{$key} = escape_dangerous_chars($form{$key});
                }
        }

        return $form{id};
} 

###########################
# Name       : show_worker_info()
# Parameters : hash with fields
# Return     : 
# Description: simple form to confirm 
# deletion of a record
###########################

sub show_worker_info
{
    my $template = HTML::Template->new(filename=>'viewWorkers.tmpl');
    my $id = '';
    my $fname = '';
    my $lname = '';
    my $title = '';
    my $worknum = '';
    my $homenum = '';
    my $cellnum = '';
    my $address = '';
    my $icq = '';
    my $bday = '';
    my $chosen_worker = shift;
    #connection string
    my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
                                ); 
    #test connection
    db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;

    #create sql string and execute it (Worker)
    my $worker_string = "SELECT id, lname, fname, title, worknum, homenum, cellnum, address, icq, bday FROM workers WHERE id ='$chosen_worker'";
    my $worker_command = $db_connection->prepare($worker_string);
    $worker_command->execute or db_die($db_connection->errstr);
    $worker_command->bind_columns(undef, \$id, \$lname, \$fname, \$title, \$worknum, \$homenum, \$cellnum, \$address, \$icq, \$bday);

    my $worker_row = $worker_command->fetchrow_arrayref;
    $template->param(
                     LNAME => $lname,
                     FNAME => $fname,
                     TITLE => $title,
                     WORKNUM => $worknum,
                     HOMENUM => $homenum,
                     CELLNUM => $cellnum,
                     ADDRESS => $address,
                     ICQ => $icq,
                    );
    my $month = substr($bday, 5, 2);
    my $day = substr($bday, 8, 2);
    my $mybday = $month."/".$day;
    $template->param(BDAY => $mybday,);   
 
    print "Content-Type: text/html\n\n";
    print $template->output;
    
    $worker_command->finish;
    $db_connection->disconnect;
 
        
}

#######
#function name: error
#input: message to display as scalar
#output: a HTML::Template page
#description: This function displays an error page via HTML::Template.  It is
#        passed an error message in which it will display.
#######
sub error
{

    my $message = shift;

    #check for parameter
    unless (defined $message) {
        $message = "Function Error: error() requires a parameter.";
    }

    my $template = HTML::Template->new(filename=>'error.tmpl');
    $template->param('MESSAGE', $message);
    print "Content-Type: text/html\n\n";
    print $template->output;
    exit;

}
