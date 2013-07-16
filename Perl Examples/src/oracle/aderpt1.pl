#!/usr/bin/perl -w

use strict;
use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft Excel';
unless ($ARGV[0]){
print STDERR "Usage: $0 xls_file_name_full_path report_name\n" ;
exit();
}
# get already active Excel application or open new
my $Excel = Win32::OLE->GetActiveObject('Excel.Application')
    || Win32::OLE->new('Excel.Application', 'Quit');

# open Excel file
my $Book = $Excel->Workbooks->Open($ARGV[0]);

# You can dynamically obtain the number of worksheets, rows, and columns
# through the Excel OLE interface.  Excel's Visual Basic Editor has more
# information on the Excel OLE interface.  Here we just use the first
# worksheet, rows 1 through 4 and columns 1 through 3.

# select worksheet number 1 (you can also select a worksheet by name)
my $Sheet = $Book->Worksheets(1);



my $sr_col         = 1;
my $priority_col   = 2;
my $summary_col    = 3;
my $prob_type_col  = 9;
my $resolution_code_col = 11;
my $resolution_col = 12;
my $assigned_col = 4;

my $i              = 4;
my $sr_reported = 0;
my $bug_reported = 'BUG_REPORTED';
my $enhancement_logged = 'ENHANCEMENT_LOGGED';
my $default_assigned = 'Closed by Customer';
my $bugs_reported_cnt = 0;
my $rh_summary     = {};
my $rh_bug = ();
my $rh_assigned = ();
my $enhancement_cnt = 0;

my ($old_prob_type, $sr);
my @color = ('red','blue','green');

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
		$rh_assigned->{$assigned} = $rh_assigned->{$assigned} ? $rh_assigned->{$assigned}+1 :1;
    }

    if ($prob_type ) {
        $old_prob_type = $prob_type;
        $rh_summary->{$prob_type}->{$sr}->{summary}    = $summary || "";
        $rh_summary->{$prob_type}->{$sr}->{resolution} = $resolution || "";
        $rh_summary->{$prob_type}->{$sr}->{resolution_code} = $resolution_code || "";
        $rh_summary->{$prob_type}->{$sr}->{priority}   = $priority || 3;
        
    } elsif($old_prob_type) {
         $rh_summary->{$old_prob_type}->{$sr}->{summary}    = $summary || "";
         $rh_summary->{$old_prob_type}->{$sr}->{resolution} = $resolution || "";
         $rh_summary->{$old_prob_type}->{$sr}->{resolution_code} = $resolution_code || "";
         $rh_summary->{$old_prob_type}->{$sr}->{priority}   = $priority || 3;
    }
    if ($resolution_code && ($resolution_code eq $bug_reported || $resolution_code eq $enhancement_logged) ) {
	    if ($resolution && $resolution =~ /(\d{7})/) {
		   $resolution = "<a href='https://bug.oraclecorp.com/pls/bug/webbug_print.show?c_rptno=$1'>$1<\/a>";    
	    } else {
		    $resolution = "";
	    }

    	if ($prob_type ) {
	        $old_prob_type = $prob_type;
	        $rh_bug->{$prob_type}->{$sr}->{summary}    = $summary || "";
	        $rh_bug->{$prob_type}->{$sr}->{resolution} = $resolution || "";
	        $rh_bug->{$prob_type}->{$sr}->{resolution_code} = $resolution_code || "";
	        $rh_bug->{$prob_type}->{$sr}->{priority}   = $priority || 3;
	    } elsif($old_prob_type) {
	         $rh_bug->{$old_prob_type}->{$sr}->{summary}    = $summary || "";
	         $rh_bug->{$old_prob_type}->{$sr}->{resolution} = $resolution || "";
	         $rh_bug->{$old_prob_type}->{$sr}->{resolution_code} = $resolution_code || "";
	         $rh_bug->{$old_prob_type}->{$sr}->{priority}   = $priority || 3;
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
print $enhancement_cnt,"\n",$bugs_reported_cnt;

#print Dumper($rh_summary);
# clean up after ourselves
$Book->Close;
$Excel->Quit;
use Data::Dumper; print Dumper($rh_assigned);
my $pc_filename = $ARGV[1]."_pc.html";
my $br_filename = $ARGV[1]."_br.html";
my $as_filename = $ARGV[1]."_as.html";

create_problem_code($pc_filename, $rh_summary, $sr_reported);
create_bug_report($br_filename, $rh_bug, $sr_reported, $bugs_reported_cnt, $enhancement_cnt);
create_assigned_report($as_filename, $rh_assigned);

sub create_assigned_report {
	my $file = $_[0];
	my $rh_as = $_[1];
	
	open(my $AS_REPORT, ">$file") or die "could not open $file\n";
	print_header_start( $AS_REPORT , "SR's Closed - By Engineer");	
	print_assigned_table($AS_REPORT, $rh_as);
	
	print_header_end( $AS_REPORT);
}

sub create_bug_report {
	my $file = $_[0];
	my $rh_bugs = $_[1];
	my $sr_reported = $_[2];
	my $bugs_reported = $_[3];
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
	#  print BUG_REPORT"<td><table>";
	  my $first = 0;
	  foreach $sr (keys %{$rh_bugs->{$prob_type}} ) {
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
	    #print $BUG_REPORT"</td></table>";
	    #print $BUG_REPORT "</tr>\n";
	}
	print_header_end($BUG_REPORT);
}



sub create_problem_code {
	my $file = $_[0];
	my $rh_summary = $_[1];
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
	#  print $PC_HANDLE "<td><table>";
	  my $first = 0;
	  foreach $sr (keys %{$rh_summary->{$prob_type}} ) {
	    unless ($first ) {
	           $first = 1;
	    } else {
	        print $PC_HANDLE "<tr style='color:".$color[$rh_summary->{$prob_type}->{$sr}->{priority} - 1].";'>";
	    }
	    print $PC_HANDLE "<td $td_attr > <a href='http://ade.oraclecorp.com/cgi-bin/querySR.pl?srnumber=$sr'>".$sr."</a></td>\n";
	    print $PC_HANDLE "<td $td_attr >".$rh_summary->{$prob_type}->{$sr}->{summary}."</td>\n";
	    print $PC_HANDLE "<td $td_attr>".$rh_summary->{$prob_type}->{$sr}->{resolution}."</td></tr>\n";
	  }
	    #print $PC_HANDLE "</td></table>";
	    #print $PC_HANDLE  "</tr>\n";
	}
	print_header_end($PC_HANDLE);
}


sub print_header_start {
	my $FILE_HANDLE = $_[0];
	my $header = $_[1];
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

sub print_assigned_table {
	my $FILE_HANDLE = $_[0];	
	my $rh_as = $_[1];
	
	print  $FILE_HANDLE '<table border="1" cellpadding="0" cellspacing="1" width = 50%>'    ;
	  	print  $FILE_HANDLE '<tr>
  		<th class="twikiFirstCol" bgcolor="#99cccc">Engineer </th>
  		<th class="twikiFirstCol" bgcolor="#99cccc">SR\'s Resolved </th>
  	</tr>';

	my $bgcolor = '#FFFFCC';
		
	foreach my $assigned (keys %$rh_as) {
		$bgcolor = $bgcolor eq '#FFFFFF' ? '#FFFFCC':'#FFFFFF';
  	  my $td_attr = 'align="center" class="twikiFirstCol" bgcolor="'.$bgcolor.'"';
		print  $FILE_HANDLE '<tr>
	  		<td '.$td_attr.' >'.$assigned.'</td>
	  		<td '.$td_attr.' >'.$rh_as->{$assigned}.'</td>
	  	</tr>';
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