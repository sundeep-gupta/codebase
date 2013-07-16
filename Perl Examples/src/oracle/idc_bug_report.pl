#!/usr/local/bin/perl5.6

use strict;
use SelfLoader;
use FileHandle;
use lib '/usr/local/nde/ade/bin/perl/cpan_modules';
use lib '/usr/local/nde/ade/bin/perl/cpan_modules/linux';
use DBI;
use DBD::Oracle;
use constant RPTNO => 0;
use constant PRIORITY => 1;
use constant RELEASE => 2;
use constant STATUS => 3;
use constant PROGRESS => 4;
use constant SUBJECT => 5;
use constant HOT_FIX => 7;

my $tns_string     = 'PRODUCTION_BUGDB.US.ORACLE.COM';
my $connect_string = 'ADEBUG/WELCOME@'.$tns_string;
my $hot = '3.2.4.';
my @programmers = ('NABANSAL','NPUTTANA','SAGANDHI','SKGUPTA', 'VMURALEE','HKRISHNA');
#PRODUCTION_BUGDB.US.ORACLE.COM';
my $queries = {
      "ADE_CATEGORY" =>
                     qq( SELECT rptno,cs_priority,DO_BY_RELEASE,
                     status, test_name, subject 
                    FROM  rpthead
                    WHERE product_id = 81
                    AND CATEGORY = 'ADE'
                    AND programmer = :programmer
                    AND STATUS < 74 
                    AND STATUS NOT IN (22,31, 32, 35, 36)
                    ORDER BY DO_BY_RELEASE, CS_PRIORITY, test_name),
      };

my $dbh = DBI->connect("dbi:Oracle:", $connect_string, "" ) or die ("Unable to connect to Bug DB\n");
&generate_active_bug_report($dbh, \@programmers);

sub generate_closed_bug_report() {
    my $filename = '/var/www/html/closed_bugs.html';
    my $fh = new FileHandle($filename, 'w') or die $filename;
    &print_head($fh);
    my $sth = $dbh->prepare($queries->{'CLOSED_BUGS'});
    foreach my $programmer (@programmers) {
        $sth->bind_param(':programmer',$programmer);
        $sth->execute();
        my $rs = $sth->fetchall_arrayref();
        &print_table($fh, $rs, "Closed By - $programmer");
    }
    &print_end($fh);
    $fh->close();
}

sub generate_active_bug_report {
    my $dbh = $_[0];
    my $ra_programmers = $_[1];
    my $Filename        = "/var/www/html/idc_bug_report.html";
    my $Filehand_Result = new FileHandle ($Filename, "w") or "die $Filename\n";

    &print_head($Filehand_Result);
    &print_anchors($Filehand_Result, $ra_programmers);
    my $sth = $dbh->prepare($queries->{'ADE_CATEGORY'});
    foreach my $programmer (@programmers) {
        $sth->bind_param(':programmer', $programmer);
        $sth->execute();
        my $rs_active = $sth->fetchall_arrayref();
        $rs_active = &filter_resultset($rs_active);
        &print_table($Filehand_Result, $rs_active,  $programmer);
    }

    &print_end($Filehand_Result);

    $Filehand_Result->close();
}
sub filter_resultset {
    my ($rs_resultset) = $_[0];
    my $rs_hot = [];
    my $rs_active = [];
    foreach my $row (@$rs_resultset) {      
        my $progress = $row->[PROGRESS];
        if($row->[PROGRESS] eq 'N') {
            $progress = 'On Hold';
        } elsif ($row->[PROGRESS] eq 'Y' ) {
            $progress = 'Working';
        } elsif ($row->[PROGRESS] eq 'C') {
            $progress = 'Fixed';
        } else {
            $progress = 'In Queue';
        }
        $row->[PROGRESS] = $progress;
        if($row->[RELEASE] =~ /^3\.2\.4\./) {
            $row->[HOT_FIX] = 1;
            push @$rs_hot, $row;
        } else {
            $row->[HOT_FIX] = 0;
            push @$rs_active, $row;
        }
    }
#    use Data::Dumper; print Dumper($rs_hot);
    push @$rs_hot, @$rs_active;
    return $rs_hot;
}
sub print_end {
    my $Filehand_Result = $_[0];
    $Filehand_Result->print("</body></html>");
}

sub print_table {
    my $Filehand_Result = $_[0];
    my $rs = $_[1];
    my $programmer = $_[2];
    my $title = 'Bugs - '. $programmer;
    $Filehand_Result->print ("\t\t<h3 id=\"$programmer\" align=\"center\">$title </h3> <br>");
    print_table_headers($Filehand_Result);
    my $inprogress = print_table_rows($Filehand_Result, $rs);
    $Filehand_Result->print ("\n\t</tbody></table>");
}

sub print_head {  
    my $Filehand_Result = $_[0];
    $Filehand_Result->print("<html>");
    $Filehand_Result->print("\n\t<title> IDC Team Bug Report</title>");

    $Filehand_Result->print("<body>");
}

sub print_table_rows {
    my ($Filehand_Result, $query_result) = @_;
    my $cntr = 0;
    my ($genx2h_file,$source_file,$target_file);
    my ($xml_file,$subject,$clr);
    foreach my $row (@$query_result) {
        $subject = $row->[SUBJECT];
        $subject =~s/&/&amp;/;
        $subject =~s/>/&lt;/;
        $subject =~s/</&gt;/;
        
        $cntr = $cntr + 1;
        my $progress = $row->[PROGRESS];
        $clr = ($cntr % 2 ? "#ffffff" : "#EDF4F9");
        $Filehand_Result->print ("\n\t<tr bgcolor=\"$clr\" align=\"center\">");
        $Filehand_Result->print ("\n\t\t<td>$cntr</td>");
        $Filehand_Result->print ("\n\t\t<td><a href=\"http:/\/bug.oraclecorp.com\/pls\/bug\/webbug_print.show?c_rptno=$row->[0]\">$row->[0]</a></td>");  # Prints Bug No
        $Filehand_Result->print ("\n\t\t<td>$row->[PRIORITY]</td>"); 
        if($row->[HOT_FIX] ) {

            $Filehand_Result->print ("\n\t\t<td style=\"color:#FF0000\">$row->[RELEASE]</td>");
        } else {
            $Filehand_Result->print ("\n\t\t<td>$row->[RELEASE]</td>");
        }
        $Filehand_Result->print ("\n\t\t<td>$row->[STATUS]</td>");
        $Filehand_Result->print ("\n\t\t<td width = 40%>$subject</td>");
        $Filehand_Result->print ("\n\t\t<td>$progress</td>");          
        $Filehand_Result->print ("\n\t</tr>");
        }
    $Filehand_Result->print ("\n\t</table>");
    $Filehand_Result->print ("\n\t</section>");
    return $cntr;
}


sub print_table_headers {                                                                                                                #Sub-routine printing table headers.
    my $Filehand_Result = $_[0];
    $Filehand_Result->print ("\n\t<table  align='center' cellpadding=\"0\" cellspacing=\"1\" width = 70%>");
    $Filehand_Result->print ("\n\t<tr bgcolor=\"#687684\">");
    $Filehand_Result->print ("\n\t\t<th>S.No.</th>");
    $Filehand_Result->print ("\n\t\t<th>Bug Num</th>");
    $Filehand_Result->print ("\n\t\t<th>Priority</th>");
    $Filehand_Result->print ("\n\t\t<th>Fix By</th>");
    $Filehand_Result->print ("\n\t\t<th>Status</th>");
    $Filehand_Result->print ("\n\t\t<th width = 30%>Subject</th>");
    $Filehand_Result->print ("\n\t\t<th>Progress</th>");
    $Filehand_Result->print ("\n\t</tr>");
}

sub print_anchors {
    my $fh = $_[0];
    my $ra_programmers = $_[1];
    foreach my $programmer (@$ra_programmers) {
        $fh->print("<a href='#$programmer'>$programmer</a><br/>\n");
    }
}
