#!/usr/bin/perl -w
use strict;
use POSIX qw[ceil];
use List::Util qw(min);
use Data::Dumper;
use Net::SMTP;
use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft Excel';
#use locale

unless ($ARGV[0]){  print STDERR "Usage: $0 xls_file_name_full_path\n" ;  exit(); }

########################## CONSTANT VALUES ####################################################
my $ratio    = {'p1' => 3, 'p2' => 5, 'p3' => 7};
$ratio->{total} = $ratio->{p1}+$ratio->{p2}+$ratio->{p3};

               ####### Calculate numbers from Ratios ###################
my $MAX_SR    = 15;
my $P1_MAX_SR = ceil( $MAX_SR * $ratio->{p1}/$ratio->{total} );
my $P2_MAX_SR = ceil( $MAX_SR * $ratio->{p2}/$ratio->{total} );

             ############## List of reviewers ######################
my @reviewers = ( {'name' => 'Gupta, Sundeep Kumar',                        'email' => 'sundeep.gupta@oracle.com'             },
                  {'name' => 'Krishnamurthy, Harish Chandar',               'email' => 'Harish.Krishnamurthy@oracle.com'      },
                  {'name' => 'Grigoryev, Vladimir Albert (Vladimir)',       'email' => 'vladimir.grigoryev@oracle.com',       },
                  {'name' => 'Goddard, Denis Michael (Denis)',              'email' => 'denis.goddard@oracle.com',            },
                  {'name' => 'KAZAK, Mr. ROHINTON (ROHINTON)',              'email' => 'rohinton.kazak@oracle.com',           },
                  {'name' => 'Arunachalam, Venkatesan',                     'email' => 'venkatesan.arunachalam@oracle.com',   },
                  {'name' => 'Gandhi, Sanjai',                              'email' => 'sanjai.gandhi@oracle.com',            },
                  {'name' => 'Purushothaman, Manikandan Maluvadu',          'email' => 'manikandan.purushothaman@oracle.com', },
                  {'name' => 'Nguyen, Thong H.',                            'email' => 'thong.nguyen@oracle.com',             },
                  {'name' => 'Totten, Grant',                               'email' => 'grant.totten@oracle.com',             },
                  {'name' => 'Kothari, Prasanna Praful',                    'email' => 'prasanna.kothari@oracle.com',         },
                  {'name' => 'Mahaney, Gordon Ralston (Sam)',               'email' =>'gordan.mahaney@oracle.com',            },
                  {'name' => 'Muraleedharan, Vinod',                        'email' => 'vinod.muraleedharan@oracle.com',      },
                  {'name' => 'Tu, Ying-Chieh (Kevin)',                      'email' =>'kevin.tu@oracle.com',                  },
                  {'name' => 'Venkatasamy, Purushothaman (Purush)',         'email' => 'purushothaman.venkatasamy@oracle.com',},
                  {'name' => 'Gururaja, Vijay',                             'email' => 'vijay.gururaja@oracle.com',           },
                  {'name' => 'Devito, Jonathan Edward (Jon)',               'email' =>'jonathan.devito@oracle.com',           },
                  {'name' => 'Vuddaraju, Ravikumar Raju',                   'email' => 'ravikumar.vuddaraju@oracle.com',      },
                  {'name' => 'Pandey, Rahul (Rahul)',                       'email' => 'rahul.pandey@oracle.com',             },
                  {'name' => 'Bansal, Nakul',  				                'email' => 'nakul.bansal@oracle.com',		      },
                  {'name' => 'Doskow, Jonathan (Jon)',  				    'email' => 'jonathan.doskow@oracle.com',	      },
                  {'name' => 'Kedlaya, Natesha (Natesh)',  				    'email' => 'natesha.kedlaya@oracle.com',	      },
                  {'name' => 'Puttanarasaiah, Niranjan Madenahalli',  		'email' => 'niranjan.puttanarasaiah@oracle.com',	      },
              ) ;
              

              
########################## VARIABLES DECLARATION ####################################################

my %assigned_reviewers = ();

my $rh_data = &read_data($ARGV[0]);
my $total_sr =scalar @{$rh_data->{1}}+scalar @{$rh_data->{2}}+scalar @{$rh_data->{3}};
return unless $rh_data;

           ############## Recalculate the Number of Review SR per category #############
my $new_P1_MAX_SR = min( scalar @{$rh_data->{1}}, $P1_MAX_SR);
my $new_P2_MAX_SR = min( scalar @{$rh_data->{2}}, $P2_MAX_SR + ($P1_MAX_SR - $new_P1_MAX_SR) );
my $new_P3_MAX_SR = min ( $total_sr, $MAX_SR) - ($new_P1_MAX_SR + $new_P2_MAX_SR);
print "Sending e-mails...\n";

&send_mail_for_review($rh_data->{1}, $new_P1_MAX_SR);
&send_mail_for_review($rh_data->{2}, $new_P2_MAX_SR);
&send_mail_for_review($rh_data->{3}, $new_P3_MAX_SR);
print "All mails Sent \n";

sub send_mail_for_review {
    my $rh_data = shift;
    my $sr_cnt  = shift;
    my $total_cnt = scalar @$rh_data;

  # Send mail for MAX_SR
  for(my $i = 0; $i < $sr_cnt ; $i++) {
    my $next;
     # Pick up next SR
     do { $next = rand($total_cnt); } while (! $$rh_data[$next]);

     #Make sure assignee & reviewer does not match
     my $next_reviewer = undef;
     do { $next_reviewer = rand(scalar @reviewers); } while ($reviewers[$next_reviewer]->{name} eq $$rh_data[$next]->{assigned}  or
                                                             exists $assigned_reviewers{$reviewers[$next_reviewer]->{name}} );

     $assigned_reviewers{$reviewers[$next_reviewer]->{name}} = 1;
     my $next_sr = $$rh_data[$next];
     $next_sr->{reviewer} = $reviewers[$next_reviewer]->{email};
     #
     # Get the email id of the assignee
     foreach my $email (@reviewers) {
        if($email->{name} eq $next_sr->{assigned}) {
                $next_sr->{assigned} = $email->{email} ; 
                last;
        }
     }

     # mail here
     send_email($next_sr);

     # 1. Remove the selected SR
     $$rh_data[$next] = undef;
  }

}



sub read_data {
  my $xls_file = $_[0];

  # get already active Excel application or open new
  my $Excel = Win32::OLE->GetActiveObject('Excel.Application')
      || Win32::OLE->new('Excel.Application', 'Quit');

  # open Excel file

  my $Book = $Excel->Workbooks->Open($xls_file);

  # select worksheet number 1 (you can also select a worksheet by name)

  my $Sheet = $Book->Worksheets(1);
  my $rh_priority = {};
  $rh_priority->{'1'} = &get_priority_wise($Sheet, [1]);
  $rh_priority->{'2'} = &get_priority_wise($Sheet, [2]);
  $rh_priority->{'3'} = &get_priority_wise($Sheet, [3]);

  $Book->Close;
  $Excel->Quit;
  return $rh_priority;
}

sub get_priority_wise {
    my $Sheet                 = $_[0];
    my @priorities_to_return  = @{$_[1]};
    my $rh_priority           = {};
    my $i                     = 4;
    my $DEFAULT_PRIORITY      = 3;
    my $sr_col                = 1;
    my $priority_col          = 2;
    my $summary_col           = 3;
    my $prob_type_col         = 9;
    my $resolution_code_col   = 11;
    my $resolution_col        = 12;
    my $assigned_col          = 4;
    my ($sr, $prob_type, $resolution, $priority, $summary, $resolution_code, $assigned, %reviewers);

    foreach my $reviewer ( @reviewers) { $reviewers{$reviewer->{name}} = 1; }

    while (($sr = $Sheet->Cells($i,$sr_col)->{'Value'} ) ) {
      $prob_type       = $Sheet->Cells($i, $prob_type_col)->{'Value'} || $prob_type;
      $resolution      = $Sheet->Cells($i, $resolution_col)->{'Value'};
      $priority        = $Sheet->Cells($i, $priority_col)->{'Value'} || $DEFAULT_PRIORITY;
      $summary         = $Sheet->Cells($i, $summary_col)->{'Value'};
  	  $resolution_code = $Sheet->Cells($i, $resolution_code_col)->{'Value'};
      $assigned        = $Sheet->Cells($i, $assigned_col)->{'Value'};
      $assigned        =~ s/^\s+//; $assigned =~ s/\s+$//;

      unless ($assigned and exists $reviewers{$assigned} ) {
        $i++; next;
      }

      $rh_priority->{$priority}->{$sr}->{summary}         = $summary         || "";
      $rh_priority->{$priority}->{$sr}->{resolution}      = $resolution      || "";
      $rh_priority->{$priority}->{$sr}->{resolution_code} = $resolution_code || "";
      $rh_priority->{$priority}->{$sr}->{prob_type}       = $prob_type ;
      $rh_priority->{$priority}->{$sr}->{assigned}        = $assigned;
      $i++;
    }

    my @list = ();
    if(@priorities_to_return) {
       foreach my $next_prio (@priorities_to_return) {
         foreach my $next_sr (keys %{$rh_priority->{$next_prio}} ) {
                  $rh_priority->{$next_prio}->{$next_sr}->{sr} = $next_sr;
                  $rh_priority->{$next_prio}->{$next_sr}->{priority} = $next_prio;
                 push (@list, $rh_priority->{$next_prio}->{$next_sr} );
         }
       }
       return \@list;
    } else {
        foreach my $next_prio (keys %$rh_priority) {
         foreach my $next_sr (keys %{$rh_priority->{$next_prio}} ) {
                  $rh_priority->{$next_prio}->{$next_sr}->{sr} = $next_sr;
                  $rh_priority->{$next_prio}->{$next_sr}->{priority} = $next_prio;
                  push (@list, $rh_priority->{$next_prio}->{$next_sr} );
         }
       }
    }
    return \@list;
}


sub send_email {
    my $sr_details        = $_[0];
    my @sr_manager_emails = ('rahul.pandey@oracle.com', 'denis.goddard@oracle.com','prasanna.kothari@oracle.com', 'harish.krishnamurthy@oracle.com');
    my $sr                = $sr_details->{sr};
    my $request_type      = $sr_details->{prob_type};
    my $summary           = $sr_details->{summary};
    my $priority          = $sr_details->{priority};

    my $to                = $sr_details->{reviewer};
    my $from              = 'cmhelp_sr_review@oracle.com';
    my $owner             = $sr_details->{assigned};
    my $replyto			  = 
    my $subject           = "Peer review request for SR $sr";
    my $name = (split(/\./,$to))[0];
    $name = uc($name);
print "Sending email to $name\n";
print "Assignee $owner\n\n\n";
  # @sr_manager_emails    = ('harish.krishnamurthy@gmail.com','harish.krishnamurthy@oracle.com');
  # $to                   = 'harish.krishnamurthy@oracle.com';
  # $owner                = 'harish.krishnamurthy@oracle.com';

    my $body = <<EOF;
    <pre>
Hello $name,
    
Service Request <a href='http://ade.oraclecorp.com/cgi-bin/querySR.pl?srnumber=$sr'>$sr</a> has been assigned to you for peer review.
Please send in your review comments by the end of this week.

<u>SR Info</u>
Summary      : [$summary]
Severity     : [$priority]
Resolved By  : [$owner]
Request Type : [$request_type]




Please follow SR review guidelines <a href="http://ade.oraclecorp.com/twiki/bin/view/SUPPORTTEAM/SrQualityCheckList">here</a>


EOF

  #  my $smtp = Net::SMTP->new('rgmamersmtp.oraclecorp.com');
     my $smtp = Net::SMTP->new('internal-mail-router.oracle.com', Debug => 1);
    die "Unable to create SMTP object $!" unless $smtp;
    $smtp->mail('harish.krishnamurthy@oracle.com');
    $smtp->to($to);
    my $Cc = "$owner, ";
    $smtp->cc($owner);
    foreach my $cc (@sr_manager_emails) {
       $Cc .= "$cc, ";
       $smtp->cc($cc);
    }

    $smtp->data();
    $smtp->datasend("From: $from\n");
    $smtp->datasend("To: $to\n");
    $smtp->datasend("Reply-To: $Cc\n");
    $smtp->datasend("Cc : $Cc \n");
    $smtp->datasend("MIME-Version: 1.0\n");
    $smtp->datasend("Content-Type: text/html; charset=us-ascii\n");
    $smtp->datasend("Subject: " . $subject . "\n");
    $smtp->datasend("\n");
    $smtp->datasend($body);
    $smtp->dataend();

    $smtp->quit;
}