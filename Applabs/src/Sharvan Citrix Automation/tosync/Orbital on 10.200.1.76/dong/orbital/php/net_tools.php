<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   define('DONT_REQUIRE_RUNNING_SERVER', true);
   include("includes/header.php");

   $DisplayableResponse = "";
   
   //
   // Perform the ping test
   //
   if (isset($_GET["Ping"])){
      $IPAddress = $_GET["IPAddress"];
      $DataSize  = $_GET["DataSize"];
      $NumPings  = $_GET["NumPings"];

      exec ("/bin/ping -s $DataSize -c $NumPings $IPAddress", $PingResponse);
      foreach ($PingResponse as $Line){
         $DisplayableResponse .= $Line . "<BR>\n";   
      }
      echo "<B>Ping Response:</B><BR><BR>\n";
   }
   //
   // Perform the traceroute test
   //
   elseif (isset($_GET["Traceroute"])){
      $IPAddress = $_GET["IPAddress"];
      $MaxHops  = $_GET["MaxHops"];
      
      exec ("/usr/sbin/traceroute -n -m $MaxHops $IPAddress", $TracerouteResponse);
      foreach ($TracerouteResponse as $Line){
         $DisplayableResponse .= $Line . "<BR>\n";   
      }
      echo "<B>Traceroute Response:</B><BR><BR>\n";
   }
   
   //
   // Display the results
   //
   echo $DisplayableResponse;

?>
