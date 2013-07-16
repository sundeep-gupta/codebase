use strict;
#use const IGNORE_CASE => 1;
use Data::Dumper;
my $input =  join("", <DATA>);
# Store the unique words in a hash
my %hash_count = ();
foreach my $key (split(/[,;\t\n\s.]+/,$input)) {
#	$key = lc($key) if IGNORE_CASE;
        $hash_count{$key} = 0;
}
foreach my $key (keys(%hash_count)) {
	$hash_count{$key} = $hash_count{$key} + 1 while ($input =~ /\b$key\b/g);
}
print Dumper(\%hash_count);

__DATA__
This is the data block
that contains 		the data elements
separated by spaces, comma,tab,blah,blah,blah
what els, can we Do now using re.