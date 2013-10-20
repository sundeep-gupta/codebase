<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
   define('DONT_REQUIRE_RUNNING_SERVER', true);
?>

<font class="pageheading">System Tools: Update License</font><BR><BR>

<!-- SEE IF THE USER JUST PRESSED THE "Upgrade License" BUTTON -->
<?
   $LicenseFileValid = true;
   $ShowAStatusMessage = "";

   function RereadLicense(){
      xu_rpc_http_concise(
                  array(
                     'method' => "RereadLicenseFile",
                     'host'      => RPC_SERVER,
                     'uri'    => RPC_URI,
                     'port'      => RPC_PORT
                  ) );
   }

   function UnescapePost($PostVal){
      if (get_magic_quotes_gpc())
      {
         return stripslashes($PostVal);
      }else return $PostVal;
   }

   function OpenFileName($BaseName,$Access,$Required = false) {
      if (substr(php_uname(), 0, 7) != "Windows") {
         $File = fopen(ORBITAL_BINARY_DIR. $BaseName,$Access);
         if ($File) return $File;
      } else {
         $File = @fopen("..\\".$BaseName,$Access);
         if ($File) return $File;
      }
      if ($Required) {
         ThrowException("Couldn't Open License File",false);
      }
      return $File;
   }

   if (isset($_GET["DeletePrimaryLicense"])){
      if (MSG_BOX::Ask("Delete Primary License?", "Are you sure you wish to delete this license?") == MSG_BOX_YES){
         if ($File = OpenFileName("PermanentLimits.txt", "w")){//write an empty file
            fclose($File);
            RereadLicense();
            echo HTML::InsertRedirect("license.php", 0);
         }else{ThrowException("Couldn't delete license file!");}
      }else{
         echo HTML::InsertRedirect("license.php", 0);
      }
   }
   else if (isset($_GET["DeleteSecondaryLicense"])){
      if (MSG_BOX::Ask("Delete Secondary License?", "Are you sure you wish to delete this license?") == MSG_BOX_YES){
         if ($File = OpenFileName("Limits.txt", "w")){ //write an empty file
            fclose($File);
            RereadLicense();
            echo HTML::InsertRedirect("license.php", 0);
         }else{ThrowException("Couldn't delete license file!");}
      }else{
         echo HTML::InsertRedirect("license.php", 0);
      }
   }
   else if (isset($_POST["limits_primary"])) {
         $LimitsPrimary = UnescapePost( $_POST["limits_primary"] );
         $LicenseParam["PrimaryLicense"] = $LimitsPrimary;
         $Result = OrbitalSet("LIMIT", $LicenseParam);
         if ($Result["Success"] == false){
            ThrowException("Primary License File Was Bad (" . $Result["Status"] .")!" );
         }else{
            $ShowAStatusMessage = "Primary License Saved";
            echo HTML::InsertRedirect("license.php", 8);
         }
   }
   else if (isset($_POST["limits_secondary"])) {
      $LimitsSecondary = UnescapePost( $_POST["limits_secondary"] );

      if ($LimitsSecondary != "") {
         $LicenseParam["SecondaryLicense"] = $LimitsSecondary;
         $Result = OrbitalSet("LIMIT", $LicenseParam);
         if ($Result["Success"] == false){
            ThrowException("Secondary License File Was Bad (" . $Result["Status"] .")!" );
         }else
         {
            $ShowAStatusMessage = "Secondary License Saved";
            echo HTML::InsertRedirect("license.php", 8);
         }
      }
   }

   if ($ShowAStatusMessage != "") ShowStatusMessage($ShowAStatusMessage);

   $LimitsPrimary = "";
   $LimitsSecondary = "";

   // Now attempt to load the Limits files
   if ($limitshandle_primary = OpenFileName("PermanentLimits.txt", "rt")) {
      $LimitsPrimary = fread($limitshandle_primary, 5000);
   }

   if ($limitshandle_secondary = OpenFileName("Limits.txt", "rt")) {
      $LimitsSecondary = fread($limitshandle_secondary, 5000);
   }

?>

<?

   if (IsServerRunning() && $LicenseFileValid)
   {
      echo("<div class=\"settings_table\">");
      echo("<TABLE width=450");

      $CurLimits = OrbitalGet("LIMIT");
      function DoLimitRow($Label,$Value) {
         echo "<TR> <TH> " . $Label . " </TH><TD> " . $Value . " </TD>";
      }
      function DoLimitArray($Label,$CurLimits,$Member,$Empty) {
         $Ary = $CurLimits[$Member];
         if (sizeof($Ary) == 0) {
            DoLimitRow($Label,$Empty);
         } else if (sizeof($Ary) == 1) {
            DoLimitRow($Label,$Ary[0]);
         } else {
            $Line = $Ary[0];
            for ($i = 1; $i < sizeof($Ary); ++$i) {
               $Line = $Line . ", " . $Ary[$i];
            }
            DoLimitRow($Label,$Line);
         }
      }
      $Macs = OrbitalGet("ADAPTER", array("MacAddress"));
      $Eth0Mac = $Macs[0]["MacAddress"];
      DoLimitRow("Eth0 Mac:", $Eth0Mac);

      DoLimitRow("Serial Number:", $CurLimits["SERIALNUMBER"]);
      $Rate = $CurLimits["MAXSENDRATE"];
      DoLimitRow("Maximum Send Rate:", $LicenseFileValid ? FormatThroughput($Rate) : "Invalid License" );
      DoLimitRow("Maximum Accelerated Connections:",$CurLimits["MAXCONNECTIONS"]);

      DoLimitArray("Allowed TCP Ports for Acceleration:",$CurLimits,"ALLOWEDPORTS","All");
      DoLimitArray("Allowed MAC Addresses:",$CurLimits,"ETHERADDRESSES","All");
      if ($CurLimits["MAXFASTFLOWS"] != -1) {
         DoLimitRow("Maximum Connection Addresses:",$CurLimits["MAXFASTFLOWS"]);
      }
      if ($CifsSupported){
         DoLimitRow("CIFS Pipelining:",($CurLimits["CIFS"] ? "Enabled" : "Disabled"));
      }
      if ($CompressionSupported) {
         DoLimitRow("Compression",($CurLimits["COMPRESSION"] ? "Enabled" : "Disabled"));
      }
      DoLimitRow("Expiration Date:", FormatDate($CurLimits["EXPIRATIONDATE"]));
      echo "</table>";
      echo "</div>";
   }
   $Status = OrbitalGet("SYSTEM",array("PrimaryLicenseFileStatus","SecondaryLicenseFileStatus"));

   function ShowStatus($Status) {
      if ($Status == "Active") return "(Status: Active)";
      if ($Status == "Inactive") return "(Status: Valid, but Inactive)";
      if ($Status == "Missing") return " (None)";
      return "<font color=red> (" . $Status . ")</font>";
   }
?>

<!-- DISPLAY THE BOXES WITH THE CURRENT LICENSE KEY -->
<BR><BR>
   <TABLE>
      <TR><TH colspan=2>
         Primary License Key <?=ShowStatus($Status["PrimaryLicenseFileStatus"])?>
      </Th></TR>
      <FORM method="post" name="UpdatePrimaryLicense">
      <TR><TD colspan=2>
         <textarea name="limits_primary" type="textarea" rows=7 cols=66 wrap=on><?=$LimitsPrimary?></textarea>
      </TD></TR>
      <TR>
      <TH>
         <input type="button" name="UpgradePrimary"
                onClick="if (confirm('Update License: doing this will kill all accelerated connections?', 'Update License') ) { document.UpdatePrimaryLicense.submit();}"
                value="Upgrade Primary License">
         </input>
         </FORM>
      </TH>
      <TH>
         <FORM>
            <input type="submit" name="DeletePrimaryLicense" value="Delete Primary License"></input>
         </FORM>
      </TH>
      </TR>
   </TABLE>
   <BR>

   <TABLE>
      <FORM method="post" name="UpdateSecondaryLicense">
      <TR><TH colspan=2>
         Secondary License Key <?=ShowStatus($Status["SecondaryLicenseFileStatus"])?>
      </TH></TR>
      <TR><TD colspan=2>
         <textarea name="limits_secondary" type="textarea" rows=7 cols=66 wrap=on><?=$LimitsSecondary?></textarea>
      </TD></TR>
      <TR><TH>
         <input type="submit" name="UpgradeSecondary"
                onClick="if (confirm('Update License: doing this will kill all accelerated connections?', 'Update License') ) { document.UpdateSecondaryLicense.submit();}"
                value="Upgrade Secondary License"></input>
         </FORM>
      </TH><TH>
         <FORM>
            <input type="submit" name="DeleteSecondaryLicense" value="Delete Secondary License"></input>
         </FORM>
      </TH>
      </TR>
      </FORM>

   </TABLE>

</FORM>

<TABLE>

<?include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
