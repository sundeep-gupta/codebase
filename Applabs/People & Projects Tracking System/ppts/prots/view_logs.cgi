#!/usr/bin/perl -w
######################################################
#              view_logs.cgi - PPTS
######################################################
# Copyright   : (c)2000 Whetstone Logic, Inc.
# Date Started: Feb. 20th, 2001
# Description : This script shows as a front end for the 
#               PPTS admin tools.
# Author(s)   : Anderson Silva
# Email(s)    : anderson@wslogic.com
######################################################

use strict 'vars';
use CGI_Lite;
use Conf::Configuration;

        my %data = get_form();
        #connection string
        my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
);

        #test connection
        db_die("Connection Failed: $DBI::errstr\n") unless $db_connection; 

        show_logs();
        
        $db_connection->disconnect;


        exit;


###########################
# Name       : get_form()
# Parameters : void
# Return     : string with directory name for ProTS directory
# Description: This function validates the data from
# the form. And that the script is only accessed via
# POST. And make sure no escape characters are
# entered.
###########################

sub get_form
{
        my $cgi = new CGI_Lite;

        ### Make sure it is accessed by POST
        #unless ((exists $ENV{'REQUEST_METHOD'}) &&
        #        ($ENV{'REQUEST_METHOD'} eq 'POST'))
        #{
        #        print "Content-Type: text/html\n\n";
        #        $cgi->return_error('Invalid Request Method: Requires POST');
        #}

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

sub show_logs 
{
        #initialize variables
        my $template = HTML::Template->new(filename=>'view_logs.tmpl');
        my $id ='';
        my $log = '';
        my $projectid = $data{PID};
        my $userid = '';
        my $date = ''; 


        #create sql string and execute it (Workers)
        my $log_string = 
"SELECT  ProjectLogID, UserID, Date, Log FROM projectlog WHERE ProjectID = $projectid ORDER by Date";
        my $log_command = $db_connection->prepare($log_string);
        $log_command->execute or db_die($db_connection->errstr);
        $log_command->bind_columns(undef, \$id, \$userid, \$date, \$log);

        my @log_loop = ();

	while(my $log_row = $log_command->fetchrow_arrayref)
	{
   		my %Name;
                $Name{ID} = $id;
   		$Name{USERID} = $userid;
                my $year = substr($date, 0, 4);
                my $month = substr($date, 4, 2);
                my $day = substr($date, 6, 2);
                my $hour = substr($date, 8, 2);
                my $minute = substr($date, 10, 2);

                $Name{DATE} = $month."/".$day."/".$year." - ".$hour.":".$minute;
                $Name{LOG} = $log;	
                push(@log_loop, \%Name);
	}

        $log_command->finish;
        
	$template->param(
                          WHOIS => $ENV{'REMOTE_USER'}, 
                          NAME => show_project_name($projectid),
                          PID => $projectid,
                          LOG_LOOP => \@log_loop,
                 	 
                	);  
        print "Content-Type: text/html\n\n";
        print $template->output;
}

sub show_project_name
{
        my $ProjectID=shift;
        my $ProjectName = '';
        my $ClientName = '';

        #create sql string and execute it (Projects)
        # Create Project List
        my $projects_string = "SELECT clients.Name, projects.ProjectName FROM projects, clients WHERE ((projects.ClientID = clients.ClientID) AND (projects.ProjectArchive != '1')) AND projects.ProjectID = $ProjectID ORDER by clients.Name";
       my $projects_command = $db_connection->prepare($projects_string);
       $projects_command->execute or db_die($db_connection->errstr);
       $projects_command->bind_columns(undef,\$ClientName, \$ProjectName);

       my $project_row = $projects_command->fetchrow_arrayref;
       $projects_command->finish;

       return $ClientName." :: ".$ProjectName;
}

sub db_die 
{ 
	my $errmsg = shift @_;
        print "Content-Type: text/html\n\n";
	print "<H1>DB Error: $errmsg</H1>\n";
	exit(0);
}
         
