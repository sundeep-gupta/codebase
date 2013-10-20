#!/usr/bin/perl -w
######################################################
#              deleteWorker.cgi - PPTS
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
use Configuration;

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
    my $template = HTML::Template->new(filename=>'confirm.tmpl');
    my $id = '';
    my $lname = '';
    my $fname = '';
    my $title = '';
    my $name ='';    

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

    #create sql string and execute it (Batteries)
    my $worker_string = "SELECT id, fname, lname, title
		       FROM workers WHERE id ='$chosen_worker'";
    my $worker_command = $db_connection->prepare($worker_string);
    $worker_command->execute or db_die($db_connection->errstr);
    $worker_command->bind_columns(undef, \$id, \$fname, \$lname, \$title);

    my $worker_row = $worker_command->fetchrow_arrayref;
    $name = $lname.", ".$fname;
    $template->param(
                     ID => $id,
                     NAME => $name,
		     TITLE => $title,
		     
                    );

    print "Content-Type: text/html\n\n";
    print $template->output;
    $worker_command->finish;
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

    #create sql string and execute it (Workers)
    my $delete_worker = "DELETE FROM workers WHERE id = '$id'";
    my $worker_command = $db_connection->prepare($delete_worker);
    $worker_command->execute or db_die($db_connection->errstr);
     
    #perform query
    $worker_command->finish;

    #delete ID on BOARD
    #create sql string and execute it (Workers)
    my $delete_worker2 = "DELETE FROM board WHERE USERID = '$id'";
    my $worker_command2 = $db_connection->prepare($delete_worker2);
    $worker_command2->execute or db_die($db_connection->errstr);
     
    #perform query
    $worker_command2->finish;


    
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

