use Text::Abbrev;
use Data::Dumper;
$hashref = abbrev qw(list, sort, delete, update);
print Dumper($hashref);
for($i=0;$i<10;$i++) {
    print ('Hi');
}
