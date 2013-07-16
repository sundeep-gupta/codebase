<?
	include("includes/header.php");
	$Auth->CheckRights(AUTH_LEVEL_VIEWER);

	if (isset($_GET["RecordNumber"]))
	{
		$RecordNumber = (int)$_GET["RecordNumber"];
	}
	else
	{
		ThrowException("Record Number not specified on get request line.",true);
	}

	$Param["StartRecord"] = $RecordNumber;
   $Param["Count"] = 1;
	$Result = xu_rpc_http_concise(
					array(
						'method'	=> "LogRequestXML",
						'args'		=> array($Param),
						'host'		=> RPC_SERVER,
						'uri'		=> RPC_URI,
						'port'		=> RPC_PORT
					) );
	if (array_key_exists("Fault",$Result[0])) {
		ThrowException("Log Record " . $RecordNumber . " Not Found",true);
   }
	$Log = $Result[0]; // Log records requests always result in arrays..

	function DoText($Log) {
		?>
		<font class="pageheading">Log: Text Entry</font><BR>
      <BR>

		<TABLE>
			<TR>
				<TH>Date:</TH>
				<TD><?=FormatDate($Log["Date"])?>
			</TR>
			<TR>
				<TH>Value:</TH>
				<TD><?=$Log["Text"]?></TD>
			</TR>
		</TABLE>
		<br>
		<br>
		<?
	}

   function StartTime($Log) {
      return $Log["Date"]->timestamp - 60;
   }

	function StatusHeader($StartTime, $Type) {
	   return $Type .	" Status From ". FormatTimeStamp($StartTime) .
	   		" To " . FormatTimeStamp($StartTime + 60);
	}

	function SystemStatusReferenceName($Object) { return GetHostname(); }

	function AdapterStatusReferenceName($Ref) {
       return $Ref["Name"];
	}
	function FlowStatusReferenceName($Ref) {
	   return FormatAgent($Ref["Agent"]);
	}
	function ConnectionStatusReferenceName($Ref) {
	   return FormatTCPAddress($Ref["Fast"]["Addr"]) . "<->" . FormatTCPAddress($Ref["Slow"]["Addr"]);
	}
	function DoStatusReferenceArray($Refs,$Type,$FormatNameFunc) {
      $Count = sizeof($Refs);
      if (isset($Refs["Entries"])) { 
         $Count = $Refs["Count"];
         $Refs = $Refs["Entries"];
      }

	   for ($i = 0; $i < sizeof($Refs); $i++) {
         $Ref = $Refs[$i];
         if ($Ref["Record"] != 0) {
            echo "<tr> <th> " . $Type . " </th> <td> " . $FormatNameFunc($Ref) . "</td> <td align=center>";
            echo "<a href=\"./log_record.php?RecordNumber=" . $Ref["Record"] . "\"> <img src=\"./images/icon-info.gif\" border=\"0\" alt=\"Click Here For Detailed " . $Type . " Information\"> </a> </td>";
         }
      }
      if (sizeof($Refs) != $Count){
            echo "<tr> <th> " . $Type . " </th> <td> &lt;Too Many Items. List Trucated.&gt;</td> <td align=center>";
            echo "</td>";
      }
    }
	function StatusReferences($System,$Adapter,$Flow,$Connection) {
		?>
		<br> <br>
		<TABLE>
			<TR>
			   <TH colspan=3>Coincident Status of Related System Objects</TD>
			</TR>
			<TR> <TH>Object Type</TD> <TH>Object Name</TH> <TH>Details</TH> </TR>
		<?
		DoStatusReferenceArray($System,"System","SystemStatusReferenceName");
		DoStatusReferenceArray($Adapter,"Adapter","AdapterStatusReferenceName");
		DoStatusReferenceArray($Flow,"Flow","FlowStatusReferenceName");
		DoStatusReferenceArray($Connection,"Connection","ConnectionStatusReferenceName");
		echo "</TABLE>";
	}

   function GraphLogEntry($Log, $EntryName, $PrevRecord, $NextRecord, $StartTime){
      echo "<DIV class=no_bg_color><CENTER><B>"
               . StatusHeader($StartTime, $EntryName) .
           "</B></CENTER>\n";

      $Grapher = new PERF_GRAPHER();
      $Grapher->LoadData($Log);
      $Grapher->SetPrevRecord($PrevRecord);
      $Grapher->SetNextRecord($NextRecord);

      echo "<TABLE><TR><TD colspan=3>\n" .
               $Grapher->Render() .
           "</TD></TR></TABLE></DIV>\n";
   }

	function DoSystemStatus($Log) {
      GraphLogEntry($Log, "System",
                    $Log["PrevLogRecord"], $Log["NextLogRecord"], ($Log["Date"]->timestamp - 60) );
      DoCompressionGraphs($Log,StartTime($Log));
	   StatusReferences(array(),$Log["Adapters"],$Log["Flows"],$Log["Connections"]);
	}

	function DoAdapterStatus($Log) {
      GraphLogEntry($Log, "Adapter " . $Log["Name"],
                    $Log["PrevLogRecord"], $Log["NextLogRecord"], ($Log["Date"]->timestamp - 60) );
	   StatusReferences(array($Log["System"]),array(),$Log["Flows"],$Log["Connections"]);
	}

	function DoFlowStatus($Log) {
      $NewLog["SlowPayloadTransmittedGood"]        = $Log["PayloadTransmittedGood"];
      $NewLog["SlowBytesTransmitted"]    = $Log["BytesTransmitted"];
      $NewLog["SlowPayloadReceivedGood"]     = $Log["PayloadReceivedGood"];
      $NewLog["BytesReceived"] = $Log["BytesReceived"];
      $NewLog["SlowBytesTransmitted"]     = $Log["BytesTransmitted"];
      $NewLog["SlowBytesTransmittedGood"] = $Log["BytesTransmittedGood"];

      GraphLogEntry($NewLog, "Flow " . FormatAgent($Log["Name"]),
                    $Log["PrevLogRecord"], $Log["NextLogRecord"], ($Log["Date"]->timestamp - 60));
	   StatusReferences(array($Log["System"]),array($Log["Adapter"]),array(),$Log["Connections"]);
	}
	function DoFastFlowStatus($Log) {
	   DoFlowStatus($Log);
	}
	function DoSlowFlowStatus($Log,$IsSuperUser) {
	   DoFlowStatus($Log);
	   if ($Log["CifsReadAheadBytes"]["Total"] != 0 ||
	       $Log["CifsWriteBehindBytes"]["Total"] != 0) {
 		   echo "<br> <h2> <center> Cifs Pipeline Performance </center> </h2>";
			 GraphPerfCountersLinked("Cifs Pipeline Performance",
							   array($Log["CifsReadAheadBytes"]["Rate"],$Log["CifsDiscardedReadBytes"]["Rate"],$Log["CifsWriteBehindBytes"]["Total"]),
							   array("Read Pipeline","Read Unused", "Write Pipeline"),
							   array("blue", "blue:1.5", "red"), 8, 0,$Log["PrevLogRecord"],$Log["NextLogRecord"],StartTime($Log));

	   }
      DoCompressionGraphs($Log,StartTime($Log));
      /* Experimental packet trains bw graphs */
      if ($IsSuperUser) {
         echo "<br> <h2> <center> Packet Train Statistics </center> </h2>";
         GraphPerfCountersLinked("BW 5 sec average",
                           array($Log["RecvPacketTrain5SecAvgerageBandwidth"]["Rate"],
                              $Log["RecvPacketTrain5SecAvgeragePayloadBandwidth"]["Rate"]),
                           array("All","Payload"),
                           array("red:1.5", "red"), 8, 0,$Log["PrevLogRecord"],$Log["NextLogRecord"],StartTime($Log));
         GraphPerfCountersLinked("BW 60 sec average",
                           array($Log["RecvPacketTrain60SecAvgerageBandwidth"]["Rate"],
                              $Log["RecvPacketTrain60SecAvgeragePayloadBandwidth"]["Rate"]),
                           array("All","Payload"),
                           array("red:1.5", "red"), 8, 0,$Log["PrevLogRecord"],$Log["NextLogRecord"],StartTime($Log));
         GraphPerfCountersLinked("Train Count",
                           array($Log["RecvPacketTrainCount"]["Rate"],$Log["RecvPacketTrainPayloadCount"]["Rate"]),
                           array("All","Payload"),
                           array("red:1.5", "red"), 1, 0,$Log["PrevLogRecord"],$Log["NextLogRecord"],StartTime($Log));
         GraphPerfCountersLinked("Train Length Packets",
                           array($Log["RecvPacketTrainTotalLength"]["Rate"],$Log["RecvPacketTrainTotalPayloadLength"]["Rate"]),
                           array("All","Payload"),
                           array("red:1.5", "red"), 1, 0,$Log["PrevLogRecord"],$Log["NextLogRecord"],StartTime($Log));
         GraphPerfCountersLinked("Train Size Bits",
                           array($Log["RecvPacketTrainTotalSize"]["Rate"],$Log["RecvPacketTrainTotalPayloadSize"]["Rate"]),
                           array("All","Payload"),
                           array("red:1.5", "red"), 8, 0,$Log["PrevLogRecord"],$Log["NextLogRecord"],StartTime($Log));
      }
	}
	function DoCifsStatus($Log) {
	   echo "<center>";
	   if ($Log["Passthrough"] == 1) {
	      echo " <br><br> <h2> Unpipelined CIFS Connection </h2>";
	   } else {
	      echo " <br><br> <h2> Pipelined CIFS Connection Information </h2> <br>";
	      GraphPerfCountersLinked("Pipelined Bytes",
	         array($Log["ReadAheadBytes"]["Rate"],$Log["DiscardedReadBytes"]["Rate"],$Log["WriteBehindBytes"]["Rate"]),
	         array("Read","Unused","Write"),
	         array("blue:1.5","blue","red"), 8, 0, $Log["PrevLogRecord"], $Log["NextLogRecord"],StartTime($Log));
	   }
	}
	function DoConnectionStatus($Log) {
      // Flatten the list so that Fast.BytesReceived => FastBytesReceived
      // This is the format my function likes things in.
      $NewLog = array();
      foreach ($Log["Slow"] as $Key => $Entry){
         $NewLog["Slow" . $Key] = $Entry;
      }
      foreach ($Log["Fast"] as $Key => $Entry){
         $NewLog["Fast" . $Key] = $Entry;
      }
      GraphLogEntry($NewLog, "Connection " . ConnectionStatusReferenceName($Log),
                    $Log["PrevLogRecord"], $Log["NextLogRecord"], ($Log["Date"]->timestamp - 60) );

	   StatusReferences(array($Log["Fast"]["System"]),
                       array($Log["Fast"]["Adapter"],$Log["Slow"]["Adapter"]),
                       array($Log["Fast"]["Flow"],$Log["Slow"]["Flow"]),
                       array() );
      if ($Log["FilterType"] == "CIFS") {
         DoCifsStatus($Log);
      }
	}
	function LogInfo($L) {
      $Result["Initiator"] = FormatTCPAddress($L["Client"]["Phar"]);
      $Result["Responder"] = FormatTCPAddress($L["Server"]["Phar"]);
      if ($L["Agent"]["Accelerated"]) {
         $Result["Partner"] = FormatAgent($L["Agent"]);
      }
	   return $Result;
	}

	function DoOpenConnection($Log) {
		?>
		<font class="pageheading">Log: Connection Open</font><BR>
      <BR>

		<TABLE>
			<TR>
				<TH>Attribute</TH>
				<TH>Value</TH>
			</TR>
		<?
		$Info["Initiator"] = FormatTCPAddress($Log["Client"]["Phar"]);
		$Info["Responder"] = FormatTCPAddress($Log["Server"]["Phar"]);
		if ($Log["Server"]["Agent"]["Accelerated"]) {
			$Info["Partner"] = FormatAgent($Log["Server"]["Agent"]);
		} else if ($Log["Client"]["Agent"]["Accelerated"]) {
         $Info["Partner"] = FormatAgent($Log["Client"]["Agent"]);
      }
		foreach ($Info as $Label => $Value)	{
			?>
				<TR>
					<TH><?=$Label?></TH>
					<TD><?=$Value?></TD>
				</TR>
			<?
		}?>
			<TR>
				<TH>Connection Summary</TH>
				<TD><?=$Log["Text"]?></TD>
			</TR>
			<TR>
				<TH>Open Date/Time</TH>
				<TD><?=FormatDate($Log["Date"])?></TD>
			</TR>
		</TABLE>
<?	}

	function EPInfo($L) {
      $Result["Far Address"] = FormatTCPAddress($L["Phar"]);
      $Result["Near Address"] = FormatTCPAddress($L["Near"]);
      $Result["Bytes Received"] = $L["BytesReceived"];
      $Result["Payload Received"] = $L["PayloadReceived"];
      $Result["Bytes Received (Good)"] = $L["BytesReceivedGood"];
      $Result["Payload Received (Good)"] = $L["PayloadReceivedGood"];
      $Result["Bytes Transmitted"] = $L["BytesTransmitted"];
      $Result["Payload Transmitted"] = $L["PayloadTransmitted"];
      $Result["Bytes Transmitted (Good)"] = $L["BytesTransmittedGood"];
      $Result["Payload Transmitted (Good)"] = $L["PayloadTransmittedGood"];
	   return $Result;
	}
	function DoCloseConnection($Log) {
		?>

		<font class="pageheading">Log: Connection Close</font><BR>
      <br>
		   <TABLE>
			  <TR>
				 <TH>Attribute</TH>
				 <TH>Value</TH>
			  </TR>
			  <TR>
				 <TD>Duration</TD>
				 <TD><?=ToPrintableTime($Log["Duration"])?></TD>
			  </TR>

			  <TR>
				 <TD>Close Time</TD>
				 <TD><?=FormatDate($Log["Date"])?></TD>
			  </TR>

			  <TR>
				 <TD>Summary</TD>
				 <TD><?=$Log["Text"]?></TD>
			  </TR>

		   </TABLE>

		<br>
		<font class="pageheading">Per-Endpoint Information</font><BR><BR>

		<DIV class=settings_table>
		<TABLE>
			<TR>
				<TH>Attribute</TH>
				<TH>Client Value</TH>
			 <TH>Server Value</TH>
			</TR>
		<?
		   $Info[0] = EPInfo($Log["Client"]);
		   $Info[1] = EPInfo($Log["Server"]);
			foreach ($Info[0] as $Label => $Value)
			{
		?>
				<TR>
				   <TH align=left><?=$Label?>:</TH>
					<TD align=center><?=$Value?></TD>
				 <TD align=center><?=$Info[1][$Label]?></TD>
				</TR>
		<?	} ?>
			</TABLE>
			</DIV>
		<?
	}
   switch ($Log["Type"]) {
      case "alert":
      case "text":
         DoText($Log);
         break;
      case "system_status":
         DoSystemStatus($Log);
         break;
      case "adapter_status":
         DoAdapterStatus($Log);
         break;
      case "fast_flow_status":
         DoFastFlowStatus($Log);
         break;
      case "slow_flow_status":
         DoSlowFlowStatus($Log, $Auth->IsSuperUser() );
         break;
      case "connection_status":
         DoConnectionStatus($Log);
         break;
      case "closeconnection":
         DoCloseConnection($Log);
         break;
      case "openconnection":
         DoOpenConnection($Log);
         break;
      default:
         echo " Unhandled log record type " . $Log["Type"];
         break;
   }


/*
 * Copyright Orbital Data Corporation 2003
 */
?>
