#!/usr/bin/perl -w
######################################################
#                 modifyProjects.cgi - PPTS
######################################################
# Copyright   :   (c)2000 Whetstone Logic, Inc.
# Date Started:   August 12, 2000
# Date Modified:  Jan. 25, 2001
# Description :   This script updates project's info on 
#                 database.
# Author(s)   :   Anderson Silva
# Email(s)    :   anderson@wslogic.com
######################################################

use strict;
use CGI_Lite;
use Conf::Configuration;

my %form_data = get_form();

show_project_info(%form_data) unless $form_data{updateNow};

if ($form_data{updateNow})
{
	if ((update_data(%form_data)) eq 1)
	{
	        create_dir(%form_data);	
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

##############################
# Name : create_dir()
# Description: checks and see if the dir is there.
# if not create the dir
#############################

sub create_dir
{
        my $client_id = $form_data{ClientID};
        my $project_name = $form_data{ProjectName};

        if (mkdir($download_dir."/".$project_name."_".$client_id, 0755))
        {}
 } 


###########################
# Name       : show_project_info()
# Parameters : hash with fields
# Return     : 
# Description: simple form to confirm 
# deletion of a record
###########################

sub show_project_info
{
    my $template = HTML::Template->new(filename=>'modifyProjects.tmpl');
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



    my %form_fields = @_;    
    my $chosen_project = $form_fields{id};


    #connection string
    my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
);
        
    #test connection
    db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;


    #####################
    #create sql string and execute it (Client)
    my $project_string = "SELECT ProjectID, ProjectName, ProjectArchive, ClientID, ProjectDescription, CoderChargeID, ProdContactID, DevContactID, ProjectStatusID, ProjectPayRate, Languages, ModLib, Extras, DevServerName, DevServerPath, ProdServerName, ProdServerPath, EstDesignTime, EstManagementTime, EstCodingTime, EstTestingTime, EstMaintanenceTime FROM projects WHERE ProjectID ='$chosen_project'";
    my $project_command = $db_connection->prepare($project_string);
    $project_command->execute or db_die($db_connection->errstr);
    $project_command->bind_columns(undef, \$id, \$name, \$archived, \$clientid, \$description, \$coder_charge, \$prod_charge, \$dev_charge, \$project_status, \$project_pay_rate, \$languages, \$modlib, \$extras, \$dev_server_name, \$dev_server_path, \$prod_server_name, \$prod_server_path, \$design, \$management, \$coding, \$testing, \$maintanence);
    
    #create sql string and execute it (Clients)
    my $clients_string = "SELECT ClientID, Name  FROM clients WHERE Name != '' ORDER by Name";
    my $clients_command = $db_connection->prepare($clients_string);
    $clients_command->execute or db_die($db_connection->errstr);
    $clients_command->bind_columns(undef, \$list_client_id, \$list_client_name);

    my @client_loop = ();
 
    my $project_row = $project_command->fetchrow_arrayref;
 
    while(my $clients_row = $clients_command->fetchrow_arrayref)
    {
          my %Name;
          $Name{CLIENTID} = $list_client_id;
          $Name{CLIENTNAME} = $list_client_name;
          if ($clientid == $list_client_id)
          {
 		$Name{SELECTED} = 'SELECTED';
          }
          else
          {
               $Name{SELECTED} = '';
          }
   
          push(@client_loop, \%Name);
    }

    $clients_command->finish;


    ################################
    #create sql string and execute it (Worker)
    my $coder_id = '';
    my $coder_lname = '';
    my $coder_fname = ''; 

    my $coder_string = "SELECT id, lname, fname FROM workers WHERE Employee LIKE 'Y' ORDER by lname";
    my $coder_command = $db_connection->prepare($coder_string);
    $coder_command->execute or db_die($db_connection->errstr);
    $coder_command->bind_columns(undef, \$coder_id, \$coder_lname, \$coder_fname);

    my @coder_loop = ();

    while(my $coder_row = $coder_command->fetchrow_arrayref)
    {
          my %Name;
          $Name{CODERID} = $coder_id;
          $Name{CODERNAME} = $coder_lname.", ".$coder_fname;
          if ($coder_charge == $coder_id)
          {
                $Name{SELECTED} = 'SELECTED';
          }
          else
          {
               $Name{SELECTED} = '';
          }
  
          push(@coder_loop, \%Name);
    }

    $coder_command->finish;



    ################################
    #create sql string and execute it (Development Contact)
    my $contact_id = '';
    my $contact_lname = ''; 
    my $contact_fname = '';

    my $contact_string = "SELECT id, lname, fname FROM workers ORDER by lname";
    my $contact_command = $db_connection->prepare($contact_string);
    $contact_command->execute or db_die($db_connection->errstr);
    $contact_command->bind_columns(undef, \$contact_id, \$contact_lname, \$contact_fname);

    my @contact_loop = ();

    while(my $contact_row = $contact_command->fetchrow_arrayref)
    {
          my %Name;
          $Name{CONTACTID} = $contact_id;
          $Name{CONTACTNAME} = $contact_lname.", ".$contact_fname;
          if ($dev_charge == $contact_id)
          {
                $Name{SELECTED} = 'SELECTED';
          }
          else
          {
               $Name{SELECTED} = '';
          }
 
          push(@contact_loop, \%Name);
    }

    $contact_command->finish;


    ################################
    #create sql string and execute it (Production Contact)
    my $contact_id2 = '';
    my $contact_lname2 = ''; 
    my $contact_fname2 = '';

    my $contact_string2 = "SELECT id, lname, fname FROM workers ORDER by lname";
    my $contact_command2 = $db_connection->prepare($contact_string2);
    $contact_command2->execute or db_die($db_connection->errstr);
    $contact_command2->bind_columns(undef, \$contact_id2, \$contact_lname2, \$contact_fname2);

    my @contact_loop2 = ();

    while(my $contact_row2 = $contact_command2->fetchrow_arrayref)
    {
          my %Name;
          $Name{CONTACTID} = $contact_id2;
          $Name{CONTACTNAME} = $contact_lname2.", ".$contact_fname2;
          if ($prod_charge == $contact_id2)
          {
                $Name{SELECTED} = 'SELECTED';
          }
          else
          {
               $Name{SELECTED} = '';
          }
 
          push(@contact_loop2, \%Name);
    }

    $contact_command2->finish;

  

    ################################
    #create sql string and execute it (Project Status)
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
          $Name{STATUSID} = $sid;
          $Name{STATUSNAME} = $sname;
          if ($project_status == $sid)
          {
                $Name{SELECTED} = 'SELECTED';
          }
          else
          {
               $Name{SELECTED} = '';
          }
 
          push(@status_loop, \%Name);
    }

    $status_command->finish;
 
    $template->param(
                    CLIENTS_LOOP => \@client_loop,
                    CODER_LOOP => \@coder_loop,
                    DEV_LOOP => \@contact_loop,
                    PROD_LOOP => \@contact_loop2,
                    STATUS_LOOP => \@status_loop,
                    );
    
    $template->param(
                     ID => $id,
                     NAME => $name,
                     DESCRIPTION => $description,
                     PROJECTPAYRATE => $project_pay_rate,
                     LANGUAGES => $languages,
                     MODLIB => $modlib,
                     EXTRAS => $extras,
                     DEVSERVERNAME => $dev_server_name,
                     DEVSERVERPATH=> $dev_server_path,
                     PRODSERVERNAME => $prod_server_name,
                     PRODSERVERPATH => $prod_server_path,
                     ESTDESIGNTIME => $design,
                     ESTMANAGEMENTTIME => $management,
                     ESTCODINGTIME => $coding,
                     ESTTESTINGTIME => $testing,
                     ESTMAINTANENCETIME => $maintanence, 
                     );
   

     print "Content-Type: text/html\n\n";
    print $template->output;
    
    $project_command->finish;
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

  	my $chosen_project = $form_fields{id};
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
        delete $form_fields{id};
        my $update_string = "UPDATE projects SET ";

        foreach my $field_name (keys %form_fields)
        {
            $update_string .= " $field_name ='".$form_fields{$field_name}."' ,";
	}

        chop($update_string);
        
        $update_string .= " WHERE ProjectID='$chosen_project'";
 
        
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
