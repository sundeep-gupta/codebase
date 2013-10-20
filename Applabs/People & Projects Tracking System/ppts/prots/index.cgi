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

        # Shows Project Lists
        my $template = HTML::Template->new(filename=>'indexpage.tmpl');    
        #connection string
        my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}

        );

        #test connection
        db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;
 
        indexpage();
        
        my %project = get_form();
        if ($project{checkNow})
        {
            show_project($project{PID});
        } 
        print "Content-Type: text/html\n\n";
        print $template->output;
        
        $db_connection->disconnect;
        exit;



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



#############################
# indexpage () - shows list of projects available under PPTS/ProTS

sub indexpage
{
        #initialize variables
#        my $template = HTML::Template->new(filename=>'indexpage.tmpl');
        my $ProjectID='';
        my $ProjectName = '';
        my $ClientName = '';

        #create sql string and execute it (Projects)
        # Create Project List
        my $projects_string = "SELECT clients.Name, projects.ProjectID, projects.ProjectName FROM projects, clients WHERE ((projects.ClientID = clients.ClientID) AND (projects.ProjectArchive != '1')) ORDER by clients.Name";
       my $projects_command = $db_connection->prepare($projects_string);
       $projects_command->execute or db_die($db_connection->errstr);
       $projects_command->bind_columns(undef,\$ClientName, \$ProjectID, \$ProjectName);

       my @projects = ();
       while (my $project_row = $projects_command->fetchrow_arrayref)
       {
          my %each_project;
          $each_project{CLIENT} = $ClientName;
          $each_project{PNAME} = $ProjectName;
          $each_project{PID} = $ProjectID;

           push (@projects, \%each_project);
        }


	$template->param(
                          WHOIS => $ENV{'REMOTE_USER'}, 
                          PROJECTS_LOOP => \@projects,
                 	 
                	);  
        #print "Content-Type: text/html\n\n";
        #print $template->output;

}

#show_project - show the actual info about chosen projects
#parameters: Project ID


sub show_project
{

    #my $template = HTML::Template->new(filename=>'indexpage.tmpl');
    my $id = '';
    my $name = '';
    my $clientid = '';
    my $archived = '';
    my $description = '';
    my $list_client_id = '';
    my $list_client_name = '';
    my $coder_charge = '';
    my $dev_charge = '';
    my $prod_charge = '';
    my $project_status = '';
    my $project_pay_rate = '';
    my $languages = '';
    my $modlib = '';
    my $extras = '';
    my $dev_server_name = '';
    my $dev_server_path = '';
    my $prod_server_name = '';
    my $prod_server_path = '';
    my $design = '';
    my $coding = '';
    my $management = '';
    my $testing = '';
    my $maintanence = '';

    my $chosen_project = $project{PID};



    #####################
    #create sql string and execute it (Project)
    my $project_string = "SELECT ProjectID, ProjectName, ProjectArchive, ClientID, ProjectDescription, CoderChargeID, ProdContactID, DevContactID, ProjectStatusID, ProjectPayRate, Languages, ModLib, Extras, DevServerName, DevServerPath, ProdServerName, ProdServerPath, EstDesignTime, EstManagementTime, EstCodingTime, EstTestingTime, EstMaintanenceTime FROM projects WHERE ProjectID ='$chosen_project'";
    my $project_command = $db_connection->prepare($project_string);
    $project_command->execute or db_die($db_connection->errstr);
    $project_command->bind_columns(undef, \$id, \$name, \$archived, \$clientid,
\$description, \$coder_charge, \$prod_charge, \$dev_charge, \$project_status, \$project_pay_rate, \$languages, \$modlib, \$extras, \$dev_server_name, \$dev_server_path, \$prod_server_name, \$prod_server_path, \$design, \$management, \$coding, \$testing, \$maintanence);

    my $project_row = $project_command->fetchrow_arrayref;
    ##########
    #create sql string and execute it (Clients)
    my $clients_string = "SELECT Name  FROM clients WHERE ClientID = '$clientid'";
    my $clients_command = $db_connection->prepare($clients_string);
    $clients_command->execute or db_die($db_connection->errstr);
    $clients_command->bind_columns(undef, \$list_client_name);


    my $clients_row = $clients_command->fetchrow_arrayref;

    ################################
    #create sql string and execute it (Worker)
    my $coder_id = '';
    my $coder_lname = '';
    my $coder_fname = '';

    my $coder_string = "SELECT id, lname, fname FROM workers WHERE id = '$coder_charge'";
    my $coder_command = $db_connection->prepare($coder_string);
    $coder_command->execute or db_die($db_connection->errstr);
    $coder_command->bind_columns(undef, \$coder_id, \$coder_lname, \$coder_fname);

    my $coder_row = $coder_command->fetchrow_arrayref;



    ################################
    #create sql string and execute it (Development Contact)
    my $contact_id = '';
    my $contact_lname = '';
    my $contact_fname = '';

    my $contact_string = "SELECT id, lname, fname FROM workers WHERE id ='$dev_charge'";
    my $contact_command = $db_connection->prepare($contact_string);
    $contact_command->execute or db_die($db_connection->errstr);
    $contact_command->bind_columns(undef, \$contact_id, \$contact_lname, \$contact_fname);


    my $contact_row = $contact_command->fetchrow_arrayref;


    ################################
    #create sql string and execute it (Production Contact)
    my $contact_id2 = '';
    my $contact_lname2 = '';
    my $contact_fname2 = '';

    my $contact_string2 = "SELECT id, lname, fname FROM workers WHERE id ='$prod_charge'";    
    my $contact_command2 = $db_connection->prepare($contact_string2);
    $contact_command2->execute or db_die($db_connection->errstr);
    $contact_command2->bind_columns(undef, \$contact_id2, \$contact_lname2, \$contact_fname2);

    my $contact_row2 = $contact_command2->fetchrow_arrayref;

 

    ################################
    #create sql string and execute it (Project Status)
    my $sid = '';
    my $sname = '';
    #create sql string and execute it (Project Status)
    my $status_string = "SELECT PStatusID, StatusName  FROM projectstatus WHERE
PStatusID = '$project_status'";
    my $status_command = $db_connection->prepare($status_string);
    $status_command->execute or db_die($db_connection->errstr);
    $status_command->bind_columns(undef, \$sid, \$sname);

    my $status_row = $status_command->fetchrow_arrayref;
    
    $modlib =~ s/\n/<BR>/g;
    $languages =~ s/\n/<BR>/g; 
    #my $urlname = urlencode($name);
    $template->param(
                     PROJECTS => 1,
                     PID => $project{PID},
                     CLIENTID => $clientid,
                     CLIENT => $list_client_name, 
                     NAME => $name,
                     PROJECTPAYRATE => $project_pay_rate,
                     LANGUAGES => $languages,
                     MODLIB => $modlib,
                     EXTRAS => $extras,
                     PSTATUS => $sname,
                     CODER => $coder_lname.", ".$coder_fname,
                     CODERID => $coder_id,
                     DEVCONTACT => $contact_lname.", ".$contact_fname,
                     DEVCONTACTID => $contact_id,
                     DEVSERVERNAME => $dev_server_name,
                     DEVSERVERPATH=> $dev_server_path,
                     PRODCONTACT => $contact_lname2.", ".$contact_fname2, 
                     PRODCONTACTID => $contact_id2, 
                     PRODSERVERNAME => $prod_server_name,
                     PRODSERVERPATH => $prod_server_path,
                     ESTDESIGNTIME => $design,
                     ESTMANAGEMENTTIME => $management,
                     ESTCODINGTIME => $coding,
                     ESTTESTINGTIME => $testing,
                     ESTMAINTANENCETIME => $maintanence,
                     #URLENCODE => $urlname,
                     );


     #print "Content-Type: text/html\n\n";
    #print $template->output;

    $project_command->finish;
    $clients_command->finish;
    $status_command->finish;
    $contact_command->finish;
    $contact_command2->finish;

}
   













sub db_die 
{ 
	my $errmsg = shift @_;
        print "Content-Type: text/html\n\n";
	print "<H1>DB Error: $errmsg</H1>\n";
	exit(0);
}
         
