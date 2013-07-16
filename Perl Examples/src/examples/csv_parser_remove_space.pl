#!/usr/bin/perl -w
my $regex = $ARGV[0] || ',';
# TO TEST : '"([^"]+?)",?|([^,]+),?|,';
# NOT WORKING : ([^",]*|"([^"]|"")+")(,|$
# NOT WORKING : '^(("(?:[^"]|"")*"|[^,]*)(,("(?:[^"]|"")*"|[^,]*))*)$';
# SOMEWHAT WORKING : "^\"[^\"+]?\\\"|,"
# SOMEWHAT WORKING : ",(?=(?:[^\"]*\"[^\"]*\")*(?![^\"]*\"))"
# TO TEST : from javascript
# (
# // Delimiters.
# "(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +
#  
# // Quoted fields.
# "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +
#  
# // Standard fields.
# "([^\"\\" + strDelimiter + "\\r\\n]*))"
# ),
# "gi"
# );

my $line = <DATA>;
while(<DATA>) {
    chomp $_;
#    print "\nINPUT: $_\nOUTPUT:";
#    print split(/$regex/,$_);
     split_string($_);
}
print "\n";

sub split_string {
    my $text = shift;
    my @new = ();
    push(@new, $+) while $text =~ m{ \s*(
        # groups the phrase inside double quotes
        "([^\"\\]*(?:\\.[^\"\\]*)*)"\s*,?
        # groups the phrase inside single quotes
        | '([^\'\\]*(?:\\.[^\'\\]*)*)'\s*,?
        # trims leading/trailing space from phrase
        | ([^,\s]+(?:\s+[^,\s]+)*)\s*,?
        # just to grab empty phrases
        | (),
        )\s*}gx;
    push(@new, undef) if $text =~ m/,\s*$/;

    # just to prove it's working
    print "string: >>$text<<\n";
    foreach (@new) {
        print " part: <" . (defined($_) ? $_ : '') . ">";
    }
    print "\n";
}

__DATA__

"abcd",\"efg\",hij
a,b,c,d,e,f,g,h
"a,b,c,d",e,f,g,h
\"a,b,c,d\",e,f,g,h
  a  , bb  , c c, d\\\\\\\,eeeee
