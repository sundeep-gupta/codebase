#!/usr/bin/perl -w 

package Conf::Configuration;

use strict;
use vars qw(
    @ISA
    @EXPORT
    %db
    $dsn
    $download_dir
);
use CGI_Lite;
use CGI::Carp 'fatalsToBrowser';
use DBI;
use Exporter;
use HTML::Template;


@ISA    = qw(Exporter);
@EXPORT = qw(
    %db
    $dsn
    $download_dir
    $remove_dir
);



%db = (

    'attr' => { 'RaiseError' => 1 },
    'dbd'  => 'mysql',
    'host' => 'localhost',
    'name' => 'PPTS',
    'user' => 'root',
    'pass' => '',
        
    
    
);

$dsn = "DBI:$db{'dbd'}:database=$db{'name'};host=$db{'host'}";

$download_dir = "/YOUR/DIRECTORY/HERE/ipts/prots/docs/";


1;
