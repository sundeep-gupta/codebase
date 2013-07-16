use Storable;
 
# Create a hash with some nested data structures
my %struct = ( text => 'Hello, world!', list => [1, 2, 3] );
 
# Serialize the hash into a file
store \%struct, 'serialized';
 
# Read the data back later
my $newstruct = retrieve 'serialized';

