use Net::SCP;

$scp = Net::SCP->new("10.199.32.62");
  $scp->login("root");
  $scp->cwd("/orbital/current/http_root");
  $scp->size("/service_class.php");
  $scp->get("/service_class.php");
	print  $scp->{errstr};
#  $scp->quit;