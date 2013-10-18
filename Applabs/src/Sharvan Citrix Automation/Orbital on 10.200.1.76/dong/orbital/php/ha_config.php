<?
   define('PAGE_REQUIRES_HA_SUPPORTED', true);
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>
<Script>

<!--
   function confirmSubmit()
   {
      if (!confirm("Are you sure you wish to change the high availability settings?  This will terminate all existing connections.")) {
        return;
      }

      var subform=document.UpdateHaConfiguration;
      subform.submit();
   }
// -->
</Script>

<?
if (isset($_GET["HaVmip"])) {

   $SslClientName = GetSystemParam("SslClientName");
   if ($SslClientName == ""){
      ThrowException("You don't have a correctly configured SSL certificate. HA can not be enabled until you do.", true);
      echo "SSL Name: $SslClientName";
   }


   if ( ($_GET["HaVmip"] != "") && ($_GET["HaVrid"] != "") && ($_GET["HaPartner"] != "") &&
        ($SslClientName != "") || (!isset($_GET["HaEnabled"])) )
   {   
      $Param["Class"] = "SYSTEM";
      $Param["Attribute"]["HaParameters"]["Enabled"] = isset($_GET["HaEnabled"]) && ($_GET["HaEnabled"] == 1);
      $Param["Attribute"]["HaParameters"]["Vmip"]["Dotted"] = $_GET["HaVmip"];
      $Param["Attribute"]["HaParameters"]["Vrid"] = $_GET["HaVrid"];
      $Param["Attribute"]["HaParameters"]["Partner"] = $_GET["HaPartner"];
   
      $Results = 0;
   
      $Results = xu_rpc_http_concise(
                                     array(
                                          'method'    => "Set",
                                          'args'      => $Param,                 
                                          'host'      => RPC_SERVER,
                                          'uri'       => RPC_URI,
                                          'port'      => RPC_PORT
                                          ));
   }else{
      ThrowException("All HA settings were not configured. Please press back to complete the configuration", true);
   }
}

$Param["Class"] = "SYSTEM";
$Param["Attribute"] = array("HaParameters", "SslClientName");
$HaParameters = xu_rpc_http_concise(
                                    array(
                                          'method' => "Get",
                                          'args' => array($Param),
                                          'host' => RPC_SERVER,
                                          'uri'  => RPC_URI,
                                          'port' => RPC_PORT
                                          ));

$HaEnabled     = $HaParameters["HaParameters"]["Enabled"];
$HaVmip        =    $HaParameters["HaParameters"]["Vmip"]["Dotted"];
$HaVrid        =    $HaParameters["HaParameters"]["Vrid"];
$HaPartner     =    $HaParameters["HaParameters"]["Partner"];
$SslClientName = $HaParameters["SslClientName"];
?>

<?
if (!$HaSupported) {
   echo "<DIV class=giant_warning>\n";
   echo "<TABLE width=100%>\n";
   echo "<TR><TD>\n";
   echo "This unit does not support High Availability";
   echo "</TD></TR>\n";
   echo "</TABLE>\n";
   echo "</DIV>\n";
   echo "<BR>\n";           

}

?>

<font class="pageheading">Configure Settings: High Availability</font><BR><BR>
<div class="settings_table">
    <form name="UpdateHaConfiguration">
      <table>
        <tr>
          <th>
            Enabled:
          </th>
          <td>
            <input name="HaEnabled" type="checkbox" <?if ($HaEnabled) echo "checked"?> value="1">
          </td>
        </tr>
        
        <tr>
          <th>
            High Availabilty Status:
          </th>
          <td>
            <FONT color="blue" size="+1">
            <?=strtoupper($HaState); ?>
            </FONT>
          </td>
        </tr>        

        <tr>
          <th>
            SSL Common Name (From License File):
          </th>
          <td>
            <?=$SslClientName; ?></B>
          </td>
        </tr>        

        <tr>
          <th>
            Virtual Management IP Address:
          </th>
          <td>
            <input name="HaVmip" type="text" value="<?=$HaVmip?>">
          </td>
        </tr>
        <tr>
          <th>
            VRRP VRID:
          </th>
          <td>
            <input name="HaVrid" type="text" value="<?=$HaVrid?>">
          </td>
        </tr>
        <tr>
          <th>
            High Availabilty Partner Serial Number:
          </th>
          <td>
            <input name="HaPartner" type="text" value="<?=$HaPartner?>">
          </td>
        </tr>
        <tr>
          <th>
          </th>
          <td>
            <input name="HaUpdateSettings" type="button" value="Update" onClick="confirmSubmit()">
          </td>
        </tr>
      </table>
    </form>
</div>
      <BR>
      <DIV class=helptext>
         <IMG src='./images/icon-info.gif'>&nbsp;
         NOTE: All High Availability specific modification of settings must be made 
         on both the primary and the secondary. Most other settings will be synchronized automatically.
      </DIV>

<BR><BR>
<font class="pageheading">Status: High Availability Partner</font><BR><BR>
<? 
   switch($HaState) {
      case 'standalone':
         echo "This unit is not currently part of a high availability pair.";
         break;

      case 'primary':
         $HaSecondaryHostSerialNumber = GetSystemParam("HaSecondaryHostSerialNumber");
         $HaSecondaryHostIpAddress = GetSystemParam("HaSecondaryHostIpAddress");
         $HaSecondaryHostIpAddressDotted = $HaSecondaryHostIpAddress["Dotted"];
         $HaSecondaryExists = GetSystemParam("HaSecondaryHostExists");

         if (!$HaSecondaryExists) {
            echo "A valid Secondary Box does not currently exist.";
         } else {
   ?>
 The current Secondary Box is:
 
    <table>
      <tr>
        <th>Serial Number:</th>
        <td><? echo $HaSecondaryHostSerialNumber ?></th>
      </tr>

      <tr>
        <th>IP Address:</th>
        <td><? echo $HaSecondaryHostIpAddressDotted ?></th>
      </tr>
    </table>
    <? }
        break;

     case 'secondary':
        echo "This unit is currently serving as high availability secondary."; 
        break;

     case 'restarting':
        echo "This unit is currently restarting high availability function.";
        break;

     case 'starting':
        echo "This unit is cuurently starting high availability function.";
        break;

     case 'invalid':
        echo "This unit is in an invalid high availability state.  Please review alerts.";
        break;
   } ?>

<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
