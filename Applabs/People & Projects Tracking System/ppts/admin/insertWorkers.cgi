#!/usr/bin/perl -w
######################################################
#                 insertWorkers.cgi - PPTS
######################################################
# Copyright   :   (c)2000 Whetstone Logic, Inc.
# Date Started:   August 12, 2000
# Description :   This script inserts the workers to 
#                 the workers table on the PPTS DB.
# Author(s)   :   Anderson Silva
# Email(s)    :   anderson@wslogic.com
######################################################

use strict;
use CGI_Lite;
use Conf::Configuration;

my %form_data = get_form();

if ((insert_data(%form_data)) eq 1)
{
	my $template = HTML::Template->new(filename=>'response.tmpl');
        print "Content-Type: text/html\n\n";
        $template->param(MESSAGE=>"Worker has been added to PPTS.\n");
        print $template->output;
        exit;
} 
else 
{
        error('Inserting new worker was not possible.<br>Please contact administrator.');
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
# Name       : insert_data()
# Parameters : form data as hash
# Return     : 1 for success, 0 for failure
# Description: Insert data from forms into DB.
###########################

sub insert_data
{
        my %form_fields = @_;

	#check parameter
        unless (%form_fields) 
        {
		error('Function Error: insert_data() needs a parameter');
        }

	
        #connect to DB
        my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
);

        #create sql string
        my $date = "0000-".$form_fields{month}."-".$form_fields{day};

        delete $form_fields{month};
        delete $form_fields{day};

        my $insert_string = "INSERT INTO workers SET ";

        foreach my $field_name (keys %form_fields)
        {
            $insert_string .= " $field_name ='".$form_fields{$field_name}."' ,";
	}
            $insert_string .= " bday ='$date' ";
        #chop($insert_string);
        
        
	my $do_insert = $db_connection->prepare($insert_string);
        $do_insert->execute or error('Could not insert data onto table');
        $do_insert->finish;

        #data has been inserted, now read the ID, and insert on the BOARD.
        my $chosen_id = '';
        
        my $query_id_string = "SELECT id FROM workers WHERE ";
           $query_id_string .= "fname = '".$form_fields{fname}."' AND lname = '".$form_fields{lname}."'";
        

        my $do_query = $db_connection->prepare($query_id_string);
        $do_query->execute or error('Could not query data onto table');
        $do_query->bind_columns(undef, \$chosen_id);

        my $row = $do_query->fetchrow_arrayref;

        #insert ID on the BOARD.
        my $insert_id_string = "INSERT INTO board SET USERID = '$chosen_id'";
        
        my $do_insert2 = $db_connection->prepare($insert_id_string);
        $do_insert2->execute or error('Could no insert data on board');
        $do_insert2->finish;


        $do_query->finish;
        $db_connection->disconnect;


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
