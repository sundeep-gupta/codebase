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
        my $status = '';
        my $message = '';
        my $updated = '';               
        my $newentry = '';
        #connection string
        my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
);
        
        #test connection
        db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;

        #create sql string and execute it (Workers)
        my $worker_string = "SELECT board.USERID, workers.lname, workers.fname, board.STATUS, board.UPDATED, board.MESSAGE, board.NEWENTRY FROM board, workers WHERE board.USERID = workers.id AND employee LIKE 'Y' ORDER by workers.lname";
        my $worker_command = $db_connection->prepare($worker_string);
        $worker_command->execute or db_die($db_connection->errstr);
        $worker_command->bind_columns(undef, \$id, \$lname, \$fname, \$status, \$updated, \$message, \$newentry);

        my @worker_loop = ();

	while(my $worker_row = $worker_command->fetchrow_arrayref)
	{
   		my %Name;
                $Name{ID} = $id;
   		$Name{NAME} = $lname.", ".$fname;
   	        if ($status eq 1) {
                 $Name{STATUS} = "OTC";
                } else {
                 $Name{STATUS} = "WOR";
                }
                my $year = substr($updated, 0, 4);
                my $month = substr($updated, 4, 2);
                my $day = substr($updated, 6, 2);
                my $hour = substr($updated, 8, 2);
                my $minute = substr($updated, 10, 2);

                $Name{UPDATED} = $month."/".$day."/".$year." - ".$hour.":".$minute;
                $Name{MESSAGE} = $message;	
   		$Name{NEWENTRY} = $newentry;
                my $Cname = '';
                my $Pname = ''; 
                my $projects_string = "SELECT clients.Name, projects.ProjectName FROM projects, clients WHERE ((projects.ClientID = clients.ClientID) AND (projects.ProjectID = $status))";
                my $projects_command = $db_connection->prepare($projects_string);
                $projects_command->execute or db_die($db_connection->errstr);
                $projects_command->bind_columns(undef,\$Cname, \$Pname);
                my $project = $projects_command->fetchrow_arrayref;

                $Name{ALTTEXT} = $Cname." :: ".$Pname; 
                push(@worker_loop, \%Name);
	}

        $worker_command->finish;
        

                
        $db_connection->disconnect;
	
	$template->param(
                          WHOIS => $ENV{'REMOTE_USER'}, 
                          WORKERS_LOOP => \@worker_loop,
                 	 
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
         
