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

my %form_data = get_form();

show_worker_info(%form_data) unless $form_data{updateNow};

if ($form_data{updateNow})
{
	if ((update_data(%form_data)) eq 1)
	{
		my $template = HTML::Template->new(filename=>'response.tmpl');
	        print "Content-Type: text/html\n\n";
                $template->param(MESSAGE=>'Worker has been updated!',);
        	print $template->output;
        	exit;
	} 
	else 
	{
        	error('Updating worker\'s information was not possible.<br>Please contact administrator.');
	}
}

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
        unless ((exists $ENV{'REQUEST_METHOD'}) &&
                ($ENV{'REQUEST_METHOD'} eq 'POST'))
        {
        	print "Content-Type: text/html\n\n";
                $cgi->return_error('Invalid Request Method: Requires POST');
        }
 
        my %form = $cgi->parse_form_data();
        
        ### Check escape characters
        foreach my $key (keys %form) 
        {
		next if (ref ($form{$key}));
                if (defined ($form{$key}) && (is_dangerous($form{$key})))
                {
			$form{$key} = escape_dangerous_chars($form{$key});
                }
        }

        delete $form{SUBMIT};
        return %form;
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
    my $template = HTML::Template->new(filename=>'modifyWorkers.tmpl');
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
    my %form_fields = @_;    
    my $chosen_worker = $form_fields{id};


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

    my $worker_row = $worker_command->fetchrow_array;
    $template->param(
                     ID => $id,
                     LNAME => $lname,
                     FNAME => $fname,
                     TITLE => $title,
                     WORKNUM => $worknum,
                     HOMENUM => $homenum,
                     CELLNUM => $cellnum,
                     ADDRESS => $address,
                     ICQ => $icq,
                     BDAY => $bday,
                    );

    print "Content-Type: text/html\n\n";
    print $template->output;
    
    $worker_command->finish;
    $db_connection->disconnect;
 
        
}

###########################
# Name       : update_data()
# Parameters : form data as hash
# Return     : 1 for success, exits if fails
# Description: Update data from forms into DB.
###########################

sub update_data
{
        my %form_fields = @_;

  	my $chosen_worker = $form_fields{id};
	#check parameter
        unless (%form_fields) 
        {
		error('Function Error: update_data() needs a parameter');
        }
        
        delete $form_fields{updateNow};
	
        #connect to DB
        my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
);

        #create sql string
        my $update_string = "UPDATE workers SET ";

        foreach my $field_name (keys %form_fields)
        {
            $update_string .= " $field_name ='".$form_fields{$field_name}."' ,";
	}

        chop($update_string);
        
        $update_string .= " WHERE id='$chosen_worker'";
 
        
	my $do_insert = $db_connection->prepare($update_string);
        $do_insert->execute or error('Could not update data on table');
        $do_insert->finish;
        return 1;
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
