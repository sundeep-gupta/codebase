#!/usr/bin/perl
use DBI;
#definition of variables
$db="test1";
$host="localhost";
$user="root";
$password="password";  # the root password

#connect to MySQL database
my $dbh   = DBI->connect ("DBI:mysql:$db:$host",$user,$password) 
                           or die "Can't connect to database: $DBI::errstr\n";
$query = "Select * from test1";
$res = $dbh->prepare($query);
$res->execute();
while( @row = $res->fetchrow_array()) {
	print "@row"."\n";
}

#disconnect  from database 
$dbh->disconnect or warn "Disconnection error: $DBI::errstr\n";

exit;
