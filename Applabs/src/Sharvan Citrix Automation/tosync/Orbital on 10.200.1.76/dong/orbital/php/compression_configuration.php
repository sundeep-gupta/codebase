<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>


<font class="pageheading">Configure Settings: Compression</font><BR><BR>

<?
	if ( (isset($_GET["DisableCompression"])) || (isset($_GET["EnableCompression"]) ) )
	{
		$Auth->CheckRights(AUTH_LEVEL_ADMIN);

		if ( isset($_GET["DisableCompression"]) ) { SetParameter("Compression.EnableCompression", false); }
		if ( isset($_GET["EnableCompression"] ) )  { SetParameter("Compression.EnableCompression", true); }

		echo HTML::InsertRedirect("./compression_configuration.php", 0);
	}
	$CompressionEnabled = GetParameter("Compression.EnableCompression");


	//
	// Get the acceleration by ip mode
	$AccelIPs = GetParameter("Compression.AcceleratedIPs");
	if (isset($_GET["CompressionAccelIPsMode"])){
		$AccelMode = (int)$_GET["CompressionAccelIPsMode"];

		if ($AccelMode == 1){
			if (sizeof ($AccelIPs)>0 && MSG_BOX::Ask("Question?", "Are you sure you wish to clear all IP/Mask acceleration entries?") == MSG_BOX_YES){
				SetParameter("Compression.AcceleratedIPs", array() );
            SetParameter("Compression.OnlyAccelIPsOnList", false);
				$AccelIPs = array();
			}
		}elseif (sizeof($AccelIPs) > 0) {
			SetParameter("Compression.OnlyAccelIPsOnList", $AccelMode==2);
		}
		echo HTML::InsertRedirect("compression_configuration.php", 0);
	}


	if (isset($_GET["ResetTotals"])) {
		$Result = xu_rpc_http_concise(
							array(
								'method' => "ResetPerfCounters",
								'args'   => array(),
								'host'      => RPC_SERVER,
								'uri'    => RPC_URI,
								'port'      => RPC_PORT
							)
		);
		echo HTML::InsertRedirect("./compression_configuration.php",0);
		exit();
	}

?>

<div class="settings_table">
<TABLE>
   <!-- Compressed/Uncompressed Ports -->
   <TR>
   <TH>
      Compression Status:
   </TH>
   <TD>
      <DIV class="no_bg_color">
      <FORM name="CompressionEnable">

      <? if (GetParameter("Compression.EnableCompression"))
         { ?>
            <FONT color="blue" size="+1">ENABLED</FONT>&nbsp;&nbsp;
            <INPUT type="submit" name="DisableCompression" value="Disable"></INPUT>
      <? }
         else
         {?>
            <FONT color="red" size="+1">DISABLED</FONT>&nbsp;&nbsp;
            <INPUT type="submit" name="EnableCompression" value="Enable">
      <? } ?>
      </FORM>
      </DIV class="no_bg_color">
   </TD>
   </TR>

   <!-- Compressed/Uncompressed Ports -->
   <TR>
   <TH>
      Compressed Ports:
   </TH>
   <TD>
   <?
      $FieldNames = array("Compress All Ports",
                          "Compress Only the Above Ports",
                          "Compress Everything But the Above Ports");
      $Table = new HTML_TABLE();
      $ParamForm = new HTML_PARAMETER_FORM();
      echo
         "<DIV class=\"no_bg_color\">",
         $Table->Begin(),
         $ParamForm->Begin("CompressedPorts"),

         $Table->AddEntry2($ParamForm->AddPortListParam("Compression.CompressablePorts", $FieldNames)),
         $Table->AddEntry("", $ParamForm->AddSubmit() ),
         $ParamForm->End(),
         $Table->End(),
         "<DIV class=\"no_bg_color\">";
   ?>
   </TD>
   </TR>

   <!-- Compressed/Compressed IPs -->
   <TR>
   <TH>
      Compressed IPs:
   </TH>
   <TD>
   <?

      if (isset($_GET["FormName"]) && $_GET["FormName"]=="AcceleratedIPs"){
         if (isset($_GET["Add"])){
            $NewIPMask["Display"] = $_GET["NewIPMask"];
            array_push($AccelIPs, $NewIPMask);
         }
         else if (isset($_GET["Delete"])){
            $IPMaskToDelete = $_GET["AccelIPs"];

            $NewResults = array();
            foreach ($AccelIPs as $IPMask){
               if ($IPMask["Display"] != $IPMaskToDelete){
                  array_push($NewResults, $IPMask);
               }
            }
            $AccelIPs = $NewResults;
         }

         SetParameter("Compression.AcceleratedIPs", $AccelIPs);
         if (sizeof($AccelIPs) == 0){
            SetParameter("Compression.OnlyAccelIPsOnList", false);
         }
      }

      $AccelItems = array();
      foreach ($AccelIPs as $IPMask){
         array_push($AccelItems, $IPMask["Display"]);
      }

      if (sizeof($AccelItems)==0){
         $AccelMode = 1;
      }else{
         $AccelMode = (GetParameter("Compression.OnlyAccelIPsOnList")?2:3);
      }
      if (sizeof($AccelItems) == 0){ array_push($AccelItems, "NONE CONFIGURED"); }

      $Table = new HTML_TABLE();
      $Form = new HTML_FORM();
      echo
         "<DIV class=\"no_bg_color\">",
         "<TABLE>",
         $Form->Begin("AcceleratedIPs"),
         "<TR>",
            "<TD>New IP:</TD>" ,
            "<TD>", $Form->AddTextField("NewIPMask", "", 12) . "<BR>Example: 192.168.1.0/24</TD>",
            "<TD>", $Form->AddSubmit("Add","Add") .
         "</TR>",
         "<TR>",
            "<TD>Current IPs:</TD>" ,
            "<TD>", $Form->AddList("AccelIPs", $AccelItems, 6) . "</TD>",
            "<TD align=left>", $Form->AddSubmit("Delete","Delete") . "</TD>",
         "</TR>",
         "<TR>",
            "<TD>Mode:</TD>" ,
            "<TD colspan=2>", $Form->AddRadioButton("CompressionAccelIPsMode", "1", $AccelMode==1) . "Compress All Traffic<BR>" .
                    $Form->AddRadioButton("CompressionAccelIPsMode", "2", $AccelMode==2) . "Only Traffic With a Source or Destination IP Listed Above<BR>" .
                    $Form->AddRadioButton("CompressionAccelIPsMode", "3", $AccelMode==3) . "Never Compress Traffic With a Source or Destination IP Listed Above<BR>" .
            "<TD></TD>",
         "</TR>",
         "<TR>",
            "<TD></TD>" ,
            "<TD align=left>", $Form->AddSubmit("ChangeMode","Change Mode") . "</TD>",
            "<TD></TD>",
         "</TR>",
         $Form->End(),
         "</TABLE>",
         "</DIV>";
   ?>
   </TD>
   </TR>

   <!-- Clear History -->
   <TR>
   <TH>
      Clear Statistics:
   </TH>
   <TD>
		<FORM name="ResetTotals">
         Click Here To Clear Compression Statistics:
			<INPUT type="submit" name="ResetTotals" value="Clear"></INPUT>
		</FORM>
   </TD>
   </TR>

</TABLE>
</div>
<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
