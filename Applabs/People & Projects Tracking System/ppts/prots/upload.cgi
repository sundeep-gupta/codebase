#!/usr/bin/perl -w 
#############################################################
#                upload.cgi - PPTS :: ProTS 
#
# copyright     :(c)2000 Whetstone Logic, Inc.
# Date          : Jan. 31, 2001
# Author        : Anderson Silva 

use strict;
use CGI_Lite;
use Conf::Configuration;

     upload_document() or error("Can't Upload File");
     exit;

#######
#function name: get_form
#input: nothing
#######
sub upload_document() {

    my $cgi = new CGI_Lite;

    #check to make sure accessed by POST
    unless ((exists $ENV{'REQUEST_METHOD'}) && 
         ($ENV{'REQUEST_METHOD'} eq 'POST')) {
        print "Content-Type: text/html\n\n";
        $cgi->return_error('Invalid Request Method: Requires POST');
    }
    
    #handle download of files
    
    my $tmp = $download_dir."/tmp";
    unless (-e $tmp) {
      error("The <b>tmp</b> directory has been removed, please contact administrator");
    }

    $cgi->set_platform('Unix');
    $cgi->set_file_type('file');
    $cgi->add_timestamp(0);
    $cgi->set_directory($tmp) or error("The <b>tmp</b> directory is present, but I still can't upload. It may be a permission problem. Please contact administrator.");

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

    my $path = $download_dir."/".$form{ProjectName}."_".$form{ClientID};
    
    unless (-e $path) {
       mkdir($path, 0755) or error("The directory was not found, but I tried to create a new one for you. Still, I can't make the directory. Please, contact Administrator.");
    } 

    my @args = ("mv", $download_dir."tmp/".$form{doc}, $path);
    system (@args) == 0 or die "Somethine went wrong I can't copy the files to $path. Please, contact administrator.";
    
    
    my $template = HTML::Template->new(filename=>'done.tmpl'); 
    $template->param(PID => $form{PID}); 
    print "Content-Type: text/html\n\n";
    print $template->output;
   

} #end of get_form()



#######
#function name: error
#input: message to display as scalar
#output: a HTML::Template page
#description: This function displays an error page via HTML::Template.  It is
#        passed an error message in which it will display.
#######
sub error() {

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

}  #end of error()



