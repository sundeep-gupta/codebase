use Config::Auto;
use Data::Dumper;
  my $config = Config::Auto::parse();
print Dumper($config);