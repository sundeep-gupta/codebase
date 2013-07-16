#!/usr/bin/perl -w
######################################################
#                 in_out.cgi - PPTS
######################################################
# Copyright   :   (c)2000 Whetstone Logic, Inc.
# Date Started:   August 12, 2000
# Description :   This script updates worker's info on 
#                 database.
# Author(s)   :   Anderson Silva
# Email(s)    :   anderson@wslogic.com
######################################################

use strict;
use CGI_Lite;
use Conf::Configuration;

my %user_status = get_form();

show_user_status(%user_status) unless $user_status{updateNow};

if ($user_status{updateNow})
{
	if ((update_data(%user_status)) eq 1)
	{
		my $template = HTML::Template->new(filename=>'response.tmpl');
	        print "Content-Type: text/html\n\n";
                $template->param(MESSAGE=>'Your STATUS has been updated!',);
        	print $template->output;
        	exit;
	} 
	else 
	{
        	error('Could not update your status.<br>Please contact administrator.');
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

###########################
# Name       : show_worker_info()
# Parameters : hash with fields
# Return     : 
# Description: simple form to confirm 
# deletion of a record
###########################

sub show_user_status
{
    my $template = HTML::Template->new(filename=>'in_out.tmpl');
    my $id = '';
    my $fname = '';
    my $lname = '';
    my $status = '';
    my $message = '';
    my $Pid ='';     # Project ID   
    my $Pname = '';  # Project Name
    my $Cname = '';  # Client Name
    my $CodeID = ''; 
    my $CodeName = '';   
    my $username = '';
    my %form_data = @_;
    my $newentry = $form_data{newentry};
    my $chosen_worker = $form_data{userid};
    my $current_code_id = '';
    my $current_project_id = '';
    my $details = '';  

 
    #connection string
    my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
                                ); 
    #test connection
    db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;

    #create sql string and execute it (Worker)
    my $worker_string = "SELECT board.USERID, workers.username, workers.lname, workers.fname, board.STATUS, board.MESSAGE FROM workers, board WHERE workers.id ='$chosen_worker' AND board.USERID = '$chosen_worker'";
    my $worker_command = $db_connection->prepare($worker_string);
    $worker_command->execute or db_die($db_connection->errstr);
    $worker_command->bind_columns(undef, \$id, \$username, \$lname, \$fname, \$status, \$message);
    
    # Create Project List
    my $projects_string = "SELECT clients.Name, projects.ProjectID, projects.ProjectName FROM projects, clients WHERE ((projects.ClientID = clients.ClientID) AND (projects.ProjectArchive != '1')) ORDER by clients.Name";
    my $projects_command = $db_connection->prepare($projects_string);
    $projects_command->execute or db_die($db_connection->errstr);
    $projects_command->bind_columns(undef,\$Cname, \$Pid, \$Pname);
    
    # Create Work Code List 
    my $code_string = "SELECT CodeID, CodeName FROM workcode WHERE CodeActive = '1' ORDER by CodeName";
    my $code_command = $db_connection->prepare($code_string);
    $code_command->execute or db_die($db_connection->errstr);
    $code_command->bind_columns(undef,\$CodeID, \$CodeName);

    #board info
    my $worker_row = $worker_command->fetchrow_arrayref;
    #### We need the current IDs so we may know when to set SELECT= SELECTED
    if ((defined $newentry) && ($newentry != 0))
    {
         $current_code_id = get_code_id($newentry);
         $current_project_id = get_project_id($newentry);
    }

    #Project info
    my @projects = ();
    
    while (my $project_row = $projects_command->fetchrow_arrayref)
    {
       my %each_project;
        
       $each_project{CLIENT} = $Cname;
       $each_project{PNAME} = $Pname;
       $each_project{PID} = $Pid;
       if ($current_project_id == $Pid)
       {
           $each_project{SELECTED} = 'SELECTED';
       }
       push (@projects, \%each_project);
    }

    #workcode info

    my @codes = (); 
    
    while (my $code_row = $code_command->fetchrow_arrayref)
    {
       my %each_code;
       
       $each_code{CODEID} = $CodeID;
       $each_code{CODENAME} = $CodeName;
       if ($current_code_id eq $CodeID)
       {
           $each_code{SELECTED} = 'SELECTED';
       }
       push (@codes, \%each_code); 
    }  
   
    $template->param(
                     ID => $id,
                     USERNAME => $username, 
                     LNAME => $lname,
                     FNAME => $fname,
                     MESSAGE => $message,
                     PROJECT => \@projects,
                     CODE => \@codes,
                     NEWENTRY => $newentry,                   
                    );

 

    print "Content-Type: text/html\n\n";
    print $template->output;
    
    $worker_command->finish;
    $projects_command->finish;
    $code_command->finish;
    $db_connection->disconnect;
 
        
}

###########################
# Name       : get_code_id()
# Parameters : scalar
# Description: get current workcode id
###########################
 
sub get_code_id
{
       my $logid = shift;
       my $CodeID = '';
      
       #connection string
       my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
                                );
       #test connection
       db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;
 
       my $query_string = "SELECT CodeID FROM timelog WHERE LogID='$logid'";

       my $query_command = $db_connection->prepare($query_string);
       $query_command->execute or db_die($db_connection->errstr);
       $query_command->bind_columns(undef,\$CodeID);

       #board info
       my $code_row = $query_command->fetchrow_arrayref;
       $query_command->finish;
       $db_connection->disconnect;
       
       return $CodeID;
}


###########################
# Name       : get_project_id()
# Parameters : scalar
# Description: get current project id
###########################
 
sub get_project_id
{
       my $logid = shift; 
       my $ProjectID = '';

       #connection string
       my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
                                );
       #test connection
       db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;
       
       my $query_string = "SELECT ProjectID FROM timelog WHERE LogID='$logid'";

       my $query_command = $db_connection->prepare($query_string);
       $query_command->execute or db_die($db_connection->errstr);
       $query_command->bind_columns(undef,\$ProjectID);

       #board info
       my $code_row = $query_command->fetchrow_arrayref;
       $query_command->finish;
       $db_connection->disconnect;
       
       return $ProjectID;
}
 
###########################
# Name       : create_new_time_log() 
# Parameters : scalar 
# Description: creates new time log entry 
###########################
 
sub create_new_time_log 
{
       my $username = shift;
       my $logid = '';
 
       #connection string
       my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
                                );
       #test connection
       db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;

       #insert username on the timelog.
       my $insert_id_string = "INSERT INTO timelog SET userID = '$username'";
        
       my $do_insert = $db_connection->prepare($insert_id_string);
       $do_insert->execute or error('Could no insert data on board');
       $do_insert->finish;
       
       my $query_string = " SELECT LogID FROM timelog where userID = '$username' AND
       ProjectID = '' AND CodeID = ''";
 
       my $query_command = $db_connection->prepare($query_string);
       $query_command->execute or db_die($db_connection->errstr);
       $query_command->bind_columns(undef,\$logid);
 
       #board info
       my $log_row = $query_command->fetchrow_arrayref;
       $query_command->finish; 
       $db_connection->disconnect; 
       return $logid;
}

###########################
# Name       : my_time()
# Description: Outputs string for Mysql TIME
###########################

sub my_time
{

  my ($sec, $min, $hour, $day, $month, $year) = localtime;
  $year = $year+1900;
  $month = $month+1;
  if ($min < 10)
  {
    $min = "0".$min;
  }
  if ($hour < 10)
  {
    $hour = "0".$hour;
  }
  if ($day < 10)
  {
    $day = "0".$day;
  }
  if ($month < 10)
  {
    $month = "0".$month;
  }

  my $time = $year."-".$month."-".$day." ".$hour.":".$min;

  return $time;
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

  	my $chosen_worker_id = $form_fields{USERID};
	my $chosen_worker_username = $form_fields{username};
        my $newentry = $form_fields{newentry};
        my $projectID = $form_fields{STATUS};
        my $codeID = $form_fields{CODE};
        my $details = $form_fields{MESSAGE};        
        my $time = my_time();
        #### We need the current IDs so we may know when to start
        #### a new entry or not.
        my $current_code_id = get_code_id($newentry);
        my $current_project_id = get_project_id($newentry);

        
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


        ###### UPDATE BOARD #######

        #create sql string
        my $update_string = "UPDATE board SET ";
        delete $form_fields{username};
        delete $form_fields{CODE};
        delete $form_fields{Details};
        delete $form_fields{NEWENTRY};
        foreach my $field_name (keys %form_fields)
        {
            $update_string .= " $field_name ='".$form_fields{$field_name}."' ,";
	}

        chop($update_string);
        
        $update_string .= " WHERE USERID='$chosen_worker_id'";
 
        
	my $do_update = $db_connection->prepare($update_string);
        $do_update->execute or error('Could not update data on table');
        $do_update->finish;
        
        if ((not defined $newentry) || ($newentry == 0) || ($current_project_id != $projectID) || ($current_code_id != $codeID)) 
        {
           

             ### If project or workcode changes we also need to close the time.
             ### Sorry, I am duplicating the code here.
             if ((($current_project_id != $projectID) || ($current_code_id != $codeID)) && ($current_project_id != 1))
             { 
                 my $timelog_update_string2 = "UPDATE timelog SET EndTime='$time' ";
                 $timelog_update_string2 .= "WHERE LogID = '$newentry'";
        
                 my $do_update3 = $db_connection->prepare($timelog_update_string2);
                 $do_update3->execute or error('Could not update data on table TimeLOG'); 
                $do_update3->finish; 
             } 
 
             if ($projectID != 1)
             {
                ## Now that the record has been created,
                ## we can update the rest of the info 
                ## on the TimeLog Table.
                my $temp = 1;
                if ($newentry == 0)
                {
                  $temp = 0;
                }
                $newentry = create_new_time_log($chosen_worker_username);
                my $timelog_update_string = "UPDATE timelog SET ProjectID='$projectID', ";
                $timelog_update_string .= "CodeID = '$codeID',";
                 $timelog_update_string .= " Details = '$form_fields{MESSAGE}', ";
                $timelog_update_string .= "StartTime = '$time' WHERE LogID = '$newentry'";
             
                my $do_update2 = $db_connection->prepare($timelog_update_string);
                $do_update2->execute or error('Could not update data on table TimeLOG');
                $do_update2->finish;
             
                my $update_board = "UPDATE board SET NEWENTRY='$newentry' WHERE USERID='$chosen_worker_id'";
                my $do_update3 = $db_connection->prepare($update_board);
                $do_update3->execute or error('Could not update data on table TimeLOG');
                $do_update3->finish; 
             } else {
                my $update_board = "UPDATE board SET NEWENTRY='0' WHERE USERID='$chosen_worker_id'";
                my $do_update3 = $db_connection->prepare($update_board);
                $do_update3->execute or error('Could not update data on table TimeLOG');
                $do_update3->finish;
             }

        } else {

            ## Otherwise, simply update the EndTime Field.
            my $timelog_update_string = "UPDATE timelog SET EndTime='$time' ";
               $timelog_update_string .= "WHERE LogID = '$newentry'";
             
            my $do_update2 = $db_connection->prepare($timelog_update_string);
             $do_update2->execute or error('Could not update data on table TimeLOG');
             $do_update2->finish;

            ## If a person stays with the same client, and under the same
            ## workcode, but they want to change the message. then we query 
            ## the current detail and append the new message to it. 
            my $current_details=''; 
            my $current_update_string = "SELECT Details FROM timelog WHERE LogID = '$newentry'";
            my $command = $db_connection->prepare($current_update_string);
            $command->execute or db_die($db_connection->errstr);
            $command->bind_columns(undef, \$current_details);
            
            my $row = $command->fetchrow_arrayref;
            my $new_details = $current_details." | ".$details;
            $new_details =~ s/'/\\'/g;
            $command->finish;
 
            my $update_detail = "UPDATE timelog SET Details='$new_details' ";
               $update_detail .= "WHERE LogID = '$newentry'";      
            my $do_update3 = $db_connection->prepare($update_detail);
             $do_update3->execute or error('Could not update data on table TimeLOG');
             $do_update3->finish;
 

        }
            

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
