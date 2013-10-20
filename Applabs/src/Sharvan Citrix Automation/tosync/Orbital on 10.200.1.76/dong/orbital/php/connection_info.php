<?
	include("includes/header.php");
	$Auth->CheckRights(AUTH_LEVEL_VIEWER);

	if (isset($_GET["InstanceNumber"]))
	{
		$InstanceNumber = (int)$_GET["InstanceNumber"];
	}
	else
	{
		ThrowException("Instance Number not specified on get request line.",true);
	}

	global $SplitRate;
   $SplitRate = GetParameter("UI.UseSplitRates");
	$Conn = OrbitalGet("CONNECTION", "", $InstanceNumber);
   $IsCompressed = isset($Conn["IsCompressed"]);

	if (array_key_exists("Fault",$Conn)) {
		ThrowException("Connection " . $InstanceNumber . " Not Found",true);
   }

	$Param["Class"] = "ENDPOINT";
	$Instances = array($Conn["FastInstanceNumber"],$Conn["SlowInstanceNumber"]);
	$Attributes = array(
		"AdapterInstanceNumber", "FlowInstanceNumber",
		"FarPhysicalAddress", "FarLogicalAddress", "NearPhysicalAddress", "NearLogicalAddress",
		"TotalPayloadTransmitted",
		"TotalBytesTransmitted",
		"TotalPayloadReceived",
		"TotalBytesReceived",
		"TotalPayloadTransmittedGood",
		"TotalBytesTransmittedGood",
		"TotalPayloadReceivedGood",
		"TotalBytesReceivedGood",
      "BytesTransmitted", "PayloadTransmittedGood",
      "BytesReceived", "PayloadReceivedGood",
      "RTT", "IdleTime", "MaxReceivedWindowSize", "MaxReceivedPayloadSize", 
      "SmoothedReceivedWindowSize", "RuledSendRate", "RuledRecvRate", "SenderType", 
      "EffectiveSendRate", "EffectiveRecvRate", "CompressionEnabled", "StatusLogRecord",
      "TotalCompressionCipherTextBytes", "TotalCompressionClearTextBytes",
      "TotalDecompressionCipherTextBytes", "TotalDecompressionClearTextBytes"
	);

	$Result = OrbitalGet("ENDPOINT", $Attributes, $Instances);
   //var_dumper( OrbitalGet("ENDPOINT") );

	if (IsFault("Fault",$Result)) {
		ThrowException("Connection " . $InstanceNumber . " Not Found",true);
   }
	$Fast = $Result[0];
	$Slow = $Result[1];

   if ($IsCompressed){
      $UncompressedBytesSent = $Slow["TotalCompressionClearTextBytes"];
      $UncompressedBytesRecv = $Slow["TotalDecompressionClearTextBytes"];
      $CompressedBytesSent   = $Slow["TotalCompressionCipherTextBytes"];
      $CompressedBytesRecv   = $Slow["TotalDecompressionCipherTextBytes"];
   }

	function EndPointInfo($EP) {
	   global $SplitRate;
	   $Result["Adapter Information"] = "<a href=\"./adapter_info.php?InstanceNumber=" . $EP["AdapterInstanceNumber"]. "\"> More Info <img src=\"./images/icon-info.gif\" border=\"0\" alt=\"Click Here For Detailed Adapter Information\"> </a>";
	   $Result["Flow Information"] = "<a href=\"./flow_info.php?InstanceNumber=" . $EP["FlowInstanceNumber"]. "\"> More Info <img src=\"./images/icon-info.gif\" border=\"0\" alt=\"Click Here For Detailed Flow Information\"> </a>";

	   $Result["Far Logical Address"] = FormatIPAddressPort($EP["FarLogicalAddress"]);
	   $Result["Far Physical Address"] = FormatIPAddressPort($EP["FarPhysicalAddress"]);
	   $Result["Near Logical Address"] = FormatIPAddressPort($EP["NearLogicalAddress"]);
	   $Result["Near Physical Address"] = FormatIPAddressPort($EP["NearPhysicalAddress"]);

      $Result["Idle Time"] = (int)$EP["IdleTime"] . " Secs";
      if ($EP["SenderType"] == "Cwin") {
         $Result["Sender Type"] = "Standard";
         $Result["Send Rate Setting"] = "<i>n/a</i>";
         $Result["Send Rate Constrained"] = "<i>n/a</i>";
         if ($SplitRate) {
	         $Result["Recv Rate Setting"] = "<i>n/a</i>";
	         $Result["Recv Rate Constrained"] = "<i>n/a</i>";
	      }
      } else {
         $Result["Sender Type"] = "Orbital";
         $Result["Send Rate Setting"] = FormatThroughput($EP["RuledSendRate"]);
         $Result["Send Rate Constrained"] = FormatThroughput($EP["EffectiveSendRate"]);
         if ($SplitRate) {
         	$Result["Recv Rate Setting"] = FormatThroughput($EP["RuledRecvRate"]);
         	$Result["Recv Rate Constrained"] = FormatThroughput($EP["EffectiveRecvRate"]);
         }
      }

      $Result["Smoothed Round Trip Time"] = (int)($EP["RTT"] * 1000.0) . " mS";
      $Result["Smoothed Received Window Size"] = $EP["SmoothedReceivedWindowSize"];
      $Result["Largest Receive Window"] = $EP["MaxReceivedWindowSize"];
      $Result["Largest Payload Received"] = $EP["MaxReceivedPayloadSize"];
//      $Result["Apparent Max BW"] = (int)(($EP["MaxReceivedWindowSize"] / $EP["RTT"]) * 8 / 1000.0) . " Kb/Sec";

	   $Result["Total Wire Bytes Transmitted"] = $EP["TotalBytesTransmitted"];
	   $Result["Total Payload Bytes Transmitted"] = $EP["TotalPayloadTransmitted"];
	   $Result["Total Wire Bytes Transmitted (Good)"] = $EP["TotalBytesTransmittedGood"];
	   $Result["Total Payload Bytes Transmitted (Good)"] = $EP["TotalPayloadTransmittedGood"];
	   $Result["Total Wire Bytes Received (Good)"] = $EP["TotalBytesReceivedGood"];
	   $Result["Total Payload Bytes Received (Good)"] = $EP["TotalPayloadReceivedGood"];
	   $Result["Total Wire Bytes Received"] = $EP["TotalBytesReceived"];
	   $Result["Total Payload Bytes Received"] = $EP["TotalPayloadReceived"];
	   if ($EP["CompressionEnabled"] != 0) {
	   	  $Result["Compression"] = "Enabled";
	   }
	   return $Result;
	}

   //
   // Graph this data
   //
   $GraphData["FastBytesTransmitted"]       = $Fast["BytesTransmitted"];
   $GraphData["FastPayloadTransmittedGood"] = $Fast["PayloadTransmittedGood"];
   $GraphData["FastBytesReceived"]          = $Fast["BytesReceived"];
   $GraphData["FastPayloadReceivedGood"]    = $Fast["PayloadReceivedGood"];
   $GraphData["SlowBytesTransmitted"]       = $Slow["BytesTransmitted"];
   $GraphData["SlowPayloadTransmittedGood"] = $Slow["PayloadTransmittedGood"];
   $GraphData["SlowBytesReceived"]          = $Slow["BytesReceived"];
   $GraphData["SlowPayloadReceivedGood"]    = $Slow["PayloadReceivedGood"];

   $Grapher = new PERF_GRAPHER();
   $Grapher->SetPrevRecord($Conn["StatusLogRecord"]);
   $Grapher->LoadData($GraphData);
   echo $Grapher->Render();

?>


<BR><BR><BR>
<div class="settings_table">
<font class="pageheading">Monitoring: Detailed Connection Information</font><BR><BR>

   <TABLE>
      <TR> <TH>Creation Time</TH> <TD> <?=FormatDate($Conn["StartTime"])?> </TD> </TR>
      <!-- only applicable for compressed connection -->
      <? if ($IsCompressed){ ?>
         <TR> <TH>Uncompressed Bytes Transmitted</TH> 
              <TD> <?=FormatBytes($UncompressedBytesSent+$UncompressedBytesRecv)?></TD> 
         </TR>
         <TR> <TH>Compressed Bytes Transmitted</TH> 
              <TD> <?=FormatBytes($CompressedBytesSent + $CompressedBytesRecv)?> </TD>
         </TR>
         <TR> <TH>Effective Compression Ratio</TH> 
              <TD> <?=FormatRatio( $UncompressedBytesSent+$UncompressedBytesRecv,
                                   $CompressedBytesSent + $CompressedBytesRecv )?>                  
              </TD> 
         </TR>
      <? } ?>

      <TR> <TH>Duration</TH> <TD> <?=(int)$Conn["Duration"]?> Secs </TD> </TR>
      <TR> <TH>Idle Time</TH> <TD> <?=(int)$Conn["IdleTime"]?> Secs </TD> </TR>
      <TR> <TH>Status</TH> <TD> <?=$Conn["State"]?> </TD> </TR>
<?
		if ($Conn["Agent"]["Accelerated"]) {
			echo "<TR> <TH>Orbital Partner</TH> <TD>" . FormatAgent($Conn["Agent"]) . " </TD> </TR> ";
		}
?>
   </TABLE>
   <BR><BR>


<font class="pageheading">Detailed Per-Endpoint Information</font><BR><BR>
   <TABLE width=600>
      <TR>
         <TH>Attribute</TH>
         <TH>LAN Endpoint Value</TD>
         <TH>WAN Endpoint Value</TH>
      </TR>

<?
   $Info[0] = EndPointInfo($Fast);
   $Info[1] = EndPointInfo($Slow);
	foreach ($Info[0] as $Label => $Value)
	{
?>
		<TR>
			<TD><?=$Label?>:</TD>
			<TD><?=$Info[0][$Label]?></TD>
			<TD><?=$Info[1][$Label]?></TD>
		</TR>
<?	} ?>
	</TABLE>
</div>
<?

   function ShowCifs($InstanceNumber) {
      $Cifs = OrbitalGet("CIFS", "", $InstanceNumber);
	  if (array_key_exists("Fault",$Cifs)) {
		ThrowException("Connection " . $InstanceNumber . " Not Found",true);
	  }
	  if ($Cifs["Passthrough"] != 0) {
	     echo "<h2>Unpipelined CIFS Connection</h2>";
	  } else {
		  ?> <br>
			  <TABLE width=600>
			  <tr>
			     <th colspan=2> Detailed CIFS Information </th>
			  </tr>
		  <?
		  $R["Pipelined Read Bytes"] = FormatBytes($Cifs["TotalReadAheadBytes"]);
		  $R["Pipelined Write Bytes"] = FormatBytes($Cifs["TotalWriteBehindBytes"]);
		  if ($Cifs["TotalDiscardedReadBytes"] != 0) {
		     $R["Pipelined Unused Bytes"] = FormatBytes($Cifs["TotalDiscardedReadBytes"]);
		  }
		  if ($Cifs["DialectIndex"] != 5) {
			$R["Dialect Index"] = $Cifs["DialectIndex"];
		  }
		  if ($Cifs["WriteIoErrors"] != 0) {
			 $R["Pipelined Write I/O Errors"] = $Cifs["WriteIoErrors"];
		  }
		  if ($Cifs["LockBreaks"] != 0) {
			 $R["Lock Breaks"] = $Cifs["LockBreaks"];
		  }
		  if ($Cifs["ProtocolErrors"] != 0) {
			 $R["Protocol Errors Detected"] = $Cifs["ProtocolErrors"];
		  }
		  if ($Cifs["UnhandledOperations"] != 0) {
			 $R["Operations Unhandled"] = $Cifs["UnhandledOperations"];
		  }
		  foreach ($R as $Label => $Value) {
			  ?>
				<TR>
					<TD><?=$Label?>:</TD>
					<TD><?=$Value?></TD>
				</TR>
			  <?
		  }

		  echo "</TABLE>";
		  if (sizeof($Cifs["OpenFileInfo"]) != 0) {
			 ?> <br> <br>
				<table width=600>
				    <tr>
				        <th colspan=5> <?=sizeof($Cifs["OpenFileInfo"])?> File(s) Are Open </th>
				    </tr>
					<tr>
						<th>File</th>
						<th>Usage Count</th>
						<th>Lock</th>
						<th>Requests</th>
						<th>Cache</th>
					</tr>
			 <?
			 foreach ($Cifs["OpenFileInfo"] as $Label => $Value) {
				$Requests = 0;
				$Cached = 0;
				foreach ($Value["raMap"] as $Label1 => $Value1) {
				   $Requests = $Requests + sizeof($Value1["PendingRequests"]);
				   $Cached   = $Cached   + sizeof($Value1["Cached"]);
				}
				?>
					<tr>
						<td> <?=$Value["FileName"] ?> </td>
						<td> <?=$Value["FileIdCount"] ?> </td>
						<td> <?=$Value["OplockLevel"] ?> </td>
						<td> <?=$Requests ?> </td>
						<td> <?=$Cached ?> </td>

					</tr>
				<?
			 }
			 echo "</table><br><br>";
			 echo GraphPerfCountersLinked("Pipelining",
			 	array($Cifs["ReadAheadBytes"]["Rate"],$Cifs["DiscardedReadBytes"]["Rate"],$Cifs["WriteBehindBytes"]["Rate"]),
			 		array("Read","Unused","Write"), array("blue","blue:1.5","red"), 8, 0,0,0,time()-60,false);
		  }
	   }
	}

   if ($Conn["FilterType"] == "CIFS") {
      ShowCifs($Conn["FilterInstanceNumber"]);
   }
?>
