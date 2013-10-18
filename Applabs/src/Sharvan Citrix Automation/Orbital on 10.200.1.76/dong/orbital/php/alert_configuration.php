<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);

   $ClassInfo = xu_rpc_http_concise(
               array(
                  'method' => "GetAlertClassInfo",
                  'args'      => array(),
                  'host'      => RPC_SERVER,
                  'uri'    => RPC_URI,
                  'port'      => RPC_PORT
               ) );
   $ClassLevels = GetParameter("Alert.ClassLevels");

   if (isset($_GET["UpdateClassLevels"])) {
      foreach ($ClassInfo as $Index => $Class) {
         if (isset($_GET["Level" . $Class["ClassName"]])) {
            $ClassLevels[$Class["Class"]] = (int)($_GET["Level" . $Class["ClassName"]]);
         }
         if (isset($_GET["RateParameter". $Class["ClassName"]])) {
            SetParameterText($Class["RateParameter"],$_GET["RateParameter" . $Class["ClassName"]]);
         }
         if (isset($_GET["PercentParameter". $Class["ClassName"]])) {
            SetParameterText($Class["PercentParameter"],$_GET["PercentParameter" . $Class["ClassName"]]."%");
         }
      }
      SetParameterAsXML("Alert.ClassLevels",$ClassLevels);
   }

   if (isset($_GET["AlertOffTime"])) {
      SetParameterText("Alert.OffTime",$_GET["AlertOffTime"]);
   }

   if (isset($_GET["ResetToDefaults"])) {
      $Resets = array("Alert.OffTime");
      foreach($ClassInfo as $Index => $Class) {
         $ClassLevels[$Class["Class"]] = $Class["DefaultLevel"];
         if ($Class["RateParameter"] != "") {
            array_push($Resets,$Class["RateParameter"]);
         }
         if ($Class["PercentParameter"] != "") {
            array_push($Resets,$Class["PercentParameter"]);
         }
      }
      SetParameterAsXML("Alert.ClassLevels",$ClassLevels);
      $Result = xu_rpc_http_concise(
                        array(
                           'method' => "ResetToDefault",
                           'args'   => array($Resets),
                           'host'      => RPC_SERVER,
                           'uri'    => RPC_URI,
                           'port'      => RPC_PORT
                        )
         );

   }

   ?>

   <font class="pageheading">Configure Settings: Alert</font><BR><BR>

   <form>
      <table class="width750" align=center>
          <tr class=table_header_misc2>
            <th>Alerted</th>
            <th>Logged</th>
            <th>Disabled</th>
            <th>Description</th>
            <th></th>
            <th></th>
          </tr>

   <?
   function DoMyRadio($Value,$Level,$Info,$ClassMinLevel) {
      if ($Value < $ClassMinLevel) {
         echo "<td nowrap> </td>";
      } else {
         echo "<td nowrap align=center> <input type=radio name='Level".$Info["ClassName"]."' value=" . $Value;
         if ($Level == $Value) echo " checked";
         echo "> </td>";
      }
   }
   foreach ($ClassInfo as $Index => $Info) {
      $MinLevel = $ClassInfo[$Info["Class"]]["MinLevel"];
      if ($MinLevel < 2) { // Don't show levels that can't be changed.
         echo "<tr>";
         $Level = $ClassLevels[$Info["Class"]];
         DoMyRadio(2,$Level,$Info,$MinLevel);
         DoMyRadio(1,$Level,$Info,$MinLevel);
         DoMyRadio(0,$Level,$Info,$MinLevel);
         echo "<td nowrap> " . $Info["Description"] . "</td>";
         if ($Info["RateParameter"] == "" && $Info["PercentParameter"] == "") {
            echo "<td></td>";
         } else if ($Info["PercentParameter"] == "") {
            echo " <td nowrap> more than <input type=text size=5 name=RateParameter".$Info["ClassName"]. " value='";
            echo GetParameter($Info["RateParameter"]) . "'> ";
            echo $Info["Units"] . " per minute </td>";
         } else {
            echo "<td nowrap> more than <input type=text size=5 name=PercentParameter".$Info["ClassName"]. " value='";
            echo (GetParameter($Info["PercentParameter"])*100.0) . "'> ";
            echo "% per minute </td>";
         }
         echo "<td nowrap> ";
         echo MakeHelp("DoHelp".$Index,"Help for " . $Info["Description"],$Info["HelpText"]);
         echo "</td>";
         echo "</tr>";
      }
   }
   echo "<tr> <td colspan=6> &nbsp; </td> </tr> <tr> <td colspan=5 align=center> Alert Retention Time ";
   echo "<input type=text name=AlertOffTime size=5 value=" .GetParameter("Alert.OffTime"). "> sec </td>";
   echo "<td>";
   MakeHelp("DoHelpAlertOff","Help for Alert Retention Time",
      "This setting specifies the amount of time after an alert is no longer detected before the alert is cleared from the UI.");
   echo "</td></tr>";
?>
   <TR>
   <TD colspan=6 align=center>
      <br>
      <input type=hidden name=UpdateClassLevels value=1>
      <input type=submit value='Update Alert Message Settings'>
      </form>
   </TD>
   </tr>
   <tr>
   <TD colspan=6 align=center>
      <form>
      <input type=hidden name=ResetToDefaults value=1>
      <input type=submit value='Reset to Defaults'>
      </form>
   </TD>
   </TR>
   </TABLE>
<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>

