use strict;
open(FH, "c:\\page.html") or die "Unable to open page\n";
my @contents = <FH>;
#chomp @contents;
my $cont = join('',@contents);
my $regex = '<div class="twikiToc">(.*?)</div>';
if($cont =~ m/$regex/s) {

	$cont = $1;
	$cont =~ s/<.*?>//g;
my	@current_issues = split("\n",$cont);

my $i = 1;
	foreach my $ci (@current_issues) {
		print "$i $ci\n";
		$i++;
	}
	
}
close FH;