#!/usr/bin/perl
use strict;
use MIME::Entity;
my $from = 'Administrator@atlessdev25.atlanta.ibm.com';
my $to = 'reports@dst.lexington.ibm.com';
my $subject = "ATL-WIN-BKP:atlessdev25";
my $hostname = 'dst.lexington.ibm.com';
my $ra_attachments = [ #{ 'Type' => 'application/x-bzip2', 'path' => 'attachments/sample.pdf.bz2'},
        #{'Type' => 'plain/text', 'path' => 'attachments/sample.txt'}
];
### Create an entity:
my @my_message = ("line1\n", "line2\n");
my $top = MIME::Entity->build(From    => $from,
			      To      => $to,
			      Subject => $subject,
			      Received => $hostname,
			      Data    => \@my_message);

foreach my $attachment (@$ra_attachments) {
    $top->attach(Path => $attachment->{'path'},
                 Type => $attachment->{'Type'});
}
$top->print(\*STDOUT);

