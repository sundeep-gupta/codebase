#!/tools/bin/perl

use XMLRPC::Lite;
use Data::Dumper;

#:q!
#  This tool either reads or writes. 
# slurp the config file and then  eitehr read
# or write to the orbital 
#

$Data::Dumper::Purity = 1;
$Data::Dumper::Indent = 0;
$Data::Dumper::Useqq = 1;

chomp(my $config_file   = shift);

do $config_file   or die "could not parse config file:$! \n" ;

my $orbital = $orb_conf || "10.200.38.53" ;
my $port = $orb_port || "2050";
my $url = "http://$orbital:$port/RPC2" ;
print "Extract the configuration List : \n";
foreach  my $t (@config_list)
   { print "$t->{'type'}\n";
     print "$t->{'attr'}\n";
     print "-------------\n";
   }

    foreach my $t (@config_list) 
      {
        print "setting " . $t->{'attr'} . " to " . $t->{'set'} . "\n" ;
        my $response =  XMLRPC::Lite
          -> proxy($url)
            ->call($t->{'action'}, {Class => $t->{'type'}, Attribute => $t->{'attr'}, Value => $t->{'set'} })
             -> result;


        while (( my $okey, my $oval) = each %$response)
          {
            if ($t->{'datatype'} eq 'scalar')
              {
                print  $t->{'attr'} . ":" . $oval->{'XML'} . "\n";
              }
            elsif ($t->{'datatype'} eq 'hash') {
              my $s = $oval->{'XML'} ;
              my %temp_hash = %$s ;
              my ($key, $val);
              print $t->{'attr'} . "\n" ;
              while ((  $key , $val ) = each ( %temp_hash )) {
                print "  $key => $val \n" ;
              }
            } elsif ($t->{'datatype'} eq 'array') {
              my $s = $oval->{'XML'} ;
              my @arr = @$s ;
	      print Dumper($oval) ;
              #print $t->{'attr'} . "\n" ;
              #foreach my $u (@arr) {
              #  print "  ($u) \n" ;
              #}
            } else {
              print "unknown type \n" ;
            }
          }
      }
