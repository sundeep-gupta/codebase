#!/usr/bin/perl

my @values;
push(@values,"<string>Region A</string>");
			
open(FHIN,"data.txt");
open(FHOUT,">data.xml");
print FHOUT "<chart_data><row><null/>";
while (<FHIN>) {
	print FHOUT "<string>$ctr</string>";
	push(@values,"<number>$_</number>");
}
print FHOUT "</row>";
push(@values,"</row>");
print FHOUT @values;

close(FHIN);
close(FHOUT);