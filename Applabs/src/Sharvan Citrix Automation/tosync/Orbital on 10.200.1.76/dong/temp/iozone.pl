#!/tools/bin/perl 

=head NAME 

iozone.pl


=head1 SYNOPSIS

If run from the command line:

iozone.pl -u <directory location>

=head1 DESCRIPTION

=cut


=head1 ARGUMENTS

=cut

use Test::More  tests => 1; # the number of tests
use Carp ;
#use strict ;
use Time::HiRes ;
use Getopt::Std ;
use vars qw( $opt_u);

getopt ("u") ;

my $fs ;
if ( $opt_u ) {
  $fs = $opt_u ;
}
elsif ($ENV{'PARAM'} ){
    $fs =  $ENV{'PARAM'}->{'_fs'} ;
}

elsif ($ENV{'FS'} ){
  $fs = $ENV{'FS'} ;
}

die "\ndid not get file location: iozone.pl -u <directory location> \nor run script from /tools/bin/run./pl \n\n" 
  unless ($fs ) ;
  

chomp ($fs ) ;


is( run_iozone( $fs, "  -Rac " ) , 1, "iozone ,  automatic mode with close request: $fs") ;

sub run_iozone
  {
    my $fs = shift ;
    my $option = shift ;
    my $invoke = "/tools/utils/iozone/iozone  $option $fs" ;
    print "INVOKE:$invoke \n" ;
    my $out = `$invoke` ;
    return 1 ;
    #    } else { print $out ; return 0 ; }
  }
