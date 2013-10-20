#!/usr/bin/perl -w
######################################################
#              index.cgi - PPTS
######################################################
# Copyright   : (c)2000 Whetstone Logic, Inc.
# Date Started: September 4th, 2000
# Description : This script shows as a front end for the 
#               PPTS admin tools.
# Author(s)   : Anderson Silva
# Email(s)    : anderson@wslogic.com
######################################################

use strict 'vars';
use CGI_Lite;
use Conf::Configuration;

        indexpage();
        exit;

sub indexpage
{
        #initialize variables
        my $template = HTML::Template->new(filename=>'indexpage.tmpl');
        my $id='';
        my $fname = '';
        my $lname = '';
        my $name = '';
        my $ClientID = '';
        my $Name = '';
        my $ProjectID = '';
        my $ProjectName = '';   
        my $CodeID = '';
        my $CodeName = '';     

        #connection string
        my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
                               );
        
        #test connection
        db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;

        #create sql string and execute it (Workers)
        my $worker_string = "SELECT id, fname, lname FROM workers ORDER by lname";
        my $worker_command = $db_connection->prepare($worker_string);
        $worker_command->execute or db_die($db_connection->errstr);
        $worker_command->bind_columns(undef, \$id, \$fname, \$lname);


        my @worker_loop = ();

	while(my $worker_row = $worker_command->fetchrow_arrayref)
	{
   		my %Name;
                $Name{ID} = $id;
   		$Name{NAME} = $lname.", ".$fname;
   		
   		push(@worker_loop, \%Name);
	}

        $worker_command->finish;
        
        #create sql string and execute it (Workers)
        my $client_string = "SELECT ClientID, Name FROM clients ORDER by Name";
        my $client_command = $db_connection->prepare($client_string);
        $client_command->execute or db_die($db_connection->errstr);
        $client_command->bind_columns(undef, \$ClientID, \$Name);


        my @client_loop = ();

        while(my $client_row = $client_command->fetchrow_arrayref)
        {
                my %Name;
                $Name{ID} = $ClientID;
                $Name{NAME} = $Name;

                push(@client_loop, \%Name);
        }

        $client_command->finish;
        
        #create sql string and execute it (Workers)        
        my $project_string = "SELECT ProjectID, ProjectName FROM projects ORDER by ProjectName"; 
        my $project_command = $db_connection->prepare($project_string);       
        $project_command->execute or db_die($db_connection->errstr);       
        $project_command->bind_columns(undef, \$ProjectID, \$ProjectName);              


        my @project_loop = ();
 
        while(my $project_row = $project_command->fetchrow_arrayref)      
        {
                my %Name;
                $Name{ID} = $ProjectID;
                $Name{NAME} = $ProjectName;                 
 
                push(@project_loop, \%Name);  
        }

        $project_command->finish; 

        #create sql string and execute it (WorkCode)
        my $code_string = "SELECT CodeID, CodeName FROM workcode ORDER by CodeName"; 
        my $code_command = $db_connection->prepare($code_string);
        $code_command->execute or db_die($db_connection->errstr);
        $code_command->bind_columns(undef, \$CodeID, \$CodeName);



        my @code_loop = ();

        while(my $code_row = $code_command->fetchrow_arrayref)
        {
                my %Name;
                $Name{ID} = $CodeID;
                $Name{NAME} = $CodeName;

                push(@code_loop, \%Name);
        }

        $code_command->finish;
                
        $db_connection->disconnect;
	
	$template->param(
                         WORKERS_LOOP => \@worker_loop,
                 	 CLIENTS_LOOP => \@client_loop,
                         PROJECTS_LOOP => \@project_loop, 
                         CODE_LOOP => \@code_loop,         
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
         


