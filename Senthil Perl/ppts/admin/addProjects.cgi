#!/usr/bin/perl -w
######################################################
#              addProject.cgi - PPTS
######################################################
# Copyright   : (c)2000 Whetstone Logic, Inc.
# Date Started: October 20th, 2000
# Date Modified:January 25th, 2001
# Description : This script shows as a front end for the 
#               insert Project.
# Author(s)   : Anderson Silva
# Email(s)    : anderson@wslogic.com
######################################################

use strict 'vars';
use CGI_Lite;
use Conf::Configuration;

        showclients();
        exit;

sub showclients
{
        #initialize variables
        my $template = HTML::Template->new(filename=>'addProjects.tmpl');
        my $id='';
        my $client = '';
                

        #connection string
        my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
                               );
        
        #test connection
        db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;

        #create sql string and execute it (Clients)
        my $clients_string = "SELECT ClientID, Name  FROM clients WHERE Name != '' ORDER by Name";
        my $clients_command = $db_connection->prepare($clients_string);
        $clients_command->execute or db_die($db_connection->errstr);
        $clients_command->bind_columns(undef, \$id, \$client);


        my @client_loop = ();

	while(my $clients_row = $clients_command->fetchrow_arrayref)
	{
   		my %Name;
                $Name{ID} = $id;
                $Name{NAME} = $client;
   	        	
   		push(@client_loop, \%Name);
	}

        $clients_command->finish;
 
        my $sid = '';
        my $sname = '';
        #create sql string and execute it (Project Status)
        my $status_string = "SELECT PStatusID, StatusName  FROM projectstatus WHERE StatusName != '' ORDER by StatusName";
        my $status_command = $db_connection->prepare($status_string);
        $status_command->execute or db_die($db_connection->errstr);
        $status_command->bind_columns(undef, \$sid, \$sname);


        my @status_loop = ();

        while(my $status_row = $status_command->fetchrow_arrayref)
        {
                my %Name;
                $Name{ID} = $sid;
                $Name{NAME} = $sname;

                push(@status_loop, \%Name);
        }

        $status_command->finish;
        
        my $Cid = '';
        my $clname = '';
        my $cfname = '';
        #create sql string and execute it (Contact Info)
        my $contact_string = "SELECT id, lname, fname FROM workers ORDER by lname";
        my $contact_command = $db_connection->prepare($contact_string);
        $contact_command->execute or db_die($db_connection->errstr);
        $contact_command->bind_columns(undef, \$Cid, \$clname, \$cfname);


        my @contact_loop = ();

        while(my $contact_row = $contact_command->fetchrow_arrayref)
        {
                my %Name;
                $Name{ID} = $Cid;
                $Name{NAME} = $clname.", ".$cfname;

                push(@contact_loop, \%Name);
        }

        $contact_command->finish;
 
        my $wid = '';
        my $wlname = '';
        my $wfname = '';
        #create sql string and execute it (Employee Info)
        my $w_string = "SELECT id, lname, fname FROM workers WHERE Employee LIKE 'Y' ORDER by lname";
        my $w_command = $db_connection->prepare($w_string);
        $w_command->execute or db_die($db_connection->errstr);
        $w_command->bind_columns(undef, \$wid, \$wlname, \$wfname);


        my @w_loop = ();

        while(my $w_row = $w_command->fetchrow_arrayref)
        {
                my %Name;
                $Name{ID} = $wid;
                $Name{NAME} = $wlname.", ".$wfname;

                push(@w_loop, \%Name);
        }

        $w_command->finish;



        $db_connection->disconnect;
	
	$template->param(
                         CLIENT_LOOP => \@client_loop,
                 	 STATUS_LOOP  => \@status_loop,
                         CONTACT_LOOP => \@contact_loop,
                         WORKERS_LOOP => \@w_loop, 
                	);  
        print "Content-Type: text/html\n\n";
        print $template->output;

}

sub db_die 
{ 
	my $errmsg = shift @_;
        print "Content-Type: text/html\n\n";
	print "<H1>DB Error: $errmsg</H1>\n";
	exit(0);
}
         


