 use Getopt::Long;
 use Data::Dumper;
 my $data   = "file.dat";
 my $length = 24;
 my $verbose;
print @ARGV;
 $result = GetOptions ("length=i" => \$length,    # numeric
                        "file=s"   => \$data,      # string
                        "verbose"  => \$verbose);  # flag
 print $length,$data,$verbose;