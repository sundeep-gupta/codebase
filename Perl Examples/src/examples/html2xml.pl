use strict;

my $dir = $ARGV[0] || '.';

opendir(my $dirh, $dir);
my @files = <$dirh>;
closedir($dirh);

foreach my $file (@files) {
	my $new_file = (split('.', $file))[0];
	$new_file .= 'xml';

	open(my $fh, $file);
	my @lines = <$fh>;
	close($fh);
	
	forech $line (@lines) {
		if ($line =~ /<table.*>(.*)/) {
			if($first_table) {
				$rest_of_line = $1;
				$data_found = 1;
			} else {
				$first_table = 1;
			}
		} elsif($data_found) {
			if($line =~ /(.*)<\/table>/) {
				$rest_of_line .= $1;
				last;
			}
			$rest_of_line .= $line;
		}
	}	

}
