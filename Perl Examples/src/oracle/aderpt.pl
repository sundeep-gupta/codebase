#!/usr/bin/perl -w

use strict;
use Cwd;
use Data::Dumper;
use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft Excel';

die "Usage: $0 xls_file_name_full_path report_name \n aderpt.pl 090207 090207\n" unless ($ARGV[0]);
my $pwd_dir      = getcwd() or die ("Could not get the current working directory\n");
my $xls_filename = $pwd_dir.'weekly/'.$ARGV[0].'.xls';
die "$xls_filename not found. The program will terminate\n" unless -e $xls_filename;

my $txt_filename = $pwd_dir.'/weekly/'.$ARGV[0].'.txt';
my $pc_filename = $pwd_dir.'/weekly/'.$ARGV[0].'_pc.html';

### CONSTANTS ##############
my $bug_reported       = 'BUG_REPORTED';
my $enhancement_logged = 'ENHANCEMENT_LOGGED';
my $default_assigned   = 'Closed by Customer';
my @color              = ('red','blue','green','black');
my $name_uid_map = [ [
   'Wielowieyski, Andrzej','Closed by Customer' ,'Goddard, Denis Michael (Denis)','Totten, Grant',
   'Krishnamurthy, Harish Chandar' , 'Harish Settyappa',
   'Devito, Jonathan Edward (Jon)' ,  'Doskow, Jonathan (Jon)' , 'Klouda, Jiri','Tu, Ying-Chieh (Kevin)', 'Majumder, Kuntal',
   'Purushothaman, Manikandan Maluvadu' ,'Kedlaya, Natesh', 'Bansal, Nakul' , 'Puttanarasaiah, Niranjan Madenahalli', 'Kothari, Prasanna Praful' ,
   'Venkatasamy, Purushothaman (Purush)', 'Pandey, Rahul (Rahul)',    'Vuddaraju, Ravikumar Raju','KAZAK, Mr. ROHINTON (ROHINTON)',
   'Mahaney, Gordon Ralston (Sam)' , 'Gandhi, Sanjai' ,'Gupta, Sundeep Kumar' , 'Tim',
   'Nguyen, Thong H.', 'Arunachalam, Venkatesan', 'Gururaja, Vijay','Muraleedharan, Vinod' , 'Grigoryev, Vladimir Albert (Vladimir)'
                     ] ,
                     [
                      'Andrzej', 'Customer', 'Denis', 'Grant', 'HarishC', 'HarishS', 'JDevito', 'JDoskow', 'Jiri', 'Kevin', 'Kuntal', 'Mani', 'Natesh', 'Nakul', 'Niranjan',
                      'Prasanna', 'Purush', 'Rahul',  'Ravi', 'Rohinton', 'Sam', 'Sanjai', 'Sundeep', 'Tim', 'Thong', 'Venkat', 'Vijay', 'Vinod', 'Vladimir'
                     ] ];

# get already active Excel application or open new
my $Excel = Win32::OLE->GetActiveObject('Excel.Application') || Win32::OLE->new('Excel.Application', 'Quit');
my $rh_parsed = &read_xls($Excel, $xls_filename);
$Excel->Quit;
open (my $FH, ">$txt_filename") or die "Could not open the file $txt_filename for writing\n";
printf $FH "|  %s  ", $ARGV[0];

for( my $i = 0; $i <  @{ $name_uid_map->[1] }; $i++ ) {
  my $count = 0;
  if($rh_parsed->{assigned_report}->{ $$name_uid_map[0]->[$i]} ){
    $count = $rh_parsed->{assigned_report}->{ $$name_uid_map[0]->[$i]};
  }
  printf $FH "|  %s  ",$count;
}
print $FH "| |\n";
print $FH "| ".$ARGV[0];
print $FH "| ".$rh_parsed->{sr_count}," | ", $rh_parsed->{bug_count}, " | ", $rh_parsed->{enhancement_count} , " | ";

create_problem_code($pc_filename, $$rh_parsed{summary}, $$rh_parsed{sr_count});


sub create_report {
	my $file = $_[0];
	my $rh_report = $_[1];
    my $title = $_[2];

	open(my $REPORT, ">$file") or die "could not open $file\n";
	print_header_start( $REPORT ,$title);

	print_report($REPORT, $rh_report);
	print_header_end( $REPORT);
}

sub create_problem_code {
	my $file        = $_[0];
	my $rh_summary  = $_[1];
	my $sr_reported = $_[2];
	open(my $PC_HANDLE, ">$file") or die "could not open $file\n";

	print_header_start($PC_HANDLE, "SR's Closed - By Problem Code");
	print_bug_count_table($PC_HANDLE, $sr_reported);
	print_table_header($PC_HANDLE);
	my $bgcolor = '#FFFFCC';

	foreach my $prob_type (keys %$rh_summary) {
		$bgcolor = $bgcolor eq '#FFFFFF' ? '#FFFFCC':'#FFFFFF';
  	  my $td_attr = 'align="center" class="twikiFirstCol" bgcolor="'.$bgcolor.'"';
	  print $PC_HANDLE  '<tr>';
	  print $PC_HANDLE  '<td '.$td_attr.' rowspan = "'. scalar(keys(%{$rh_summary->{$prob_type}}))  .'">';
	  print $PC_HANDLE $prob_type ." [ ".scalar(keys(%{$rh_summary->{$prob_type}})) ." ] ";
	  print $PC_HANDLE '</td>';
	  my $first = 0;
	  foreach my $sr (keys %{$rh_summary->{$prob_type}} ) {
	    unless ($first ) {
	           $first = 1;
	    } else {
	        print $PC_HANDLE "<tr style='color:".$color[$rh_summary->{$prob_type}->{$sr}->{priority} - 1].";'>";
	    }
	    print $PC_HANDLE "<td $td_attr > <a href='http://ade.oraclecorp.com/cgi-bin/querySR.pl?srnumber=$sr'>".$sr."</a></td>\n";
	    print $PC_HANDLE "<td $td_attr >".$rh_summary->{$prob_type}->{$sr}->{summary}."</td>\n";
	    print $PC_HANDLE "<td $td_attr>".$rh_summary->{$prob_type}->{$sr}->{resolution}."</td></tr>\n";
	  }
	}
	print_header_end($PC_HANDLE);
}


sub print_header_start {
	my $FILE_HANDLE = $_[0];
	my $header      = $_[1];
  print $FILE_HANDLE '<html>';
  print $FILE_HANDLE '
  	<title>'.$header.'</title><style type="text/css" media="all">
  	/* Default TWiki layout */
  	@import url("http://ade.oraclecorp.com/twiki/pub/TWiki/PatternSkin/layout.css");
  	/* Default TWiki style */
  	@import url("http://ade.oraclecorp.com/twiki/pub/TWiki/PatternSkin/style.css");
  	/* Custom overriding layout per web or per topic */
  	@import url("%USERLAYOUTURL%");
  	/* Custom overriding style per web or per topic */
  	@import url("%USERSTYLEURL%");
  	.twikiToc li {
  		list-style-image:url(http://ade.oraclecorp.com/twiki/pub/TWiki/PatternSkin/i_arrow_down.gif);
  	}
  	.twikiWebIndicator {
  		background-color:#33FF66;
  	}
  </style>';
  print  $FILE_HANDLE '<body>';
  print  $FILE_HANDLE '<section>		<h1><a name="summary"> </a>'. $header.'</h1> <br><center>';


}

sub print_report {
	my $FILE_HANDLE = $_[0];
	my $ra_report = $_[1];

	print  $FILE_HANDLE '<table border="1" cellpadding="0" cellspacing="1" width = 50%>'    ;
 	print  $FILE_HANDLE '<tr>';
    foreach my $th (@{$$ra_report[0]}) {
    	print  $FILE_HANDLE '<th class="twikiFirstCol" bgcolor="#99cccc">'.$th.' </th>';
    }
	print  $FILE_HANDLE '</tr>';

    shift @$ra_report;
  	my $bgcolor = '#FFFFCC';
    foreach my $week (@$ra_report) {
      $bgcolor = $bgcolor eq '#FFFFFF' ? '#FFFFCC':'#FFFFFF';
  	  my $td_attr = 'align="center" class="twikiFirstCol" bgcolor="'.$bgcolor.'"';
      print  $FILE_HANDLE '<tr>';
      foreach my $td (@$week) {
      	print  $FILE_HANDLE '<td '.$td_attr.'>'.$td.' </th>';
      }
      print  $FILE_HANDLE '</tr>';
    }
  	print $FILE_HANDLE '</table><br/><br/><br/>';

}

sub print_table_header {
	my $FILE_HANDLE = $_[0];
	print  $FILE_HANDLE '<table border="1" cellpadding="0" cellspacing="1" width = 70%>'    ;
	print  $FILE_HANDLE '<tr>
  		<th class="twikiFirstCol" bgcolor="#99cccc">Problem Type </th>
  		<th class="twikiFirstCol" bgcolor="#99cccc">SR Num</th>
  		<th  class="twikiFirstCol" bgcolor="#99cccc">Summary</th>
  		<th  class="twikiFirstCol" bgcolor="#99cccc">Resolution</th></th>
  	</tr>
  ';
}
sub print_header_end {
	my $FILE_HANDLE = $_[0];
    print $FILE_HANDLE '</table></body></html>';
}

sub read_xls {
  my ($Excel, $xls_file) = @_;
  # open Excel file
  my $Book = $Excel->Workbooks->Open($xls_file);
  my $Sheet = $Book->Worksheets(1);



  my $sr_col              = 1;
  my $priority_col        = 2;
  my $summary_col         = 3;
  my $prob_type_col       = 9;
  my $resolution_code_col = 11;
  my $resolution_col      = 12;
  my $assigned_col        = 4;

  my $i                 = 4;
  my $sr_reported       = 0;
  my $bugs_reported_cnt = 0;
  my $rh_summary        = {};
  my $rh_bug            = ();
  my $rh_assigned       = ();
  my $enhancement_cnt   = 0;

  my ($old_prob_type, $sr);


  while (($sr = $Sheet->Cells($i,$sr_col)->{'Value'} ) ) {

    my $prob_type  = $Sheet->Cells($i, $prob_type_col)->{'Value'};
    my $resolution = $Sheet->Cells($i, $resolution_col)->{'Value'};
    my $priority   = $Sheet->Cells($i, $priority_col)->{'Value'};
    my $summary    = $Sheet->Cells($i, $summary_col)->{'Value'};
  	my $resolution_code =$Sheet->Cells($i, $resolution_code_col)->{'Value'};
  	my $assigned = $Sheet->Cells($i, $assigned_col)->{'Value'};

  	$assigned =~ s/^\s+//; $assigned =~ s/\s+$//;
  	$assigned = $default_assigned unless $assigned;
  	if ($assigned) {
  		$rh_assigned->{$assigned} = $rh_assigned->{$assigned} ? $rh_assigned->{$assigned} + 1 :1;
    }

    if ($prob_type ) {
        $old_prob_type = $prob_type;
        $rh_summary->{$prob_type}->{$sr}->{summary}         = $summary || "";
        $rh_summary->{$prob_type}->{$sr}->{resolution}      = $resolution || "";
        $rh_summary->{$prob_type}->{$sr}->{resolution_code} = $resolution_code || "";
        $rh_summary->{$prob_type}->{$sr}->{priority}        = $priority || 3;
  
    } elsif($old_prob_type) {
         $rh_summary->{$old_prob_type}->{$sr}->{summary}         = $summary || "";
         $rh_summary->{$old_prob_type}->{$sr}->{resolution}      = $resolution || "";
         $rh_summary->{$old_prob_type}->{$sr}->{resolution_code} = $resolution_code || "";
         $rh_summary->{$old_prob_type}->{$sr}->{priority}        = $priority || 3;
    }
  if ($resolution_code && ($resolution_code eq $bug_reported || $resolution_code eq $enhancement_logged) ) {
  	    if ($resolution && $resolution =~ /(\d{7})/) {
  		   $resolution = "<a href='https://bug.oraclecorp.com/pls/bug/webbug_print.show?c_rptno=$1'>$1<\/a>";
  	    } else {
  		    $resolution = "";
  	    }

      	if ($prob_type ) {
  	        $old_prob_type = $prob_type;
  	        $rh_bug->{$prob_type}->{$sr}->{summary}         = $summary || "";
  	        $rh_bug->{$prob_type}->{$sr}->{resolution}      = $resolution || "";
  	        $rh_bug->{$prob_type}->{$sr}->{resolution_code} = $resolution_code || "";
  	        $rh_bug->{$prob_type}->{$sr}->{priority}        = $priority || 3;
  	    } elsif($old_prob_type) {
  	         $rh_bug->{$old_prob_type}->{$sr}->{summary}         = $summary || "";
  	         $rh_bug->{$old_prob_type}->{$sr}->{resolution}      = $resolution || "";
  	         $rh_bug->{$old_prob_type}->{$sr}->{resolution_code} = $resolution_code || "";
  	         $rh_bug->{$old_prob_type}->{$sr}->{priority}        = $priority || 3;
  	    }
  	    if( $resolution_code eq $enhancement_logged ) {
  		    $enhancement_cnt++ ;
  	    } else {
  	        $bugs_reported_cnt++ ;
          }
      }
      $i++;
      $sr_reported++;
  }

  # clean up after ourselves
  $Book->Close;
 return  {'summary' => $rh_summary,
    'assigned_report' => $rh_assigned,
    'bug_report' => $rh_bug,
    'sr_count' => $sr_reported,
    'bug_count' => $bugs_reported_cnt,
    'enhancement_count' => $enhancement_cnt};
#    return ($rh_summary, $rh_assigned, $rh_bug, $sr_reported, $bugs_reported_cnt, $enhancement_cnt);

}


##################################################################################################################
#                OBSOLETE METHODS
##################################################################################################################

sub print_bug_count_table {
	my $FILE_HANDLE = $_[0];
	my $sr_reported = $_[1];
	my $bugs_reported = $_[2];
	my $enhancement_logged = $_[3];

	print  $FILE_HANDLE '<table border="1" cellpadding="0" cellspacing="1" width = 50%>'    ;
	print  $FILE_HANDLE '<tr>
  		<th class="twikiFirstCol" bgcolor="#99cccc">SR\'s Reported </th>
  		<td>'.$sr_reported.'</td>
  	</tr>';
  	print  $FILE_HANDLE '<tr>
  		<th class="twikiFirstCol" bgcolor="#99cccc">Bugs Reported </th>
  		<td>'.$bugs_reported.'</td>
  	</tr>' if $bugs_reported ;
  	print  $FILE_HANDLE '<tr>
  		<th class="twikiFirstCol" bgcolor="#99cccc">Enhancements Reported </th>
  		<td>'.$enhancement_logged.'</td>
  	</tr>' if $enhancement_logged;
  	print $FILE_HANDLE '</table><br/><br/><br/>';

}


sub create_bug_report {
	my $file            = $_[0];
	my $rh_bugs         = $_[1];
	my $sr_reported     = $_[2];
	my $bugs_reported   = $_[3];
	my $enhancement_cnt = $_[4];

	open(my $BUG_REPORT, ">$file") or die "could not open $file\n";
	print_header_start($BUG_REPORT, "Bugs Reported for SR's");
	print_bug_count_table($BUG_REPORT, $sr_reported, $bugs_reported,$enhancement_cnt);
	print_table_header($BUG_REPORT);
	my $bgcolor = '#FFFFCC';
	foreach my $prob_type (keys %$rh_bugs) {
	  $bgcolor = $bgcolor eq '#FFFFFF' ? '#FFFFCC':'#FFFFFF';
	  my $td_attr = 'align="center" class="twikiFirstCol" bgcolor="'.$bgcolor.'"';
	  print $BUG_REPORT '<tr>';
	  print $BUG_REPORT '<td rowspan = "'. scalar(keys(%{$rh_bugs->{$prob_type}}))  .' "'.$td_attr.'>';
	  print $BUG_REPORT $prob_type ." [ ".scalar(keys(%{$rh_bugs->{$prob_type}})) ." ] ";
	  print $BUG_REPORT '</td>';
	  my $first = 0;
	  foreach my $sr (keys %{$rh_bugs->{$prob_type}} ) {
	    my $style = '';
        $style = "style='color:darkorange;' " if $rh_bugs->{$prob_type}->{$sr}->{resolution_code} eq $enhancement_logged;
	    unless ($first ) {
	           $first = 1;
	    } else {
		    print $BUG_REPORT "<tr>";
	    }
	    print $BUG_REPORT "<td ".$td_attr."> <a href='http://ade.oraclecorp.com/cgi-bin/querySR.pl?srnumber=$sr'>".$sr."</a></td>\n";
	    print $BUG_REPORT "<td $td_attr ".$style.">".$rh_bugs->{$prob_type}->{$sr}->{summary}."</td>\n";
	    print $BUG_REPORT "<td  $td_attr ".$style.">".$rh_bugs->{$prob_type}->{$sr}->{resolution}."</td></tr>\n";
	  }
	}
	print_header_end($BUG_REPORT);
}


