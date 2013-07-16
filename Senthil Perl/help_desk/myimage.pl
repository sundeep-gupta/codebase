#!/usr/bin/perl

#standard code to parse HTTP query parameters
%query = map {my($k,$v) = split(/=/)} split(/&/, $ENV{"QUERY_STRING"});

open(FILE, $query{"img"});

binmode(FILE);
binmode(STDOUT);

print "Content-type: image/png\n\n";
while (!eof(FILE)) {
    read(FILE, $data, 64000);
    print $data;
}
close(FILE);
