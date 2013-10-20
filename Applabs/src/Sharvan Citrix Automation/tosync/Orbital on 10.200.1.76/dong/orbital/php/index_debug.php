<?
	include("includes/header.php");

      if (isset($_COOKIE["GraphRefreshRate"]))
      {
         $GraphRefreshRate = $_COOKIE["GraphRefreshRate"];
      }else
      {
         $GraphRefreshRate = GRAPH_DEFAULT_REFRESH_RATE;
      }

      if (isset($_GET["AutoRefresh"]))
      {
         $AutoRefresh = (int)$_GET["AutoRefresh"];
      }
      else
      {
         $AutoRefresh = 0;
      }


      if ($AutoRefresh)
      {
         $RandNum = time();

         echo <<< END
         <HTML>
         <HEAD>
         <TITLE>Orbital Data - Main</TITLE>
         <META http-equiv="refresh" content="$AutoRefresh;URL=./index_debug.php?AutoRefresh=$AutoRefresh">
         <META http-equiv="Expires" content="$AutoRefresh"">
         <META http-equiv="Pragma" content="no-cache">
         <META http-equiv="Cache-control" content="no-cache">
         </HEAD>
END;
      }

      //
      // This is getting include here...instead of at the top, to fix a Netscape 4.78 refreshing problem
      //
      ?>
      <BODY>
      <div align="center">
		Auto-refresh <B><?=$AutoRefresh?"ON":"OFF"?></B>: <A href="./index_debug.php?AutoRefresh=<?=$AutoRefresh?0:$GraphRefreshRate?>">Toggle</A>


		<!-- DISPLAY THE CURRENT SYSTEM TIME -->
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<B>Time: <?=strftime ("%b %d %Y %H:%M:%S")?></B>

		<BR><BR>


   <?
   $Grapher = new PERF_GRAPHER();
   echo $Grapher->Render();


   $Result = OrbitalGet("SYSTEM",
   		array(	"MainCPUIdleTime","MainCPUUsageTime",
   				"FastWindowStops","SlowWindowStops",
   				"FastWindowZeros","SlowWindowZeros",
   				"FastRTOs",		  "SlowRTOs", "VMUsage"));
   $Idle = $Result["MainCPUIdleTime"]["Rate"];
   $CPU  = $Result["MainCPUUsageTime"]["Rate"];

   /* Convert time to cpu utilized percent */
   for ($i = 0; $i < sizeof($CPU); ++$i) {
      $CPU[$i] = $CPU[$i] / 10000.0; // % of CPU Used (Idle time in Microseconds)
      $Idle[$i] = $CPU[$i] + ($Idle[$i] / 10000.0); // % Of CPU unused (in microseconds)
   }
   echo "<br>";
   GraphPerfCountersLinked("Packet Processing CPU Resource",
         array($Idle,$CPU),
         array("CPU Idle %","CPU Used %"),
         array("red:1.5","red"),1,110,0,0,time());
   $S = OrbitalGet("SYSTEM",
         array("CompressConnectionCount",
               "CompressionClearTextBytes",
               "CompressionCipherTextBytes",
               "DecompressionClearTextBytes",
               "DecompressionCipherTextBytes",
               "CompressionRewinds",
               "DecompressionRewinds",
               "CompressionRewindTextBytes",
               "SlowPacketsReceived",
               "SlowBytesReceived",
               "SlowPacketsTransmitted",
               "SlowBytesTransmitted",
               "CompressionBootOuts"
            ));
   if (array_sum($S["CompressionClearTextBytes"]["Rate"]) > 0 ||
       array_sum($S["DecompressionClearTextBytes"]["Rate"]) > 0) {
      DoCompressionGraphs($S);
   }

   if (array_sum($S["CompressionRewinds"]["Rate"]) > 0 ||
       array_sum($S["DecompressionRewinds"]["Rate"]) > 0) {
       echo "<br>";
       GraphPerfCountersLinked("Rewinds",
             array($S["CompressionRewinds"]["Rate"],$S["DecompressionRewinds"]["Rate"],$S["CompressionRewindTextBytes"]["Rate"]),
             array("Compression","Decompression","Compression Bytes"),
             array("red","red:1.5","blue"),1,0,0,0,time());
   }
   if (array_sum($Result["FastWindowStops"]["Rate"]) != 0 ||
       array_sum($Result["SlowWindowStops"]["Rate"]) != 0) {
	    echo "<br> (Slow = Bright Red) <br>";
   		GraphPerfCountersLinked("Window Stops",
   	       	 array($Result["FastWindowStops"]["Rate"],$Result["SlowWindowStops"]["Rate"]),
   		     array("Fast","Slow"),
   		     array("red","red:1.5"),1,0,0,0,time());
   }
   if (array_sum($Result["FastWindowZeros"]["Rate"]) != 0 ||
       array_sum($Result["SlowWindowZeros"]["Rate"]) != 0) {
	    echo "<br> (Slow = Bright Red)<br>";
   		GraphPerfCountersLinked("Window Zeros",
   	       	 array($Result["FastWindowZeros"]["Rate"],$Result["SlowWindowZeros"]["Rate"]),
   		     array("Fast","Slow"),
   		     array("red","red:1.5"),1,0,0,0,time());
   }

   if (array_sum($Result["FastRTOs"]["Rate"]) != 0 ||
       array_sum($Result["SlowRTOs"]["Rate"]) != 0) {
	    echo "<br> (Slow = Bright Read)<br>";
   		GraphPerfCountersLinked("RTOs",
   	       	 array($Result["FastRTOs"]["Rate"],$Result["SlowRTOs"]["Rate"]),
   		     array("Fast","Slow"),
   		     array("red","red:1.5"),1,0,0,0,time());
   }
   echo "<br>";
   GraphPerfCountersLinked("Virtual Memory Usage",
   		array($Result["VMUsage"]["Rate"],$Result["VMUsage"]["Rate"]),
   		array("VM","VM"),
   		array("red","red"),1,0,0,0,time());

   echo "<br>";
   for ($i = 0; $i < 60; $i = $i + 1) {
      $x = $S["SlowPacketsTransmitted"]["Rate"][$i];
      if ($x == 0) {
         $SendSize[$i] = 0;
      } else {
         $SendSize[$i] = $S["SlowBytesTransmitted"]["Rate"][$i] / $x;
      }
      $x = $S["SlowPacketsReceived"]["Rate"][$i];
      if ($x == 0) {
         $RecvSize[$i] = 0;
      } else {
         $RecvSize[$i] = $S["SlowBytesReceived"]["Rate"][$i] / $x;
      }
   }
   if (array_sum($SendSize) != 0 || array_sum($RecvSize) != 0) {
      GraphPerfCountersLinked("Packet Sizes",
         array($SendSize,$RecvSize),
         array("Send","Recv"),
         array("red","red:1.5"),1,0,0,0,time());
   }
   if (array_sum($S["CompressionBootOuts"]["Rate"]) != 0) {
      GraphPerfCountersLinked("Boot Outs",
         array($S["CompressionBootOuts"]["Rate"]),
         array("Boots"),
         array("red"),1,0,0,0,time());
   }
   ?>

<br>




<!-- THIS IS THE MAIN SETTINGS BLOCK -->
<TABLE  class="width550" cellspacing="1">

	<!-- SYSTEM STATUS BLOCK -->
	<TR cellspacing="40" cellpading="40">
	<TD width="200" valign="top" align="right" class="caption_box">
		Orbital Status:&nbsp;&nbsp;
	</TD>

	<TD class="col-1">

		<TABLE width="100%">
		<FORM>
			<TR width="100%"><TD width="50%" align="left">
			<?php
				$PassThrough = GetParameter("PassThrough");
				if (!$PassThrough)
				{
					echo "<FONT color=\"red\" size=\"+1\">NORMAL</FONT>&nbsp;&nbsp;<br></TD>";
				}
				else
				{
					echo "<FONT color=\"red\" size=\"+1\">STOPPED</FONT>&nbsp;&nbsp;<br>";
				}
			?>
			</TD></TR>

		</FORM>
		</TABLE>
		<BR>
	</TD>
	</TR>

	<!-- SYSTEM THROUGHPUT BLOCK -->
	<TR bgcolor="#427bb5">
	<TD width="200" valign="top" align="right" class="caption_box">
		Throughput:&nbsp;&nbsp;
	</TD>

	<TD class="col-2">


		<TABLE><TR>
		<TD>
		   <?
		      $SendRate = GetParameter("SlowSendRate");
		      $RecvRate = GetParameter("SlowRecvRate");
		      $SplitRate = GetParameter("UI.UseSplitRates");
		      if (!$SplitRate) {
				   echo "Max: <B>" . FormatThroughput($SendRate). "</B>";
				} else {
				   echo "Max Send: <B> " . FormatThroughput($SendRate) . " </B> Max Recv: <B> " . FormatThroughput($RecvRate) . "</B>";
				}
		   ?>
			<br>
			<a href="bw_scheduler.php">Adjust Using BW Scheduler</a>
		</TD>

		</TR></TABLE>

	</TD>
	</TR>

</TR>
</TABLE>
</DIV>

<!-- DISPLAY THE CONNECTION LIST -->
<BR>
<?

if (GetParameter("UI.DisplayDebugInfo")) {

		$Result = OrbitalGet("CONNECTION",
									array("ClientLogicalAddress", "ClientPhysicalAddress",
									"ServerLogicalAddress", "ServerPhysicalAddress",
									"Duration", "InstanceNumber", "BytesTransferred", "IdleTime", "Accelerated", "Agent") );

		$AcceleratedConnections = 0;
		foreach ($Result as $OneConnection)
		{
			if ($OneConnection["Accelerated"]) $AcceleratedConnections++;
		}


	?>


		<TABLE class="width950" align="center">
			<TR align=center class="table_header"><TD colspan=8><?=$AcceleratedConnections?> Active Connections</TD></TR>
	<? if ($AcceleratedConnections != 0) { ?>
			<TR align=center class="table_header">
				<TD>Details</TD>
				<TD>Initiator</TD>
				<TD><=></TD>
				<TD>Responder</TD>
				<TD>Duration</TD>
				<TD>Idle</TD>
				<TD>Bytes Xfered</TD>
				<TD>Orbital Partner</TD>
			</TR>
	<? } ?>

	<?
		foreach ($Result as $OneConnection)
		{
			if ($OneConnection["Accelerated"]) {
				$ClientAddress = FormatIPAddressPort($OneConnection["ClientLogicalAddress"]);
				$ServerAddress = FormatIPAddressPort($OneConnection["ServerLogicalAddress"]);
				$Duration 	   = $OneConnection["Duration"];
				$InstanceNumber = $OneConnection["InstanceNumber"];
				$IdleTime = $OneConnection["IdleTime"];
				$BytesTransferred = $OneConnection["BytesTransferred"];
				if ($OneConnection["Agent"]["Accelerated"]) {
					$Agent = FormatAgent($OneConnection["Agent"]);
				} else {
					$Agent = "<i>None</i>";
				}
		?>
				<TR class="row-1">
					<TD align="center"><a href="./connection_info.php?InstanceNumber=<?=$InstanceNumber?>">
						<img src="./images/icon-info.gif" border="0" alt="Click Here For Detailed Connection Information"> </a></TD>
					<TD><?=$ClientAddress?></TD>
					<TD align="center"><=></TD>
					<TD><?=$ServerAddress?></TD>
					<TD align="center"><?=(int)$Duration?>&nbsp;Secs</TD>
					<TD align="center"><?=(int)$IdleTime?>&nbsp;Secs</TD>
					<TD align="center"><?=$BytesTransferred?></TD>
					<TD align="center"><?=$Agent?></TD>
				</TR>
	<?
			}
		}

	?>
		</TABLE>

   </TABLE>

<? } ?>

   <br> <br> <center> <h2> Detailed System Information</h2> </center>

   <TABLE class="width950" align="center">
      <TR align=center class="table_header">
         <TD>Attribute</TD>
         <TD>Value</TD>
      </TR>

   <?
		$System = OrbitalGet("SYSTEM",array(
			"Version", "ActiveRecvEndPoints", "DesiredRecvWindow",
			"AvailablePackets", "TotalPacketCount", "RecvWindowRatio", "InverseDecompressionRatio",
			"VMConsumption", "SocketCount", "SkbuffTotal", "SkbuffActive", "CifsPacketCount",
         "ProcessID", "CompressSendPacketCount", "CompressRecvPacketCount", "TotalCompressionRewinds", "TotalDecompressionRewinds",
         "TotalDecompressionRewindMisses",
         "TotalDecompressionRewindLosses",
         "RecentRate",
         "TotalCompressionBootOuts"
		));
      $System["VMPoolSize"] = GetParameter("System.MaxVMPoolSize");
      $ProcStatus = "/proc/" . $System["ProcessID"] . "/status";
      if (file_exists($ProcStatus)) {
         $ProcStatus = file($ProcStatus);
         foreach ($ProcStatus as $Line) {
            if (strncmp("Vm", $Line, 2) == 0) {
               $Tokens = split("[:\s]+", $Line);
               $System[array_shift($Tokens)] = implode(" ", $Tokens);
            }
         }
      }
      $Param["Class"] = "NORB_CONNECTION";
      $Param["InstanceCount"] = 0;
      $Param["FirstInstance"] = 0;
      $Instances = xu_rpc_http_concise(
                     array(
                        'method' => "GetInstances",
                        'args'   => $Param,
                        'host'   => RPC_SERVER,
                        'uri'    => RPC_URI,
                        'port'   => RPC_PORT
                     ));
      $System["Unaccelerated Connections"] = $Instances["Count"];

      $Param["Class"] = "CONNECTION";
      $Param["InstanceCount"] = 0;
      $Param["FirstInstance"] = 0;
      $Instances = xu_rpc_http_concise(
                     array(
                        'method' => "GetInstances",
                        'args'   => $Param,
                        'host'   => RPC_SERVER,
                        'uri'    => RPC_URI,
                        'port'   => RPC_PORT
                     ));
      $System["Accelerated Connections"] = $Instances["Count"];
      foreach ($System as $Label => $Value)
      {
      ?>
            <TR class="row-1">
               <TD align=center><?=$Label?></TD>
               <TD align=center><?=$Value?></TD>
            </TR>
      <?
      }
   ?>
   </TABLE>

</BODY>

<?	include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>

</HTML>

<?
//
// Copyright 2002,2003 Orbital Data Corporation
//
?>
