require DBI;
require DBD::Oracle;
$tns_string = '(DESCRIPTION= (ADDRESS_LIST=(LOAD_BALANCE=ON) (ADDRESS=(PROTOCOL=tcp)(HOST=dbs232-crs.us.oracle.com)(PORT=1521)) (ADDRESS=(PROTOCOL=tcp)(HOST=dbs232-crs.us.oracle.com)(PORT=1522)) (ADDRESS=(PROTOCOL=tcp)(HOST=dbs233-crs.us.oracle.com)(PORT=1521)) (ADDRESS=(PROTOCOL=tcp)(HOST=dbs233-crs.us.oracle.com)(PORT=1522))) (CONNECT_DATA=(SERVICE_NAME=bugap.us.oracle.com)))';
$connect_string = 'ADEBUG/WELCOME@'.$tns_string;
#PRODUCTION_BUGDB.US.ORACLE.COM';
my $dbh = DBI->connect("dbi:Oracle:", $connect_string, "" ) or die ("Unable to connect to Bug DB\n");
$sql = qq ( select PRODUCT_GROUP_ID
                   from bug.PRODUCT
                  where PRODUCT_ID = ? );
 my $sth = $dbh->prepare($sql);
  if ($DBI::err) {
      print($DBI::errstr); $sth->finish; return;
  }
  $sth->execute(81);
  if ($DBI::err) {
      print($DBI::errstr); $sth->finish; return;
  }
 my ($prodgroup_id,) = $sth->fetchrow();
print $prodgroup_id;