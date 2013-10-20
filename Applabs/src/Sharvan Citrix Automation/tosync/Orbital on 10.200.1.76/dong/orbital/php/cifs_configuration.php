<? include("includes/header.php"); ?>

<?
   if ( (isset($_GET["DisableCifs"])) || (isset($_GET["EnableCifs"]) ) )
   {
      $Auth->CheckRights(AUTH_LEVEL_ADMIN);

      if ( isset($_GET["DisableCifs"]) ) { SetParameter("CIFS.PassThrough", true); }
      if ( isset($_GET["EnableCifs"] ) )  { SetParameter("CIFS.PassThrough", false); }

      echo HTML::InsertRedirect("./cifs_configuration.php", 0);
   }
   $CifsEnabled = !GetParameter("CIFS.PassThrough");

   //
   // Get the acceleration by ip mode
   if (isset($_GET["CifsAccelIPsMode"])){
      $AccelMode = (int)$_GET["CifsAccelIPsMode"];
      $CurAccelIPs = GetParameter("CIFS.AcceleratedIPs");
      if ($AccelMode == 1){
         if (sizeof ($CurAccelIPs)>0 && MSG_BOX::Ask("Question?", "Are you sure you wish to clear all IP/Mask acceleration entries?") == MSG_BOX_YES){
            SetParameter("CIFS.AcceleratedIPs", array() );
         }else{
            echo HTML::InsertRedirect("cifs_configuration.php", 0);
         }
      }else{
         SetParameter("CIFS.OnlyAccelIPsOnList", $AccelMode==2);
      }
   }
?>


<?
   if (!$CifsVisible) {
     echo "<BR><BR>";
     echo "<center><img src='./images/warning-large.gif'></center>";
     ThrowException("Under Construction!", false);
     echo " </td> <tr> </table>";
     include("footer.php");
     exit();
   }
?>
<font class="pageheading">Configure Settings: CIFS</font><BR><BR>
<DIV class="settings_table">
<TABLE width="410">

   <!-- SYSTEM STATUS BLOCK -->
   <TR>
   <TH>
    CIFS Acceleration:&nbsp;&nbsp;
   </TH>

   <TD>
         <FORM name="Enable" action="./cifs_configuration.php">

         <? if ($CifsEnabled)
            { ?>
               <FONT color="blue" size="+1">NORMAL</FONT>&nbsp;&nbsp;
               <INPUT type="submit" name="DisableCifs" value="Disable"></INPUT>
         <? }
            else
            {?>
               <FONT color="red" size="+1">DISABLED</FONT>&nbsp;&nbsp;
               <INPUT type="submit" name="EnableCifs" value="Enable">
         <? } ?>
         </FORM>

   </TD>
   </TR>
</TABLE></DIV>
<BR>
<BR>

<?
   echo "<font class=pageheading>CIFS Components</font><BR><BR>";
   $Table = new HTML_TABLE();
   $ParamForm = new HTML_PARAMETER_FORM();
   echo
      "<div class=\"settings_table\">",
      $Table->Begin(),
      $ParamForm->Begin("cifs_config1"),
      $Table->AddEntry("Read Acceleration:", $ParamForm->AddBooleanParam("Cifs.ReadAheadEnabled")),
      $Table->AddEntry("Write Acceleration:", $ParamForm->AddBooleanParam("CIFS.WriteBehindEnabled")),
      $Table->AddEntry("Metadata Caching:", $ParamForm->AddBooleanParam("CIFS.MetaDataCachingEnabled")),
      $Table->AddEntry("Metadata Prefetch:", $ParamForm->AddBooleanParam("CIFS.PreFetchMetaDataEnabled")),
      $Table->AddEntry("Demote Client Security Settings:",   $ParamForm->AddBooleanParam("CIFS.MaskSignatureSecurity")),
      $Table->AddEntry("", $ParamForm->AddSubmit() ),
      $ParamForm->End(),
      $Table->End(),
      "</DIV>";
   echo "</CENTER><BR><BR>";
?>

   <!-- Accelerated/Unaccelerated IPs -->
   <?
      echo "<font class=pageheading>CIFS Include/Exclude by Server IP</font><BR><BR>";
      $Results = GetParameter("CIFS.AcceleratedIPs");

      if (isset($_GET["FormName"]) && $_GET["FormName"]=="AcceleratedIPs"){
         if (isset($_GET["Add"])){
            $NewIPMask["Display"] = $_GET["NewIPMask"];
            array_push($Results, $NewIPMask);
         }
         else if (isset($_GET["Delete"])){
            $IPMaskToDelete = $_GET["AccelIPs"];

            $NewResults = array();
            foreach ($Results as $IPMask){
               if ($IPMask["Display"] != $IPMaskToDelete){
                  array_push($NewResults, $IPMask);
               }
            }
            $Results = $NewResults;
         }

         SetParameter("CIFS.AcceleratedIPs", $Results);
      }

      $AccelItems = array();
      foreach ($Results as $IPMask){
         array_push($AccelItems, $IPMask["Display"]);
      }

      if (sizeof($AccelItems)==0){
         $AccelMode = 1;
      }else{
         $AccelMode = (GetParameter("CIFS.OnlyAccelIPsOnList")?2:3);
      }

      //if (sizeof($AccelItems) == 0){ array_push($AccelItems, "-NONE CONFIGURED-");}

      $Form = new HTML_FORM();
      echo
         "<DIV class=\"settings_table\">",
         "<TABLE>",
         $Form->Begin("AcceleratedIPs"),
         "<TR>",
            "<TH>New IP:</TH>" ,
            "<TD>", $Form->AddTextField("NewIPMask", "", 12) . "<BR>Example: 192.168.1.1</TD>",
            "<TD align=center>", $Form->AddSubmit("Add","Add") .
         "</TR>",
         "<TR>",
            "<TH>Current IPs:</TH>" ,
            "<TD>", $Form->AddList("AccelIPs", $AccelItems, 6, 120) . "</TD>",
            "<TD align=center>", $Form->AddSubmit("Delete","Delete") . "</TD>",
         "</TR>",
         "<TR>",
            "<TH>Mode:</TH>" ,
            "<TD colspan=2>", $Form->AddRadioButton("CifsAccelIPsMode", "1", $AccelMode==1) . "Accelerate All Traffic<BR>" .
                    $Form->AddRadioButton("CifsAccelIPsMode", "2", $AccelMode==2) . "Only Traffic With a Server IP Listed Above<BR>" .
                    $Form->AddRadioButton("CifsAccelIPsMode", "3", $AccelMode==3) . "Never Accelerate Traffic With a Server IP Listed Above<BR>" .
         "</TR>",
         "<TR>",
            "<TD></TD>" ,
            "<TD align=center colspan=2>", $Form->AddSubmit("ChangeMode","Change Mode") . "</TD>",
         "</TR>",
         $Form->End(),
         "</TABLE>",
         "</DIV>";
   ?>

<? include(HTTP_ROOT_INCLUDES_DIR . "footer.php"); ?>
