<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);

   //
   // Need to do this before we include header, as it checks the number of outstanding alerts, and we're about to change that!!!!
   //
   if (isset($_GET["ClearAllAlerts"])) {
      $Result = xu_rpc_http_concise(
                  array(
                     'method' => "ClearAllAlerts",
                     'args'      => array(),
                     'host'      => RPC_SERVER,
                     'uri'    => RPC_URI,
                     'port'      => RPC_PORT
                  ) );
      echo HTML::InsertRedirect("./alerts.php", 0);                                    
   } else if (isset($_GET["ClearAlert"])) {
      $Result = xu_rpc_http_concise(
                  array(
                     'method' => "ClearAlert",
                     'args'      => array((int)$_GET["ClearAlert"]),
                     'host'      => RPC_SERVER,
                     'uri'    => RPC_URI,
                     'port'      => RPC_PORT
                  ) );
      echo HTML::InsertRedirect("./alerts.php", 0);                  
   }

   function FormatDuration($Seconds) {
      if ($Seconds < 60) {
         return $Seconds." Seconds";
      }
      $Minutes = (int)($Seconds / 60);
      if ($Minutes < 60) {
         return $Minutes . " Min " . ($Seconds%60) . " Secs";
      }
      $Hours = (int)($Minutes / 60);
      if ($Hours < 24) {
         return $Hours . " Hours " . ($Minutes % 60) . " Min";
      }
      $Days = (int)($Hours / 24);
      return $Days . " Days " . ($Hours % 24) . " Hours";
   }
   function DoAlerts($Alerts,$Active,$Color) {
      if (sizeof($Alerts) != 0) {
         echo " <tr> <th colspan=5> " . ($Active?"Active":"Past") . " Alerts </th> </tr>";
         foreach ($Alerts as $Alert) {
            echo "<tr> ";
            echo  "<td nowrap> ". FormatDate($Alert["AssertDate"]) . " </td> ";
            if ($Active) {
               echo  "<td nowrap> " . FormatDuration($Alert["Duration"]) . " </td>";
               echo  "<td> <tt> <big> <b> <font color=red> ";
            } else if ($Alert["Duration"] == 0){
               echo  "<td nowrap align=center> <i> n/a </i> </td> ";
               echo  "<td> <tt> <big> <b> <font> ";
            } else {
               echo  "<td nowrap> ". FormatDuration($Alert["Duration"]) . " </td> ";
               echo  "<td> <tt> <big> <b> <font> ";
            }
            echo  $Alert["Msg"] . " </font> </b> </big> </tt></td>";
            echo " <form> <td nowrap> ";
            echo " <input type=hidden name=ClearAlert value=" . $Alert["Number"] . ">";
            echo " <input type=submit value=Clear>";
            echo " <a href='javascript:DoHelp" .$Alert["ClassNumber"]. "()'> Help </a> </td>";
            echo " </td> </form> ";
            echo " </tr>";
         }
      }
      return sizeof($Alerts);
   }

   $Alerts           = GetSystemParam("Alerts");
   $AssertedAlerts   = array_merge($Alerts["Asserted"][0],  $Alerts["Asserted"][1], $Alerts["Asserted"][2]);
   $DeassertedAlerts = array_merge($Alerts["Deasserted"][0],  $Alerts["Deasserted"][1], $Alerts["Deasserted"][2]);
   
   //var_dumper($Alerts["Asserted"]);

   if (sizeof($AssertedAlerts) + sizeof($DeassertedAlerts) == 0) {
      echo "<center> <big> No Outstanding Alerts </big> </center>";
   } else {
      $ClassInfo = xu_rpc_http_concise(
                  array(
                     'method' => "GetAlertClassInfo",
                     'args'      => array(),
                     'host'      => RPC_SERVER,
                     'uri'    => RPC_URI,
                     'port'      => RPC_PORT
                  ) );
      foreach ($ClassInfo as $AClass) {
         echo( MakeHelpFunction("DoHelp".$AClass["Class"],"Help",$AClass["HelpText"]) );
      }
      echo " <br> ";
      echo " <center> <font size=+3> Alerts </font> </center> <br>";
      echo " <table> ";
      echo " <tr> ";
      echo " <th nowrap width=8%> Detected </th> ";
      echo " <th nowrap width=8%> Duration </th> ";
      echo " <th width=64%> Message </th> ";
      echo " <th nowrap width=10%> </th> ";
      echo " </tr> ";
      $i  = DoAlerts($AssertedAlerts,  true,0);
      $i += DoAlerts($DeassertedAlerts,false,0);
      echo " </table>";
      echo "<br><br> <center> <form> <input type=hidden name=ClearAllAlerts value=1> <input type=submit value='Clear All'> </form> </center> ";
   }

?>
