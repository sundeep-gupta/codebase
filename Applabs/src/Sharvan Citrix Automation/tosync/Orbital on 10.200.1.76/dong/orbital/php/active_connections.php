<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_VIEWER);
?>

<font class="pageheading">Monitoring: Active Connections</font><BR><BR>

<!-- THIS IS THE MAIN SETTINGS BLOCK -->
<TABLE  class="width550" cellspacing="1">



<?
   // Change whether to show Accel or Unaccel connections
   if (isset($_GET["AccelUnaccel"])) {
      SetParameter("UI.ConnList.ShowAccelConnections", $_GET["AccelUnaccel"] == 0);
   }
   $OnlyOrbitalConnections = GetParameter("UI.ConnList.ShowAccelConnections");;


   // DISPLAY THE CONNECTION LIST
   $ParamForm = new HTML_PARAMETER_FORM();
   echo $ParamForm->Begin("UIConnListFilter");
?>
   <TABLE width=100%>
      <TR><TH colspan=6>Filter Connection List By...</TH></TR>

      <TH>
      <DIV class=no_formatting_grey>
      <TABLE>
      <TR><TH>Source IP and </TR></TH>
      <TR><TH>Port Range  </TR></TH>
      </TABLE>
      </DIV>
      </TH>

      <TH>
      <DIV class=no_formatting_grey>
      <TABLE>
      <TR><TH>Destination IP and </TR></TH>
      <TR><TH>Port Range  </TR></TH>
      </TABLE>
      </DIV>
      </TH>

      <TH>Duration</TH><TH>Bytes Transfered</TH><TH></TH></TR>
      <TR>
      <TD>
            <DIV class=no_formatting>
            <TABLE>
               <TR><TD colspan=2> <?=$ParamForm->AddTextParam("UI.ConnList.SourceIP", 13);?>:</TD></TR>
               <TR>
                  <TD><?=$ParamForm->AddTextParam("UI.ConnList.SourcePort.Start", 3);?>-</TD>
                  <TD><?=$ParamForm->AddTextParam("UI.ConnList.SourcePort.End", 3);?></TD>
               </TR>
             </TABLE>
             </DIV>
      <TD>
            <DIV class=no_formatting>
            <TABLE>
               <TR><TD colspan=2> <?=$ParamForm->AddTextParam("UI.ConnList.DestIP", 13);?>:</TD></TR>
               <TR>
                  <TD><?=$ParamForm->AddTextParam("UI.ConnList.DestPort.Start", 3);?>-</TD>
                  <TD><?=$ParamForm->AddTextParam("UI.ConnList.DestPort.End", 3);?></TD>
               </TR>
             </TABLE>
             </DIV>
      </TD>

      <TD>At Least <?=$ParamForm->AddTextParam("UI.ConnList.Duration", 3);?>sec</TD>
      <TD>At Least <?=$ParamForm->AddTextParam("UI.ConnList.BytesXfered", 4); ?>Bytes</TD>
      <TD><?=$ParamForm->AddSubmit("UIConnListFilter", "Update")?></TD>
      </TR>
   </TABLE>
<?
   echo
      $ParamForm->End();
?>

<?
   $DisplayNextPrevLinks = false;

   //
   // Now see if we need to filter the connection list...
   //
   $FilterSourceIP        = GetParameter("UI.ConnList.SourceIP");
   $FilterSourcePortStart = GetParameter("UI.ConnList.SourcePort.Start");
   $FilterSourcePortEnd   = GetParameter("UI.ConnList.SourcePort.End");
   $FilterDestIP          = GetParameter("UI.ConnList.DestIP");
   $FilterDestPortStart   = GetParameter("UI.ConnList.DestPort.Start");
   $FilterDestPortEnd     = GetParameter("UI.ConnList.DestPort.End");
   $FilterDuration        = GetParameter("UI.ConnList.Duration");
   $FilterXfered          = GetParameter("UI.ConnList.BytesXfered");
   $FilteringPerformed    = false;

   if ( ($FilterSourceIP || $FilterSourcePortStart || $FilterDestIP || $FilterDestPortStart ||
         $FilterDuration || $FilterXfered) && ($OnlyOrbitalConnections) ) {
      $FilteringPerformed = true;
      if ($OnlyOrbitalConnections){
         $CLA = &$Param["Filter"]["ClientLogicalAddress"];
      }else{
         $CLA = &$Param["Filter"]["Address"]["Src"];
      }

      if ($FilterSourceIP != ""){
         $CLA["Range"]["Left"]["Dotted"] = $FilterSourceIP;
         $CLA["Range"]["Right"]["Dotted"] = $FilterSourceIP;
      }else{
         $CLA["Range"]["Left"]["Dotted"] = "0.0.0.0";
         $CLA["Range"]["Right"]["Dotted"] = "255.255.255.255";
      }

      if ($FilterSourcePortStart != ""){
         $CLA["Range"]["Left"]["Port"] = (int)$FilterSourcePortStart;
         $CLA["Range"]["Right"]["Port"] = (int)$FilterSourcePortEnd;
      }else{
         $CLA["Range"]["Left"]["Port"] = 0;
         $CLA["Range"]["Right"]["Port"] = 65535;
      }
      if ($OnlyOrbitalConnections){
         $SLA = &$Param["Filter"]["ServerLogicalAddress"];
      }else{
         $SLA = &$Param["Filter"]["Address"]["Dst"];
      }

      if ($FilterDestIP != ""){
         $SLA["Range"]["Left"]["Dotted"] = $FilterDestIP;
         $SLA["Range"]["Right"]["Dotted"] = $FilterDestIP;
      }else{
         $SLA["Range"]["Left"]["Dotted"] = "0.0.0.0";
         $SLA["Range"]["Right"]["Dotted"] = "255.255.255.255";
      }

      if ($FilterDestPortStart != ""){
         $SLA["Range"]["Left"]["Port"] = (int)$FilterDestPortStart;
         $SLA["Range"]["Right"]["Port"] = (int)$FilterDestPortEnd;
      }else{
         $SLA["Range"]["Left"]["Port"] = 0;
         $SLA["Range"]["Right"]["Port"] = 65535;
      }

      if ($FilterXfered != ""){
         $Param["Filter"]["BytesTransferred"]["Value"] = $FilterXfered;
         $Param["Filter"]["BytesTransferred"]["Modifier"] = "gt";
      }

      if ($FilterDuration != ""){
         $Param["Filter"]["Duration"]["Value"] = (int)$FilterDuration;
         $Param["Filter"]["Duration"]["Modifier"] = "gt";
      }
   }

   //
   // Get the number of connections
   //
   $Param["Class"] = $OnlyOrbitalConnections ? "CONNECTION" : "NORB_CONNECTION";
   $Param["Count"] = 0;
   $Param["InstanceCount"] = 0;
   $Param["FirstInstance"] = 0;
   $Instances = xu_rpc_http_concise(
                  array(
                     'method' => "GetInstances",
                     'args'      => $Param,
                     'host'      => RPC_SERVER,
                     'uri'    => RPC_URI,
                     'port'      => RPC_PORT
                  )
   );
   $NumConnections = $Instances["Count"];
   //
   // Make sure we only return CONN_PER_PAGE connections at a time..
   //
   $Param["Class"]         = $OnlyOrbitalConnections ? "CONNECTION" : "NORB_CONNECTION";
   $Param["Count"]         = GetParameter("UI.ConnList.ConnectionsShown");
   if ($OnlyOrbitalConnections){
      $Param["Attribute"] = array("ClientLogicalAddress", "ClientPhysicalAddress",
                           "ServerLogicalAddress", "ServerPhysicalAddress",
                           "Duration", "InstanceNumber", "BytesTransferred", "IdleTime",
                           "Accelerated", "Agent", "IsCompressed", "CompressionRatio");
   }

   $Result = xu_rpc_http_concise(
                  array(
                     'method' => "Get",
                     'args'      => $Param,
                     'host'      => RPC_SERVER,
                     'uri'    => RPC_URI,
                     'port'      => RPC_PORT
                  )
   );
   //var_dumper($Result);
?>
   <BR><BR>
   <TABLE width=100%>
      <TR><TH colspan=8>
         <FORM name=ShowAccelUnaccel>
            <input type=radio name=AccelUnaccel value="0"
                  onClick="document.ShowAccelUnaccel.submit()"
                  <?=$OnlyOrbitalConnections?'checked':'';?>  >
               Show Accelerated Connections

            <input type=radio name=AccelUnaccel value="1"
                  onClick="document.ShowAccelUnaccel.submit()"
                  <?=!$OnlyOrbitalConnections?'checked':'';?>  >
               Show Unaccelerated Connections
         </FORM>
      </TH></TR>

<? if ($NumConnections != 0) { ?>

      <TR><TH colspan=8><?=$NumConnections?> <?=($OnlyOrbitalConnections?"Accelerated":"Unaccelerated")?> Connections</TH></TR>
   </TABLE>

	<TABLE class="sortable" id="sortedconnections">
      <TR>
         <TH>Details</TH>
         <TH>Initiator</TH>
         <TH></TH>
         <TH>Responder</TH>
         <TH>Duration</TH>
         <TH>Idle</TH>
         <TH>Bytes Xfered</TH>
         <TH>Compression Ratio</TH>
         <TH><?=ProdName()?> Partner</TH>
      </TR>
<? }else{
      echo "<TR><TH>0 Accelerated Connections</TH></TR>";
   }
?>
<?
   function SortIt($a,$b) {
      if ($a["IdleTime"] == $b["IdleTime"]) return 0;
      return $a["IdleTime"] > $b["IdleTime"] ? 1 : -1;
   }
   usort($Result,"SortIt");
   foreach ($Result as $OneConnection)
   {
      if ($OnlyOrbitalConnections){
         $ClientAddress = FormatIPAddressPort($OneConnection["ClientLogicalAddress"]);
         $ServerAddress = FormatIPAddressPort($OneConnection["ServerLogicalAddress"]);
         $BytesTransferred = $OneConnection["BytesTransferred"];

         if ($OneConnection["IsCompressed"]){
         	$CompressionRatio = number_format($OneConnection["CompressionRatio"], 1) . " to 1";
         }else{
         	$CompressionRatio = "N/A";
         }

         if ($OneConnection["Agent"]["Accelerated"]) {
            $Agent = FormatAgent($OneConnection["Agent"]);
         } else {
            $Agent = "<i>None</i>";
         }
         $Duration       = (int)$OneConnection["Duration"] . "&nbsp;sec";
         $InstanceNumber = $OneConnection["InstanceNumber"];
      }else{
         $ClientAddress = FormatIPAddressPort($OneConnection["Address"]["Src"]);
         $ServerAddress = FormatIPAddressPort($OneConnection["Address"]["Dst"]);
         $BytesTransferred  = $OneConnection["BytesSent"];
         $Agent 			= "N/A";
         $Duration 			= "N/A";
         $CompressionRatio  = "N/A";
         $InstanceNumber = -1;
      }
      $IdleTime = (int)$OneConnection["IdleTime"];
   ?>
         <TR>
            <TD align=center>
            <?
               if ($OnlyOrbitalConnections){
            ?>
            <a href="./connection_info.php?InstanceNumber=<?=$InstanceNumber?>">
               <img src="./images/icon-info.gif" border="0" alt="Click Here For Detailed Connection Information"> </a>
            <?}else{
                echo "N/A";
              }
            ?>
            </TD>
            <TD><?=$ClientAddress?></TD>
            <TD align="center"><=></TD>
            <TD><?=$ServerAddress?></TD>
            <TD align="center"><?=$Duration?></TD>
            <TD align="center"><?=$IdleTime?>&nbsp;sec</TD>
            <TD align="center"><?=$BytesTransferred?></TD>
            <TD align="center"><?=$CompressionRatio?></TD>
            <TD align="center"><?=$Agent?></TD>
         </TR>
<?
   }
   if ( (sizeof($Result) < $NumConnections) && (!$FilteringPerformed) ){
      echo "<TR><TH colspan=8>Only " . sizeof($Result) . " of " . $NumConnections . " were displayed. ";
      echo "<A href=./ui_configuration.php>Click Here To Change the Number Displayed</A></TH></TR>";
   }
?>
   </TABLE>
</BODY>

<? include(HTTP_ROOT_INCLUDES_DIR . "footer.php"); ?>
