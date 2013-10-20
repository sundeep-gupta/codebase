<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   define('DONT_REQUIRE_RUNNING_SERVER', true);
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>

<HTML>
<HEAD>
<TITLE>Orbital Management Console - Debug Extender</TITLE>
<link rel=stylesheet type="text/css" href="css/orbital.css">
</HEAD>

<BODY>
<font class="pageheading">Diagnostics: Remote Debug</font><BR><BR>

   <?

      if ( isset($_GET["StartExtender"]) )
      {
         ShowStatusMessage("Starting the Debug Extender...");      
         $DebugExtenderIP = $_GET["ExtenderIP"];

         $StartOnReboot = isset($_GET["StartOnReboot"]);

         ShowStatusMessage("...Started.");

         exec ("/usr/bin/sudo " . SCRIPT_DIR . "extender.run --stop");
 
         if ($StartOnReboot) 
         {
            exec("/usr/bin/sudo " . SCRIPT_DIR . "extender.run --start --ip=$DebugExtenderIP --autostart");
         } 
         else 
         {
            exec("/usr/bin/sudo " . SCRIPT_DIR . "extender.run --start --ip=$DebugExtenderIP");
         }
         
         SetParameter("UI.DebugDaemonAutostart", $StartOnReboot);
         SetParameterText("UI.DebugDaemonIP", $DebugExtenderIP);
      }
      else if ( isset($_GET["StopExtender"]) ){
         exec("/usr/bin/sudo " . SCRIPT_DIR . "extender.run --stop");
         ShowStatusMessage("The debug extender was stopped.<BR><BR>");
      }
      
      $StartOnReboot = GetParameter("UI.DebugDaemonAutostart");
      $DebugExtenderIP = str_replace("'", "", GetParameterText("UI.DebugDaemonIP") );
      
      // See if the extender is running
      $GrepResults = exec("ps aux|grep extender|grep -v grep");
      $IsExtenderRunning = (strlen($GrepResults) > 0);
   ?>

   <FORM>
      <TABLE width=600>
      <TR><TH colspan=5>
         Debug Extender
      </TH></TR>

      <TR>
      <TD>
      Extender IP:
         <input type=text name=ExtenderIP size=14 value="<?=$DebugExtenderIP?>">
      </TD>
      <TD>
         Autostart On Reboot:
         <?=HTML_FORM::AddCheckbox("StartOnReboot", $StartOnReboot);?>
      </TD>
      <TD>
         <INPUT type="Submit" name="StartExtender" value="Start"  style="width: 65px" type="Get">
      </TD>
      <TD nowrap>
         Status: <font color=blue><?=$IsExtenderRunning?"Running":"Stopped"?></B>
         <?
            if ($IsExtenderRunning){
               echo "<INPUT type='Submit' name='StopExtender' value='Stop Extender' style=\"width: 65px\" type='Get'>";
            }
         ?>               
      </TD>
      </TR>
      </TABLE>
   </FORM>

   <BR>
   <DIV class=helptext>
      <IMG src='./images/icon-info.gif'>&nbsp;
      The Remote Debug feature allows an Orbital Data support person to access an
      Orbital unit that is sitting behind a firewall. When enabled, a connection is
      opened up to the Orbital Data support system, through which an Orbital Data support person
      can gain access to the Orbital unit.
   </DIV>

</BODY>
</HTML>

<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php");?>
