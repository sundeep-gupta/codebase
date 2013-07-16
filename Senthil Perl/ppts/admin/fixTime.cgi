#!/usr/bin/perl -w
######################################################
#                 modifyClients.cgi - PPTS
######################################################
# Copyright   :   (c)2000 Whetstone Logic, Inc.
# Date Started:   August 12, 2000
# Description :   This script updates client's info on 
#                 database.
# Author(s)   :   Anderson Silva
# Email(s)    :   anderson@wslogic.com
######################################################

use strict;
use CGI_Lite;
use Conf::Configuration;

my %form_data = get_form();

show_user_time() unless $form_data{fixNow};

if ($form_data{fixNow})
{
        if ((update_data(%form_data)) eq 1)
	{
	   my $template = HTML::Template->new(filename=>'response.tmpl');
	   print "Content-Type: text/html\n\n";
           $template->param(MESSAGE=>'Your time has been fixed!',);
           print $template->output;
           exit;
	} 
	else 
	{
        	error('It was not possible to fix your time.<br>Please contact administrator.');
	}
}

###########################
### FUNCTION DEFINTIONS ###
###########################

###########################
# nAME       : get_form()
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
# Name       : my_time()
# Description: Outputs string for Mysql TIME
###########################

sub my_time
{

  my ($day, $month, $year) = (localtime)[3,4,5];
  $year = $year+1900;
  $month = $month+1;
  if ($day < 10)
  {
    $day = "0".$day;
  }
  if ($month < 10)
  {
    $month = "0".$month;
  }

  my %time = (DAY => $day, MONTH =>$month, YEAR => $year);

  return %time;
}


###########################
# Name       : show_client_info()
# Parameters : hash with fields
# Return     : 
# Description: simple form to confirm 
# deletion of a record
###########################

sub show_user_time
{
    my $template = HTML::Template->new(filename=>'fixTime.tmpl');
    my $logid = '';
    my $username_logged = $ENV{'REMOTE_USER'};;
    my $userID = '';
    my $startTime= '';
    my $endTime='';
    my $projectID='';
    my $workID='';
    my %date = my_time();

    #connection string
    my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
);
        
    #test connection
    db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;

    #create sql string and execute it (TimeEntry)
    my $string = "SELECT LogID, ProjectID, UserID, CodeID, StartTime, EndTime From timelog WHERE userID ='$username_logged' AND StartTime LIKE '$date{YEAR}-$date{MONTH}%' Order by LogID desc";
    my $command = $db_connection->prepare($string);
    $command->execute or db_die($db_connection->errstr);
    $command->bind_columns(undef, \$logid, \$projectID, \$userID, \$workID, \$startTime, \$endTime);

    my @loop = ();

    while(my $row = $command->fetchrow_arrayref)
    {
                my %Name;
                $Name{LOGID} = $logid;
                $Name{PID} = get_project($projectID); 
                $Name{USER} = $userID;
                $Name{WORKCODE} = get_code($workID);
                $Name{STIME} = $startTime;
                $Name{ETIME} = $endTime; 
                push(@loop, \%Name);
    }

    $command->finish;
    $template->param(  
                       WHOIS => $ENV{'REMOTE_USER'},
                       LOOP => \@loop,
                    );
    print "Content-Type: text/html\n\n";
    print $template->output;
    
    
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

       #Board info
       my $code_row = $query_command->fetchrow_arrayref;
       $query_command->finish;
       $db_connection->disconnect;

       return $CodeID;
}

###########################
# Name       : get_code()
# Parameters : scalar
# Description: return workcode name
###########################

sub get_code
{
       my $CodeID = shift;
       my $CodeName = '';

       #connection string
       my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
                                );
       #test connection
       db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;

       my $query_string = "SELECT CodeName FROM workcode WHERE CodeID='$CodeID'";

       my $query_command = $db_connection->prepare($query_string);
       $query_command->execute or db_die($db_connection->errstr);
       $query_command->bind_columns(undef,\$CodeName);

       #Board info
       my $code_row = $query_command->fetchrow_arrayref;
       $query_command->finish;
       $db_connection->disconnect;

       return $CodeName;
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

       #Board info
       my $code_row = $query_command->fetchrow_arrayref;
       $query_command->finish;
       $db_connection->disconnect;

       return $ProjectID;
}

###########################
# Name       : get_project()
# Parameters : scalar
# Description: returns project name 
###########################

sub get_project
{
       my $ProjectID = shift;
       my $ProjectName = '';
       #connection string
       my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
                                );
       #test connection
       db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;

       my $query_string = "SELECT ProjectName FROM projects WHERE ProjectID='$ProjectID'";

       my $query_command = $db_connection->prepare($query_string);
       $query_command->execute or db_die($db_connection->errstr);
       $query_command->bind_columns(undef, \$ProjectName);

       #Board info
       my $code_row = $query_command->fetchrow_arrayref;
       $query_command->finish;
       $db_connection->disconnect;

       return $ProjectName;
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

  	my $chosen_entry = $form_fields{LogID};
	#check parameter
        unless (%form_fields) 
        {
		error('Function Error: update_data() needs a parameter');
        }
        
        delete $form_fields{fixNow};
	
        #connect to DB
        my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
);

        #create sql string
        my $update_string = "UPDATE timelog SET ";
        delete $form_fields{LogID};
        foreach my $field_name (keys %form_fields)
        {
            $update_string .= " $field_name ='".$form_fields{$field_name}."' ,";
	}

        chop($update_string);
        
        $update_string .= " WHERE LogID='$chosen_entry'";
 
        
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
