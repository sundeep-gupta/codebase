#!/usr/bin/perl -w 
#############################################################
#                upload.cgi - PPTS :: ProTS 
#
# copyright     :(c)2000 Whetstone Logic, Inc.
# Date          : Jan. 31, 2001
# Author        : Anderson Silva 

use strict 'vars';
use CGI_Lite;
use Conf::Configuration;

     my %data = get_form();
     view_document(%data) or error("Can't Open Directory");
     exit;


###########################
# Name       : get_form()
# Parameters : void
# Return     : string with directory name for ProTS directory
# Description: This function validates the data from
# the form. And that the script is only accessed via
# POST. And make sure no escape characters are
# entered.
###########################

sub get_form
{
        my $cgi = new CGI_Lite;

        ### Make sure it is accessed by POST
        #unless ((exists $ENV{'REQUEST_METHOD'}) &&
        #        ($ENV{'REQUEST_METHOD'} eq 'POST'))
        #{
        #        print "Content-Type: text/html\n\n";
        #        $cgi->return_error('Invalid Request Method: Requires POST');
        #}

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


#######
#function name: get_form
#input: nothing
#######
sub view_document() {
     my $dir = $download_dir.$data{project}."_".$data{clientid};
     my $template = HTML::Template->new(filename=>'file_manager.tmpl');
     my $cgi = new CGI_Lite;

     unless (-e $dir) {
       mkdir($dir, 0755) or error("The directory was not found, but I tried to create a new one for you. Still, I can't make the directory. Please, contact Administrator.");
    } 
     
     opendir(HANDLE, $dir) or error("There is a directory available, but I can't open it. It may be a permission problem. Please, contact administrator");
     
     my @files_loop = (); 
     while(defined (my $file = readdir (HANDLE)))
     {  
        if (($file ne ".") && ($file ne "..")) 
        { 
          my %Files;
          $Files{NAMEURL}= url_encode($file);
          $Files{NAME} = $file;
          $Files{PID} = $data{PID}; 
          $Files{DIR}= url_encode($data{project}."_".$data{clientid});
          my $size = (stat($dir."/".$file)) [7]; 
          $Files{SIZE} = $size;
          $Files{MODIFIED} = localtime((stat($dir."/".$file)) [9]);
          push(@files_loop, \%Files);      
        }
     }
     
     closedir(HANDLE);
     
     $template->param(
                      PID => $data{PID},
                      DIR => $data{project}."_".$data{clientid},
                      FILE_LOOP => \@files_loop,
                     );

     print "Content-Type: text/html\n\n";
     print $template->output;

}



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



