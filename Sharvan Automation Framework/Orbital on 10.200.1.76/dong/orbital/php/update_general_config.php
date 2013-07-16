<?
   include("includes/header.php"); 
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>

<?
   $IPAddress = $_GET["IPAddress"];

   $Param["Class"] = "SYSTEM";      
   $Param["Attribute"]["NetworkInfo"]["Address"]["Dotted"] = $IPAddress;
   $Param["Attribute"]["NetworkInfo"]["Mask"]["Dotted"] = $_GET["NetworkMask"];
   $Param["Attribute"]["NetworkInfo"]["Gateway"]["Dotted"] = $_GET["Gateway"];
   $Param["Attribute"]["NetworkInfo"]["Dns"]["Dotted"] = $_GET["DNSServer"];
   $Param["Attribute"]["NetworkInfo"]["Dhcp"] = $_GET["Dhcp"];
   $Param["Attribute"]["NetworkInfo"]["Hostname"] = $_GET["Hostname"];
   
   $Results = xu_rpc_http_concise(
                                 array(
                                    'method' => "Set",
                                    'args'      => $Param,                 
                                    'host'      => RPC_SERVER,
                                    'uri'    => RPC_URI,
                                    'port'      => RPC_PORT
   ));

   echo HTML::InsertRedirect("http://127.0.0.1" . "./redirect.php?Time=" . RESTART_TIME . "&NextPage=./index.php", 1);
      
?>
