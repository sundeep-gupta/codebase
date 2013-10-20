#!/usr/bin/perl -w
######################################################
#                 insertClients.cgi - PPTS
######################################################
# Copyright   :   (c)2000 Whetstone Logic, Inc.
# Date Started:   October 20, 2000
# Description :   This script inserts clients to 
#                 the clients table on the PPTS DB.
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
        $template->param(MESSAGE=>"Work Code has been added to PPTS.\n");
        print $template->output;
        exit;
} 
else 
{
        error('Inserting new client was not possible.<br>Please contact administrator.');
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


        my $insert_string = "INSERT INTO workcode SET ";

        foreach my $field_name (keys %form_fields)
        {
            $insert_string .= " $field_name ='".$form_fields{$field_name}."' ,";
	}
        chop($insert_string);
        
        
	my $do_insert = $db_connection->prepare($insert_string);
        $do_insert->execute or error('Could not insert data onto table');
        $do_insert->finish;

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
