<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>

<font class="pageheading">Configure Settings: SNMP</font><BR><BR>
<font class="pageheading">System Information</font><BR><BR>

<?
   if ( (isset($_GET["DisableSnmp"])) || (isset($_GET["EnableSnmp"]) ) )
   {
      $Auth->CheckRights(AUTH_LEVEL_ADMIN);

      if ( isset($_GET["DisableSnmp"]) ) { SetParameter("Snmp.Enable", false); }
      if ( isset($_GET["EnableSnmp"] ) )  { SetParameter("Snmp.Enable", true); }
   }
   $SnmpEnabled = GetParameter("Snmp.Enable");

?>
<DIV class="settings_table">
<TABLE width="600">

   <!-- SNMP AGENT STATUS BLOCK -->
   <TR>
   <TH>
      SNMP Status:&nbsp;&nbsp;
   </TH>

   <TD>
         <FORM name="Enable" action="./snmp.php">

         <? if ($SnmpEnabled)
            { ?>
               <FONT color="blue" size="+1">NORMAL</FONT>&nbsp;&nbsp;
               <INPUT type="submit" name="DisableSnmp" value="Disable"></INPUT>
         <? }
            else
            {?>
               <FONT color="red" size="+1">DISABLED</FONT>&nbsp;&nbsp;
               <INPUT type="submit" name="EnableSnmp" value="Enable">
         <? } ?>
         </FORM>

   </TD>
   </TR>
</TABLE></DIV><BR><BR>

<?
   $Table = new HTML_TABLE();
   $ParamForm = new HTML_PARAMETER_FORM();
   echo
      "<div class=\"settings_table\">",
      $Table->Begin(),
      $ParamForm->Begin("snmp"),
      //$Table->AddEntry("Enable SNMP Agent:", $ParamForm->AddBooleanParam("Snmp.Enable")),
      $Table->AddEntry("Name:",      $ParamForm->AddTextParam("Snmp.Name", 16)),
      $Table->AddEntry("Location:",  $ParamForm->AddTextParam("Snmp.Location", 30)),
      $Table->AddEntry("Contact:",   $ParamForm->AddTextParam("Snmp.Contact", 30) ),
      $Table->AddEntry("Enable SNMP Authorization Failure Traps:",   $ParamForm->AddBooleanParam("Snmp.AuthTrapEnable")),
      $Table->AddEntry("", $ParamForm->AddSubmit() ),
      $ParamForm->End(),
      $Table->End(),
      "</DIV>";      
   echo "</CENTER><BR><BR>";

?>

<?
   function RemoveEntry($Which,$Num) {
      $Entries = GetParameter($Which);
      unset($Entries[$Num]);
      $Result = array_values($Entries);
      if (MSG_BOX::Ask("Remove Entry?", "Are you sure you wish to delete this entry?") == MSG_BOX_YES){
         SetParameterAsXML($Which,$Result);
      }
   }

   function AddMgmtEntry($Which) {
      $Entries = GetParameter($Which);
      foreach ($Entries as $p) {
         if (($p["Community"] == $_GET["Community"]) &&
             ($p["IpAddr"]["Dotted"] == $_GET["IpAddr"])){
            echo "<BR><H2><I>Addition ignored, Duplicate Community/IP " . $_GET["Community"] . "</I></H2> <BR>";
            return;
         }
      }
      $P["Community"] = $_GET["Community"];
      $P["IpAddr"]["Dotted"] = $_GET["IpAddr"];
      $P["IpMask"] = $_GET["IpMask"];
      $Entries[sizeof($Entries)] = $P;
      SetParameterAsXML($Which,$Entries);
   }

   if (isset($_GET["Action"])) {
      if ($_GET["Action"] == "AddMgmt") {
         AddMgmtEntry("Snmp.SnmpMgmtTuples");
      }
   } else if (isset($_GET["DeleteFull"])) {
      RemoveEntry("Snmp.TrapDestTuples",$_GET["DeleteFull"]);
   } else if (isset($_GET["DeleteFullMgmt"])) {
      RemoveEntry("Snmp.SnmpMgmtTuples",$_GET["DeleteFullMgmt"]);
   }
   $MgmtEntries = GetParameter("Snmp.SnmpMgmtTuples");

?>

   
   <font class="pageheading">Access Configuration</font><BR><BR>
      
      
   <!-- SHOW CURRENT MGMT Entries -->
   <TABLE BGCOLOR=\"#FF0000\" >


      <TR>
      <TH>ID</TH><TH>Community String</TH><TH>Management Station IP</TH>
      <TH>IP Bit Mask</TH><TH></TH>
      </TR>

      <!-- BEGIN FULL Mgmt Entry RENDERING -->

      <?
         $EntryNum = 0;
         $DivBegin = "";
         $DivEnd = "";
         foreach ($MgmtEntries as $Dest)
         {
      ?>
         <TR>
         <TD>
            <?echo $EntryNum+1; ?>
         </TD>
         <TD>
            <?echo $Dest["Community"]; ?>
         </TD>
         <TD>
            <?echo $Dest["IpAddr"]["Dotted"]?>
         </TD>
         <TD>
            <?echo $Dest["IpMask"]?>
         </TD>
         <form name='DeleteFullMgmt'>
         <TD> <? echo $DivBegin ?>
            <INPUT type='hidden' name='DeleteFullMgmt' Value='<?=$EntryNum?>'>
            <INPUT type='submit' value=Delete>
         </TD>
         </form>
         </TD>
         </TR>
      <? $EntryNum++;
         }
      ?>
      <FORM name="SnmpConfigForm" action="snmp.php">
         <INPUT type="hidden" name="Action" value="AddMgmt">

         <TR>
            <TD></TD>
            <TD>
               <INPUT type="text" name="Community" maxlength=32>
            </TD>

            <TD>
               <INPUT type="text" name="IpAddr" maxlength=15 size=15>
            </TD>

            <TD align=left>

               <?
                  $ipMask = array('32', '28', '24', '20', '16', '12', '8', '4', '0');
                  echo HTML_FORM::AddDropdown("IpMask", $ipMask, $ipMask, 0);
               ?>
            </TD>
            <TD>
               <INPUT type="Submit" name="AddMgmtEntry" value="Add" type="Get">
            </TD>
         </TR>
      </FORM>
      </TABLE>
      
      <BR>
      <DIV class=helptext>
         <IMG src='./images/icon-info.gif'>&nbsp;
         SNMP management table is used to specify the SNMP management stations
         that would like to manage this appliance. Current support is READ-ONLY.
      </DIV>

<?
   function AddEntry($Which) {
      $Entries = GetParameter($Which);
      foreach ($Entries as $p) {
         if ($p["Name"] == $_GET["Name"]) {
            echo "<BR><H2><I>Addition ignored, Duplicate Name " . $_GET["Name"] . "</I></H2> <BR>";
            return;
         }
      }
      if (strpos($_GET["Name"], " ") !== false) {
         echo "<BR><H2><I>Addition ignored, Name cannot include Spaces: [" . $_GET["Name"] . "]</I></H2> <BR>";
         return;
      }
      $P["Name"] = $_GET["Name"];
      $P["TargetAddr"]["Dotted"] = $_GET["TargetAddr"];
      $P["TargetAddr"]["Port"]   = $_GET["TargetAddrPort"];
      $P["SnmpVersion"] = $_GET["SnmpVersion"];
      $P["TrapCommunity"] = $_GET["TrapCommunity"];
      $P["TrapType"] = $_GET["TrapType"];
      $Entries[sizeof($Entries)] = $P;
      SetParameterAsXML($Which,$Entries);
   }

   if (isset($_GET["Action"])) {
      if ($_GET["Action"] == "Add") {
         AddEntry("Snmp.TrapDestTuples");
      }
   }
   $TrapDestinations = GetParameter("Snmp.TrapDestTuples");

?>

   <BR><BR><font class="pageheading">Trap Destinations</font><BR><BR>


   <!-- SHOW CURRENT TRAP DESTINATIONS -->
   <TABLE BGCOLOR=\"#FF0000\" >


      <TR>
      <TH>ID</TH><TH>Name</TH><TH>Dest IP</TH><TH>Dest Port</TH>
      <TH>Version</TH><TH>Trap Community</TH>
      <TH>Type</TH><TH></TH>
      </TR>

      <!-- BEGIN FULL Trap Destination RENDERING -->

      <?
         $EntryNum = 0;
         foreach ($TrapDestinations as $Dest)
         {
            if (array_key_exists("Status",$Dest)) {
                $DivBegin = "<DIV STYLE=\"background: orange\">";
                $DivEnd = "</DIV>";
            } else {
               $DivBegin = "";
               $DivEnd = "";
            }
      ?>
         <TR>
         <TD> <? echo $DivBegin ?>
            <?echo $EntryNum+1; ?>
         <? echo $DivEnd ?>
         </TD>
         <TD> <? echo $DivBegin ?>
            <?echo $Dest["Name"] ?>
         <? echo $DivEnd ?>
         </TD>
         <TD> <? echo $DivBegin ?>
            <?echo $Dest["TargetAddr"]["Dotted"]?>
         <? echo $DivEnd ?>
         </TD>
         <TD> <? echo $DivBegin ?>
            <?echo $Dest["TargetAddr"]["Port"]?>
         <? echo $DivEnd ?>
         </TD>
         <TD> <? echo $DivBegin ?>
            <?echo $Dest["SnmpVersion"]?>
         <? echo $DivEnd ?>
         </TD>
         <TD> <? echo $DivBegin ?>
            <?echo $Dest["TrapCommunity"]?>
         <? echo $DivEnd ?>
         </TD>
         <TD> <? echo $DivBegin ?>
            <?echo $Dest["TrapType"]?>
         <? echo $DivEnd ?>
         </TD>
         <form name='DeleteFull'>
         <TD> <? echo $DivBegin ?>
            <INPUT type='hidden' name='DeleteFull' Value='<?=$EntryNum?>'>
            <INPUT type='submit' value=Delete>
            <? if (array_key_exists("Status",$Dest)) {
                echo " ERROR: " . $Dest["Status"];
               }
            ?>
         <? echo $DivEnd ?>
         </TD>
         </form>
         <? echo $DivEnd ?>
         </TD>
         </TR>
      <? $EntryNum++;
         }
      ?>
      <FORM name="SnmpConfigForm" action="snmp.php">
         <INPUT type="hidden" name="Action" value="Add">

         <TR>
            <TD></TD>
            <TD>
               <INPUT type="text" name="Name" maxlength=32 size=15>
            </TD>

            <TD>
               <INPUT type="text" name="TargetAddr" maxlength=15 size=13>
            </TD>

            <TD>
               <INPUT type="text" name="TargetAddrPort" maxlength=4 size=4>
            </TD>

            <TD align=left>

               <?
                  $snmpVals = array('v1', 'v2c');
                  echo HTML_FORM::AddDropdown("SnmpVersion", $snmpVals, $snmpVals, 0);
               ?>
            </TD>

            <TD>
               <INPUT type="text" name="TrapCommunity" maxlength=32 size=10>
            </TD>

            <TD align=left>

               <?
                  $snmpVals = array('trap');
                  echo HTML_FORM::AddDropdown("TrapType", $snmpVals, $snmpVals, 0);
               ?>
            </TD>

            <TD>
               <INPUT type="Submit" name="AddEntry" value="Add" type="Get">
            </TD>
         </TR>
      </FORM>
      </TABLE>

      <BR>
      <DIV class=helptext>
         <IMG src='./images/icon-info.gif'>&nbsp;
         SNMP trap destinations are used to specify the SNMP management stations
         that would like to receive traps from this appliance.
      </DIV><BR><BR>

<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>

