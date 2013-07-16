#!/usr/bin/perl -w
use strict;
use Cwd;
use POSIX qw[ceil];
use List::Util qw(min);
use Data::Dumper;
use Net::SMTP;
use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft Excel';

unless ($ARGV[0] and $ARGV[1]){  die "Usage: $0 xls_file_name_full_path 090208 090216\n" ;   }

########################## CONSTANT VALUES ####################################################
             ############## List of reviewers ######################

my $CM_HELP_EMAIL     = 'cmhelp_sr_review@oracle.com';
my $rgbu_mail =         'latasha.johnson@oracle.com' ;
my $cc_id     = 'harish.krishnamurthy@oracle.com';
########################## VARIABLES DECLARATION ####################################################
my $pd = &getcwd();
my $file_name = $ARGV[0];
print $file_name;
my $ra_sr_details = &read_data($file_name);

           ############## Recalculate the Number of Review SR per category #############
print "Sending e-mails... ";
&send_email({sr_details => $ra_sr_details,
            to         => $rgbu_mail,
            from       => $CM_HELP_EMAIL,
            cc         => $cc_id
            });
print "All mails Sent \n";


sub read_data {
  my $xls_file = $_[0];

  # get already active Excel application or open new
  my $Excel = Win32::OLE->GetActiveObject('Excel.Application') || Win32::OLE->new('Excel.Application', 'Quit');

  # open Excel file

  my $Book = $Excel->Workbooks->Open($xls_file);

  # select worksheet number 1 (you can also select a worksheet by name)

  my $Sheet         = $Book->Worksheets(1);
  my @list            = ();
  my $i                     = 4;
  my $DEFAULT_PRIORITY      = 3;
  my $sr_col                = 1;
  my $priority_col          = 2;
  my $summary_col           = 3;
  my $prob_type_col         = 9;
  my $resolution_code_col   = 11;
  my $resolution_col        = 12;
  my $assigned_col          = 4;
  my ($sr, $prob_type, $resolution, $priority, $summary, $resolution_code, $assigned,  $old_prob_type);

  my $rh_sr = {};
  while (($rh_sr->{sr} = $Sheet->Cells($i,$sr_col)->{'Value'} ) ) {
    $prob_type     = $Sheet->Cells($i, $prob_type_col)->{'Value'} || $old_prob_type;
    $old_prob_type = $prob_type if $prob_type;
    if ($prob_type =~ /RGBU/) {
      $rh_sr->{prob_type}       = $prob_type;
      $rh_sr->{resolution}      = $Sheet->Cells($i, $resolution_col)->{'Value'};
      $rh_sr->{priority}        = $Sheet->Cells($i, $priority_col)->{'Value'} || $DEFAULT_PRIORITY;
      $rh_sr->{summary}         = $Sheet->Cells($i, $summary_col)->{'Value'};
      $rh_sr->{resolution_code} = $Sheet->Cells($i, $resolution_code_col)->{'Value'};
      $rh_sr->{assigned}        = $Sheet->Cells($i, $assigned_col)->{'Value'};
      $rh_sr->{assigned}        =~ s/^\s+//; $rh_sr->{assigned} =~ s/\s+$//;
      push (@list, $rh_sr);
      $rh_sr = {};
    }
    $i++;
  }
  $Book->Close;
  $Excel->Quit;
  return \@list;
}

sub get_body {
    my $ra_sr_details = $_[0];
    my $name          = $_[1];
    my $date1         = $_[2];
    my $date2         = $_[3];
    my $body;
    if ($ra_sr_details and (scalar @$ra_sr_details)) {
      my $sr_tab;
      $sr_tab = '<table border="1" cellpadding="0" cellspacing="1">';
      $sr_tab .= '<tr>';
      $sr_tab .= '<th  class="twikiFirstCol" bgcolor="#99cccc"> Sl No</th>';
      $sr_tab .= '<th  class="twikiFirstCol" bgcolor="#99cccc"> SR #</th>';
      $sr_tab .= '<th class="twikiFirstCol" bgcolor="#99cccc">Severity</th>';
      $sr_tab .= '<th class="twikiFirstCol" bgcolor="#99cccc">Summary</th>';
      my $bgcolor = '#FFFFFF';
      my $i = 1;
      foreach my $rh_sr (@$ra_sr_details) {
        $bgcolor = $bgcolor eq '#FFFFFF' ? '#FFFFCC':'#FFFFFF';
    	  my $td_attr = 'align="center" class="twikiFirstCol" bgcolor="'.$bgcolor.'"';
        $sr_tab .= '<tr>'   ;
        $sr_tab .= "<td $td_attr>". $i++.'</td>';
        $sr_tab .= "<td $td_attr><a href=\'http://ade.oraclecorp.com/cgi-bin/querySR.pl?srnumber=".$rh_sr->{sr}. '\'>' . $rh_sr->{sr} . '</a></td>';
        $sr_tab .= "<td $td_attr>". $rh_sr->{priority}.'</td>';
        $sr_tab .= "<td $td_attr>". $rh_sr->{summary}.'</td>';
        $sr_tab .= "</tr>";
        $sr_tab .= "\n";
      }
      $sr_tab .= '</table>';
    $body = <<EOF;
    Hello,
    <pre>
Following Service Requests has been logged by RGBU team against ADE between $date1 and $date2.

$sr_tab

- ADE Team
EOF

    } else {
      $body = <<EOF;
      Hello,
      <pre>
NO Service Requests has been logged by RGBU team against ADE between $date1 and $date2.

- ADE Team
EOF
    }
my $subject = 'ADE SRs logged by RGBU between '.$date1.' and '. $date2. ' - Please ignore the previous mail';
return ($subject, $body);
}

#
# Constructs the body... given the SR
#
sub send_email {
    my $options           = shift;
    my $to                = $options->{to};
    my $sr_details        = $options->{sr_details};
    my $from              = $options->{from};
    my $cc                = $options->{cc};

    my ($subject, $body)  = &get_body($sr_details, uc ( (split(/\./,$to))[0] ) ,$ARGV[1] , $ARGV[2]);


    &_send_mail( { to       => $to,
                   subject  => $subject,
                   body     => $body,
                   cc       => $cc,
                   from     => $from} );
}

sub _send_mail {
    my $options  = $_[0];
    my $to       = $options->{to};
    my $Cc       = $options->{cc};
    my $subject  = $options->{subject};
    my $body     = $options->{body};
    my $reply_to = $options->{reply_to};
    my $from     = $options->{from};


    ########################## FOR TESTING #####################
#    $Cc = 'sundeep.gupta@oracle.com, sundeep.techie@gamil.com';
#   $to = 'harish.krishnamurthy@oracle.com';

    ############################################################
   # my $smtp = Net::SMTP->new('rgmamersmtp.oraclecorp.com');
    my $smtp = Net::SMTP->new('internal-mail-router.oracle.com',Debug=>1);
    $smtp->mail('harish.krishnamurthy@oracle.com');
    $smtp->to($to);
    $smtp->cc($Cc);

    $smtp->data();
    $smtp->datasend("From: $from\n");
    $smtp->datasend("To: $to\n");
    $smtp->datasend("Reply-To: $reply_to\n") if $reply_to;
    $smtp->datasend("Cc : $Cc \n")           if $Cc;
    $smtp->datasend("MIME-Version: 1.0\n");
    $smtp->datasend("Content-Type: text/html; charset=us-ascii\n");
    $smtp->datasend("Subject: " . $subject . "\n");
    $smtp->datasend("\n");
    $smtp->datasend($body);
    $smtp->dataend();

    $smtp->quit;

}