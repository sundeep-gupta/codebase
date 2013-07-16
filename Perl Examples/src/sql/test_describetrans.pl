#!/usr/local/bin/perl5.6 -w
#
# Copyright (c) 2001, 2009, Oracle and/or its affiliates.All rights reserved. 
#
# NAME
# list_objects_in_a_transactions.pl
#
# DESCRIPTION
#  Shows list of objects in a transaction
#
# MODIFIED (MM/DD/YY)
# nputtana  01/02/09 - bug 7647733 : Rewrite list_objects_in_a_transaction.pl
# mpurusho  02/27/06 - SR 7193887 Adding new api. Bug-3904344: New API for 
#                      get_transaction_details 
# jdevito   03/10/03 - added cross-platform lib paths
# puvenkat  01/30/03 - puvenkat_adhoc_queries
# puvenkat  12/26/02 - Creation
###############################################################################

#------------------------------------------------------------------------------
#                           INITIALIZATION 
#------------------------------------------------------------------------------

use English;
use strict; 

BEGIN {
        $main::ade_home = ($OSNAME eq "MSWin32") ? $ENV{ADE_HOME_DIR} : "/usr/local/ade";
        $main::perlDir = "$main::ade_home/bin/perl";
}

use lib "$main::perlDir";
use lib "$main::perlDir/cpan_modules";
use lib "$main::perlDir/cpan_modules/$OSNAME";
use lib "$main::perlDir/XS_modules";
use lib "$main::perlDir/XS_modules/$OSNAME";

#------------------------------------------------------------------------------

BEGIN {
    require "error.pm";
}

use DBI;
use DBD::Oracle;

#------------------------------------------------------------------------------
# MAIN ROUTINE 
#------------------------------------------------------------------------------

#my ($trans_name, $outfile) = &parse_args(\@ARGV);
my $trans_name = 'mthaha_democheck_txn9';

my $connect_string = 'ADE_SQLPLUS_USER/ADE_SQLPLUS_USER@' . $ENV{TWO_TASK};
my $dbh = DBI->connect("dbi:Oracle:", $connect_string, "" )
                     || die "Unable to connect to Repos: $DBI::errstr\n";
$dbh->{RaiseError} = 1; $dbh->{AutoCommit} = 0;

my %objects = &run_query($dbh, $trans_name);

$dbh->disconnect();

local *OUTFILE;

my $header_line1 = "#List of objects in Txn: " . $trans_name . "\n";

if ($outfile) {
    open (OUTFILE, ">$outfile") or die "Cannot open file '$outfile' : $OS_ERROR \n";
    print "Output written into the file : '$outfile' \n";
    select OUTFILE;
}

print  "#". "-"x79 ."\n";
print  $header_line1;
print  "#". "-"x79 ."\n";


foreach my $obj (sort keys %objects) {
  if ($objects{$obj} ne 'BRANCH' && $objects{$obj} ne 'BASE_LABEL' &&  $objects{$obj} ne 'STATUS') {
      if ($obj =~ /^(.*)@@(.*)$/) {
          print "$1    $objects{$obj}\n" ;
      }
  }
}
close(OUTFILE) if $outfile;

exit 0;

###############################################################################
#
# NAME   : parse_args
#
# PURPOSE: Parse the command-line arguments
#
# INPUTS : $ra_argv  -- ref to @ARGV array
#
# OUTPUTS: $trans_name       -- 
#          $outfile          --
#
# NOTES  :
#
###############################################################################
sub parse_args {
 my $ra_argv          = $_[0];
 my $trans_name       = "";
 my $outfile          = "";

 for (my $i=0 ; $i<scalar(@$ra_argv) ; $i++ ) {
     my $arg = $$ra_argv[$i];
     if ($arg =~ /^-h(elp)?/) {
         &usage(); &error::abort("",1);
     } elsif ($arg =~ /^-txn?/) {
         $i++;
         if (! defined($$ra_argv[$i])) {
             &usage(); &error::abort("must give a transaction name after '$arg' option", 1);
         }
         $trans_name  = $$ra_argv[$i]; $trans_name = lc($trans_name);
     } elsif ($arg =~ /^-o(utfile)?/) {
         $i++;
         if (! defined($$ra_argv[$i])) {
             &usage(); &error::abort("must give outfile after '$arg' option", 1);
         }
         $outfile = $$ra_argv[$i];
     } else {
         &error::push_message("Unrecognized argument: '$arg'");
         &usage(); &error::abort("",1);
     }
   
 } # loop for each arg
  
 unless ( $trans_name ) {
     &error::push_message("Must specify a transaction name");
     &usage(); &error::abort("",1);
 }  
  
 return ($trans_name, $outfile);
  
}

###############################################################################
#
# NAME   : run_query
#
# PURPOSE: Executes sql query
#
# INPUTS : $dbh        -- DB handle
#          $trans_name -- Transaction name
#
# OUTPUTS: %objects    -- Hash of objects
#
# NOTES  :
#
###############################################################################
sub run_query(){
  my $dbh          = $_[0];
  my $trans_name   = $_[1];
  my %objects      = ();

  
  
  my $sql_query = qq {
     
     JR_COMMON.TRANSACTION_METHODS.GET_TRANSACTION_DETAILS(:)
   };



  my $sth = $dbh->prepare($sql_query);

 $sth->bind_param(':txn_names', $ra_trans_names);
 $sth->bind_param(':trans_changes_flag', $get_trans_change_flag);
 $sth->bind_param(':p_config_r_branch_irds',                   $ra_p_config_r_branch_irids);
 $sth->bind_param(':transInfo_trans_irids',  $ra_s_transInfo_trans_irids);
 $sth->bind_param(':transInfo_trans_names',  $ra_s_transInfo_trans_names);
 $sth->bind_param(':ra_s_transInfo_states', $ra_s_transInfo_states);
 $sth->bind_param(':ra_s_transInfo_created_by', $ra_s_transInfo_created_by);
 $sth->bind_param(':ra_s_transInfo_date_created', $ra_s_transInfo_date_created);
 $sth->bind_param(':ra_s_transInfo_managing_service_irids', $ra_s_transInfo_managing_service_irids);
 $sth->bind_param(':ra_s_transInfo_based_config_irids', $ra_s_transInfo_based_config_irids);
 $sth->bind_param(':ra_s_transInfo_owning_workarea_irids', $ra_s_transInfo_owning_workarea_irids);
 $sth->bind_param(':ra_s_transInfo_primary_branch_irids', $ra_s_transInfo_primary_branch_irids);
 $sth->bind_param(':ra_s_transInfo_comments', $ra_s_transInfo_comments);
 $sth->bind_param(':ra_s_transInfo_date_closed', $ra_s_transInfo_date_closed);
 $sth->bind_param(':ra_s_storage_location', $ra_s_storage_location);
 $sth->bind_param(':ra_s_shareWorkareaInfo_trans_names', $ra_s_shareWorkareaInfo_trans_names);
 $sth->bind_param(':ra_s_shareWorkareaInfo_workarea_names', $ra_s_shareWorkareaInfo_workarea_names);
 $sth->bind_param(':ra_s_shareWorkareaInfo_created_by', $ra_s_shareWorkareaInfo_created_by);
 $sth->bind_param(':ra_s_mergeToBranchInfo_trans_names', $ra_s_mergeToBranchInfo_trans_names);
 $sth->bind_param(':ra_s_mergeToBranchInfo_branch_irids', $ra_s_mergeToBranchInfo_branch_irids);
 $sth->bind_param(':ra_s_mergeToBranchInfo_branch_names', $ra_s_mergeToBranchInfo_branch_names);
 $sth->bind_param(':ra_s_mergeToBranchInfo_states', $ra_s_mergeToBranchInfo_states);
 $sth->bind_param(':ra_s_transBranchInfo_trans_names', $ra_s_transBranchInfo_trans_names);
 $sth->bind_param(':ra_s_transBranchInfo_branch_irids', $ra_s_transBranchInfo_branch_irids);
 $sth->bind_param(':ra_s_transBranchInfo_branch_names', $ra_s_transBranchInfo_branch_names);
 $sth->bind_param(':ra_s_transChangesInfo_trans_names', $ra_s_transChangesInfo_trans_names);
 $sth->bind_param(':ra_s_transChangesInfo_trans_irids', $ra_s_transChangesInfo_trans_irids);
 $sth->bind_param(':ra_s_transChangesInfo_branch_names', $ra_s_transChangesInfo_branch_names);
 $sth->bind_param(':ra_s_transChangesInfo_branch_irids', $ra_s_transChangesInfo_branch_irids);
 $sth->bind_param(':ra_s_transChangesInfo_object_irids', $ra_s_transChangesInfo_object_irids);
 $sth->bind_param(':ra_s_transChangesInfo_version_nums', $ra_s_transChangesInfo_version_nums);
 $sth->bind_param(':ra_s_transChangesInfo_full_paths', $ra_s_transChangesInfo_full_paths);
 $sth->bind_param(':ra_s_transChangesInfo_parent_branch_names', $ra_s_transChangesInfo_parent_branch_names);
 $sth->bind_param(':ra_s_transChangesInfo_parent_branch_irids', $ra_s_transChangesInfo_parent_branch_irids);
 $sth->bind_param(':ra_s_transChangesInfo_logical_type_ids', $ra_s_transChangesInfo_logical_type_ids);
 $sth->bind_param(':ra_s_transChangesInfo_schemas', $ra_s_transChangesInfo_schemas);
 $sth->bind_param(':ra_s_mergeinfo_object_irids', $ra_s_mergeinfo_object_irids);
 $sth->bind_param(':ra_s_mergeinfo_from_branch_irids', $ra_s_mergeinfo_from_branch_irids);
 $sth->bind_param(':ra_s_mergeinfo_from_version_nums', $ra_s_mergeinfo_from_version_nums);
 $sth->bind_param(':  ra_s_mergeinfo_to_branch_irids', $ra_s_mergeinfo_to_branch_irids);
 $sth->bind_param(':ra_s_mergeinfo_to_version_nums' $ra_s_mergeinfo_to_version_nums);
 $sth->bind_param(':ra_s_mergeinfo_created_by', $ra_s_mergeinfo_created_by);
 $sth->bind_param(':ra_s_mergeinfo_date_created', $ra_s_mergeinfo_date_created);
 $sth->bind_param(':ra_s_mergeinfo_merge_types',$ra_s_mergeinfo_merge_types);
 $sth->bind_param(':ra_s_mergeinfo_notes', $ra_s_mergeinfo_notes);
 $sth->bind_param(':ra_f_txn_names',                      $ra_f_txn_names);
 $sth->bind_param(':ra_f_reasons',                     $ra_f_reasons);

  $sth->execute($trans_name)|| die $dbh->errstr;
  $sth -> finish;
  return %objects;
}

###############################################################################
#
# NAME   : usage
#
# PURPOSE: Display usage
#
# INPUTS : none
#
# OUTPUTS: to stdout 
#
# NOTES  :
#
###############################################################################
sub usage {
 print STDOUT <<ENDOFUSAGE
 Usage: ade exec $PROGRAM_NAME -txn <transaction name> [-o <outfile> ] 

 Example:
   ade exec $PROGRAM_NAME -txn puvenkat_bug-2323354 -o /tmp/outfile.txt

 Results:
     Outputs a list of objects in a transaction 
     [-o outfile] redirects the output to the specified file.

ENDOFUSAGE
;
}


