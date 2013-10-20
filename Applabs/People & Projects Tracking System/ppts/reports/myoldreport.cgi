#!/usr/bin/perl -w
######################################################
#              MonthReport.cgi - PPTS
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
use Date::Calc qw(:all);
        my %date = get_form();
        create_monthly_report_per_project(%date);
        exit;

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

sub create_monthly_report_per_project 
{
        #initialize variables
        my $template = HTML::Template->new(filename=>'OldMonthReport.tmpl');
        my $ProjectID='';
        my $ProjectName='';
        my $ClientName='';
        my $UserID = '';
        my $CodeID = '';
        my $StartTime = '';
        my $EndTime = '';
        my $LogID ='';   
        if ($date{chosen_month} < 10)
        {
           $date{chosen_month} = "0".$date{chosen_month};
        }   
        my $chosen_month = $date{chosen_month};
        my $chosen_year = $date{chosen_year}; 
        my ($year,$month,$day) = Today(); 
        $month = $chosen_month;
        $year = $chosen_year;
        my $DateString = ''; 
         if (check_date($year, $month, 31)) 
         { 
            $DateString = Date_to_Text($year, $month, 31);
         }
         elsif (check_date($year, $month, 30))
         {
            $DateString = Date_to_Text($year, $month, 30);
         }
         elsif (check_date($year, $month, 29))
         { 
            $DateString = Date_to_Text($year, $month, 29);
         }
         else
         {
            $DateString = Date_to_Text($year, $month, 28);
         }
 
        my $StartDateString = Date_to_Text($year, $month, 1);       

        #connection string
        my $db_connection = DBI->connect($dsn,
                                $db{user},
                                $db{pass},
                                $db{attr}
);
        
        #test connection
        db_die("Connection Failed: $DBI::errstr\n") unless $db_connection;

        #create sql string and execute it (Workers)
        my $project_string = "SELECT projects.ProjectID, projects.ProjectName, clients.Name FROM projects, clients WHERE clients.ClientID=projects.ClientID AND clients.Name != ' ' ORDER by clients.Name";
        my $project_command = $db_connection->prepare($project_string);
        $project_command->execute or db_die($db_connection->errstr);
        $project_command->bind_columns(undef, \$ProjectID, \$ProjectName, \$ClientName);
        my $num_proj = $project_command->rows; 
        my @project_loop = ();

	while(my $project_row = $project_command->fetchrow_arrayref)
	{
   		
            my %Project;

            $Project{PNAME} = $ProjectName;
            $Project{CNAME} = $ClientName;
                

            #create sql string and execute it (Workers)
            my $month_string = "SELECT LogID,  UserID, CodeID, StartTime, EndTime FROM timelog WHERE (ProjectID = '$ProjectID' AND EndTime LIKE '$year-$month-%') ORDER by ProjectID, UserID";
            my $month_command = $db_connection->prepare($month_string);    
            $month_command->execute or db_die($db_connection->errstr);   
            $month_command->bind_columns(undef, \$LogID,  \$UserID, \$CodeID, \$StartTime, \$EndTime); 
            my $month_logs = $month_command->rows;
            my $totalhours = '';
            my $totalminutes = '';
            #my @month_loop = ();
            my %hourS;     
            my %minuteS;
            while(my $month_row = $month_command->fetchrow_arrayref)
            {               
                my %Name;
                #this is a flag that will allow the report to hide projects w/o hours
		$Project{EMPTY} = 1;  

                   
                # Parse Start
                my $Syear = substr($StartTime, 0, 4);
                my $Smonth = substr($StartTime, 5, 2);
                my $Sday = substr($StartTime, 8, 2);
                my $Shour = substr($StartTime, 11, 2);
                my $Sminute = substr($StartTime, 14, 2);
                my $Ssecond = substr($StartTime, 17, 2); 
                # Parse EndTime
                my $Eyear = substr($EndTime, 0, 4);
                my $Emonth = substr($EndTime, 5, 2);       
                my $Eday = substr($EndTime, 8, 2);       
                my $Ehour = substr($EndTime, 11, 2);        
                my $Eminute = substr($EndTime, 14, 2);
                my $Esecond = substr($EndTime, 17, 2); 
                my ($Dd,$Dh,$Dm,$Ds) =
                Delta_DHMS($Syear,$Smonth,$Sday, $Shour, $Sminute, $Ssecond,
                $Eyear,$Emonth,$Eday, $Ehour,$Eminute,$Esecond); 
 
                #if ($temp_user ne $UserID)
                #{
                #   $Name{USERNAME} = $UserID;
                #}
                
                $hourS{$UserID} += $Dh;
                $minuteS{$UserID} += $Dm; 
                
                $totalhours += $Dh;
                $totalminutes += $Dm;
                #push(@month_loop,\%Name);
                #$temp_user = $UserID;

           }
          
           #$Project{LOOP} = \@month_loop;           
           my @month_loop = ();
           foreach my $user (keys %hourS)
           {
               my %Name;
               $Name{USERNAME} = $user;
               my $hours = $hourS{$user};
               my $minutes = $minuteS{$user};
               if($minutes > 60)
               {
                  $hours += int $minutes / 60;
                  $minutes = $minutes % 60;
               }
               $Name{PARTIAL} = "$hours Hours $minutes Minutes";
               push (@month_loop, \%Name); 
           }
           $Project{LOOP} = \@month_loop;
           if($totalminutes > 60)
           {
		$totalhours += int $totalminutes / 60;
                $totalminutes = $totalminutes % 60;
           }  
           $Project{TOTAL} = $totalhours." Hours ".$totalminutes." Minutes";
           push(@project_loop, \%Project);
  }
        $project_command->finish;
        

                
        $db_connection->disconnect;
	
	$template->param(
                         STARTMONTH => $StartDateString,
                         TODAY => $DateString,
                         MONTH_LOOP => \@project_loop,
                 	 
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
         
