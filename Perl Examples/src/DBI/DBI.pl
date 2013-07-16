#!/perl/bin/perl
print "Content-Type: text/html \n\n;";

use DBI;

$dbh = DBI->connect( "DBI:mysql:test1:localhost", "root","password") or die "Connecting : $DBI::errstr\n ";

$q = "select * from test1";

$sth = $dbh->prepare($q) or die "preparing: ",$dbh->errstr;

$sth->execute or die "executing: ", $dbh->errstr;

while ( @row = $sth->fetchrow_array()) {
      print "Row: @row\n";
}

#$sth->execute or die "executing: ", $dbh->errstr;

#while(my $ref = $sth->fetchrow_hashref()){
#	print "\n$ref->{'userid'}";
#}

$dbh->disconnect(  );


