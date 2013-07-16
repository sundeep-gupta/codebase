#!/usr/bin/perl -w
######################################################
#              deleteClient.cgi - PPTS
######################################################
# Copyright   : (c)2000 Whetstone Logic, Inc.
# Date Started: September 15th, 2000
# Description : This scripts takes a confirmation from 
#               the user and then deletes the DB record.
# Author(s)   : Anderson Silva
# Email(s)    : anderson@wslogic.com
######################################################

use strict;
use CGI_Lite;
use Conf::Configuration;

my %form_fields = get_form();

confirm_delete(%form_fields) unless ($form_fields{deleteNow});

if ($form_fields{deleteNow})
{
	if(delete_worker($form_fields{id}) eq 1) 
        {
    		display_success();
	} 
}

###########################
### FUNCTION DEFINTIONS ###
###########################
###########################
# Name       : confirm_delete()
# Parameters : void
# Return     : 
# Description: simple form to confirm 
# deletion of a record
###########################
sub confirm_delete
{
    my $template = HTML::Template->new(filename=>'confirmWID.tmpl');
    my $id = '';
    my $name = '';

    my %form_fields = @_;    
    my $chosen_code = $form_fields{id};

    #connection string
    my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
                                ); 
    #test connection
    db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;

    #create sql string and execute it (Client)
    my $client_string = "SELECT CodeID, CodeName
		       FROM workcode WHERE CodeID ='$chosen_code'";
    my $client_command = $db_connection->prepare($client_string);
    $client_command->execute or db_die($db_connection->errstr);
    $client_command->bind_columns(undef, \$id, \$name);

    my $client_row = $client_command->fetchrow_arrayref;
    $template->param(
                     ID => $id,
                     NAME => $name,
		     
                    );

    print "Content-Type: text/html\n\n";
    print $template->output;
    $client_command->finish;
    $db_connection->disconnect;
 
}

###########################
# Name       : get_form()
# Parameters : void
# Return     : form fields as hash
# Description: This function validates the data from 
# the form. And that the script is only accessed via
# POST. And make sure no escape characters are 
# entered.
###########################

sub get_form() 
{
    my $cgi = new CGI_Lite;

    #get form fields
    my %form = $cgi->parse_form_data('POST');
    if($cgi->is_error()) 
    {
        $cgi->return_error($cgi->get_error_message);
    }    

    #check for hacker activity
    foreach my $key (keys %form) 
    {
        next if (ref ($form{$key}));
        if (defined ($form{$key}) && (is_dangerous($form{$key}))) 
	{
		$form{$key} = escape_dangerous_chars($form{$key});
        }
    }

    if ($form{SUBMIT}) 
    {
        delete $form{'SUBMIT'};
    }

    return %form;

} #end of get_form()



sub delete_worker 
{

    my $id = shift @_;


    #connection string
    my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
                               ); 
    #test connection
    db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;

    #create sql string and execute it (Client)
    my $delete_client = "DELETE FROM workcode WHERE CodeID = '$id'";
    my $client_command = $db_connection->prepare($delete_client);
    $client_command->execute or db_die($db_connection->errstr);
     
    #perform query
    $client_command->finish;

    $db_connection->disconnect;
    return 1;
  
} 

sub display_success() {

    my $template = HTML::Template->new(filename=>'response.tmpl');
    print "Content-Type: text/html\n\n";
    my $message = "Entry has been deleted successfully";
    $template->param(MESSAGE => $message,);
    print $template->output;
    exit(0);
}

sub db_die 
{ 
	my $errmsg = shift @_;
        print "Content-Type: text/html\n\n";
	print "<H1>DB Error: $errmsg</H1>\n";
	exit(0);
}

