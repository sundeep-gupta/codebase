<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);

   if (isset($_GET["InstanceNumber"])){
      $InstanceNumber = (int)$_GET["InstanceNumber"];
   }
   else{
      ThrowException("Instance Number not specified on get request line.",true);
   }

   $Flow = OrbitalGet("FLOW",array("Side"),$InstanceNumber);
   if (IsFault($Flow)) {
      ThrowException("Flow Instance " . $InstanceNumber . " Not Found", true);
   }
   global $SplitRate;
   $SplitRate = GetParameter("UI.UseSplitRates");
   $Attributes = array(
            "DestinationAgent", "TotalBytesReceived", "TotalPayloadReceived", "TotalBytesTransmitted",
            "TotalPayloadTransmitted", "Connections", "AdapterInstanceNumber",
            "BytesTransmitted", "PayloadTransmittedGood", "BytesReceived", "PayloadReceivedGood",
            "FECBytesCorrected", "PayloadReceivedGood", "StatusLogRecord", "EffectiveSendRate", 
            "EffectiveRecvRate", "SenderType", "Side", "RuledSendRate", "RuledRecvRate");
            
   if ($Flow["Side"] == "FAST") {
      $FlowType = "FAST_FLOW";
   } else {
      $FlowType = "SLOW_FLOW";
      array_push($Attributes,
            "TotalFECBytesCorrected","TotalFECBytesReceived","TotalFECBytesSent",
            "RecvPacketTrainCount", "RecvPacketTrainTotalLength", "RecvPacketTrainTotalSize",
            "RecvPacketTrainPayloadCount", "RecvPacketTrainTotalPayloadLength", "RecvPacketTrainTotalPayloadSize",
            "RecvPacketTrainTotalTimeUSec", "RecvPacketTrainTotalPayloadTimeUSec", "RecvPacketTrainAvgerageBandwidth",
            "RecvPacketTrain1SecAvgerageBandwidth", "RecvPacketTrain5SecAvgerageBandwidth",
            "RecvPacketTrain30SecAvgerageBandwidth", "RecvPacketTrain60SecAvgerageBandwidth",
            "RecvPacketTrainAvgeragePayloadBandwidth", "RecvPacketTrain1SecAvgeragePayloadBandwidth",
            "RecvPacketTrain5SecAvgeragePayloadBandwidth", "RecvPacketTrain30SecAvgeragePayloadBandwidth",
            "RecvPacketTrain60SecAvgeragePayloadBandwidth",
            "TotalCifsReadAheadBytes", "TotalCifsWriteBehindBytes", "TotalCifsDiscardedReadBytes",
            "CifsReadAheadBytes", "CifsWriteBehindBytes", "CifsDiscardedReadBytes",
			"CifsWriteIoErrors", "CifsLockBreaks", "CifsProtocolErrors", "CifsUnhandledOperations", "CifsCurrentReadAheadBytes", "CifsConnectionCount",
   			"CompressionClearTextBytes", "CompressionCipherTextBytes", "DecompressionClearTextBytes", "DecompressionCipherTextBytes",
   			"TotalCompressionClearTextBytes", "TotalCompressionCipherTextBytes", "TotalDecompressionClearTextBytes", "TotalDecompressionCipherTextBytes"
            );
   }

   $Flow = OrbitalGet($FlowType, $Attributes, $InstanceNumber);
   if (array_key_exists("Fault",$Flow)) {
      ThrowException($FlowType . " Instance " . $InstanceNumber . " Not Found",true);
   }

   function FlowInfo($F) {
      global $SplitRate;
      if ($F["SenderType"] > 0) {
         $Result["Send Rate Setting"] = FormatThroughput($F["RuledSendRate"]);
         $Result["Send Rate Constrained"] = FormatThroughput($F["EffectiveSendRate"]);
         if ($SplitRate) {
            $Result["Recv Rate Setting"] = FormatThroughput($F["RuledRecvRate"]);
            $Result["Recv Rate Constrained"] = FormatThroughput($F["EffectiveRecvRate"]);
         }
      }

      $Result["Total Payload Received"] = $F["TotalPayloadReceived"];
      $Result["Total Bytes Received"] = $F["TotalBytesReceived"];
      $Result["Total Payload Transmitted"] = $F["TotalPayloadTransmitted"];
      $Result["Total Bytes Transmitted"] = $F["TotalBytesTransmitted"];
      
      if ($F["Side"] == "SLOW") {
         $Result["Total Uncompressed Bytes Sent"]     = $F["TotalCompressionClearTextBytes"];
         $Result["Total Compressed Bytes Sent"]       = $F["TotalCompressionCipherTextBytes"];
         $Result["Total Uncompressed Bytes Received"] = $F["TotalDecompressionClearTextBytes"];
         $Result["Total Compressed Bytes Received"]   = $F["TotalDecompressionCipherTextBytes"];
         
         $Result["Compression Ratio"] =
                     FormatRatio( $F["TotalCompressionClearTextBytes"]  + $F["TotalDecompressionClearTextBytes"],
                                  $F["TotalCompressionCipherTextBytes"] + $F["TotalDecompressionCipherTextBytes"] );
         
      
         if ($F["TotalFECBytesSent"] != 0 || $F["TotalFECBytesReceived"] != 0) {
            $Result["Bytes Dynamically Corrected"] = $F["TotalFECBytesCorrected"];
            $Result["Dynamic Correction Bytes Sent"] = $F["TotalFECBytesSent"];
            $Result["Dynamic Correction Bytes Received"] = $F["TotalFECBytesReceived"];
         }
      }
      $Result["Adapter Information"] = "<a href=\"./adapter_info.php?InstanceNumber=".$F["AdapterInstanceNumber"] . "\"> More Info <img src=\"./images/icon-info.gif\" border=\"0\" alt=\"Click Here For Detailed Connection Information\"> </a>";
      foreach($F["Connections"] as $instance) {
         $Result["Connection [" . $instance["DisplayName"] . "]"] = "<a href=\"./connection_info.php?InstanceNumber=" . $instance["InstanceNumber"] . "\"> More Info <img src=\"./images/icon-info.gif\" border=\"0\" alt=\"Click Here For Detailed Connection Information\"> </a>";
      }
      return $Result;
   }

   function CifsTableRow($Label,$Value) {
	?>
      <TR>
         <TH align=center><?=$Label?></TH>
         <TD align=center><?=$Value?></TD>
      </TR>
      <?
   }

   $PrevRecord = -1; $NextRecord = -1;
   if (isset($_GET["StatusLogRecord"])) { 
      $PrevRecord = $_GET["StatusLogRecord"]; 
   }else if (isset($Flow["StatusLogRecord"])){
      $PrevRecord = $Flow["StatusLogRecord"];
   }
   
   if ($Flow["Side"] == "FAST"){
      $GraphData["FastBytesTransmitted"]       = $Flow["BytesTransmitted"];
      $GraphData["FastPayloadTransmittedGood"] = $Flow["PayloadTransmittedGood"];
      $GraphData["FastBytesReceived"]          = $Flow["BytesReceived"];
      $GraphData["FastPayloadReceivedGood"]    = $Flow["PayloadReceivedGood"];
   }else{
      $GraphData["SlowBytesTransmitted"]       = $Flow["BytesTransmitted"];
      $GraphData["SlowPayloadTransmittedGood"] = $Flow["PayloadTransmittedGood"];
      $GraphData["SlowBytesReceived"]          = $Flow["BytesReceived"];
      $GraphData["SlowPayloadReceivedGood"]    = $Flow["PayloadReceivedGood"];
   }

   //
   // Graph this flow
   //
   $Grapher = new PERF_GRAPHER();
   $Grapher->SetPrevRecord($PrevRecord);
   $Grapher->SetShowFastSide($Flow["Side"] == "FAST");
   $Grapher->SetShowSlowSide($Flow["Side"] == "SLOW");
   $Grapher->LoadData($GraphData);
   echo $Grapher->Render();

?>

<font class="pageheading">Detailed <?=($Flow["Side"] == "FAST" ? "LAN" : "WAN")?> Flow Information To <?=FormatAgent($Flow["DestinationAgent"])?></font><BR><BR>

   <div class="settings_table">
   <table>
<?
   $Info = FlowInfo($Flow);
   foreach ($Info as $Label => $Value)
   {
      CifsTableRow($Label,$Value);
   }
?>
   </table>
   <div class="settings_table">

<?
   if ($Flow["Side"] == "SLOW") {
      if ($Flow["CifsConnectionCount"] != 0) {
        GraphPerfCountersLinked("Cifs Pipelining",
        		array($Flow["CifsReadAheadBytes"]["Rate"],$Flow["CifsDiscardedReadBytes"]["Rate"],$Flow["CifsWriteBehindBytes"]["Rate"]),
        		array("Read Pipeline Bits", "Unused Pipelined Bits", "Write Pipelined Bits"),
        		array("blue","blue:1.5","red"), 8, 0, $Flow["StatusLogRecord"],0,time());
    	echo "<br><br><font class=\"pageheading\">Cifs Detailed Information</font><BR><BR>";
		echo "<TABLE> ";
		CifsTableRow("CIFS Connections",$Flow["CifsConnectionCount"]);
		if ($Flow["CifsWriteIoErrors"] != 0) CifsTableRow("Pipelined Write I/O Errors",$Flow["CifsWriteIoErrors"]);
		if ($Flow["CifsProtocolErrors"] != 0) CifsTableRow("Protocol Errors Detected",$Flow["CifsProtocolErrors"]);
		if ($Flow["CifsUnhandledOperations"] != 0) CifsTableRow("Unhandled Operations",$Flow["CifsUnhandledOperations"]);
		echo "</table>";
      }
      if ($Flow["TotalFECBytesReceived"] != 0) {
      	GraphPerfCountersLinked("Dynamic Correction",
      	                  array($Flow["FECBytesCorrected"]["Rate"],$Flow["PayloadReceivedGood"]["Rate"]),
      	                  array("Bits Dynamically Corrected","GoodPut Bits"),
      	                  array("red:1.5", "red"), 8, 0,$Flow["StatusLogRecord"],0,time());
      }
      
      echo "<BR><BR>";
      GraphCompressedUncompressed($Flow, false);
   /* Experimental packet trains bw graphs */
 	if ( $Auth->IsSuperUser() ) {
	  echo "<br> <h2> <center> Packet Train Statistics </center> </h2>";
	  GraphPerfCountersLinked("BW 5 sec average",
						array($Flow["RecvPacketTrain5SecAvgerageBandwidth"]["Rate"],
						   $Flow["RecvPacketTrain5SecAvgeragePayloadBandwidth"]["Rate"]),
						array("All","Payload"),
						array("red:1.5", "red"), 8, 0,$Flow["StatusLogRecord"],0,time());
	  GraphPerfCountersLinked("BW 60 sec average",
						array($Flow["RecvPacketTrain60SecAvgerageBandwidth"]["Rate"],
						   $Flow["RecvPacketTrain60SecAvgeragePayloadBandwidth"]["Rate"]),
						array("All","Payload"),
						array("red:1.5", "red"), 8, 0,$Flow["StatusLogRecord"],0,time());
	  GraphPerfCountersLinked("Train Count",
						array($Flow["RecvPacketTrainCount"]["Rate"],$Flow["RecvPacketTrainPayloadCount"]["Rate"]),
						array("All","Payload"),
						array("red:1.5", "red"), 1, 0,$Flow["StatusLogRecord"],0,time());
	  GraphPerfCountersLinked("Train Length Packets",
						array($Flow["RecvPacketTrainTotalLength"]["Rate"],$Flow["RecvPacketTrainTotalPayloadLength"]["Rate"]),
						array("All","Payload"),
						array("red:1.5", "red"), 1, 0,$Flow["StatusLogRecord"],0,time());
	  GraphPerfCountersLinked("Train Size Bits",
						array($Flow["RecvPacketTrainTotalSize"]["Rate"],$Flow["RecvPacketTrainTotalPayloadSize"]["Rate"]),
						array("All","Payload"),
						array("red:1.5", "red"), 8, 0,$Flow["StatusLogRecord"],0,time());
	}
   }
?>
