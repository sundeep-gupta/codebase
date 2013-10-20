<?
   include_once("includes/header.php");
   include_once("performance_profiler_lib.php");
   $Auth->CheckRights(AUTH_LEVEL_VIEWER);

   //
   // Reset the stats
   // 
	if (isset($_GET["ResetStats"])) {
      CallRPCMethod("ResetPerfCounters");
      CallRPCMethod("ServiceClassResetCounter");      
      CallRPCMethod("ResetSimulatedCompressionStats");
      echo HTML::InsertRedirect();
		exit();
   }   
   
   //
   // Set the system line speed
   //
   if (isset($_GET["LineSpeed"])){
      SetParameter("SlowSendRate", 1000 * (int)$_GET["LineSpeed"]);
   }
   $SlowSendRate = (int)(GetParameter("SlowSendRate"));
   
   
   //
   // Do the actual setting of Simulator.LANIPs
   //
   //
   $LANIPs = GetParameter("Simulator.LANIPs");
   if (isset($_GET["FormName"]) && $_GET["FormName"]=="LANIPs"){
      if (isset($_GET["Add"])){
         $NewIPMask["Display"] = $_GET["NewIPMask"];
         array_push($LANIPs, $NewIPMask);
      }
      else if (isset($_GET["Delete"])){
         $IPMaskToDelete = $_GET["LANIPs"];

         $NewResults = array();
         foreach ($LANIPs as $IPMask){
            if ($IPMask["Display"] != $IPMaskToDelete){
               array_push($NewResults, $IPMask);
            }
         }
         $LANIPs = $NewResults;
      }

      SetParameter("Simulator.LANIPs", $LANIPs);
      echo HTML::InsertRedirect();     
   }   

   if (isset($_GET["DisplayGraphFor"])){
         SetParameter("UI.Graph.Duration", $_GET["DisplayGraphFor"]);
      }
      $GraphDisplayDuration = GetParameter("UI.Graph.Duration");


   if (max($UncompAvgLineSpeedSent, $UncompAvgLineSpeedRecv) > $SlowSendRate){
      echo "<FONT color='red' size='+1'>Warning: your line usage appears to be higher<BR> then the WAN link speed you configured!</FONT><BR><BR>";
   }
?>
   


   <?
         //
         // If there are no LANIPs configured, the UI does not disembiguate
         // between outbound and inbound traffic, just uncompressed and compressed traffic
         //   
         $Bidirectional = (sizeof($LANIPs) !=0);
   ?>
   
   <font class=pageheading>Monitoring: Performance Profiler: Compression Ratio</font><BR><BR>
   <TABLE>
      <? if ($Bidirectional){ ?>
               <TR><TH>Compression Ratio (Outbound Traffic):</TH><TD><?=$CompRatioSent?></TD></TR>
               <TR><TH>Compression Ratio (Inbound Traffic):</TH><TD><?=$CompRatioRecv?></TD></TR>
      <? }else{ ?>
               <TR><TH>Compression Ratio:</TH><TD><?=$CompRatioSent?></TD></TR>
      <? } ?>

      <TR></TR>
      <TR><TH>Elapsed Time Collecting Stats:</TH><TD><?=ToPrintableTime($TimeSincePerfCounterReset)?></TD></TR>

      <TR></TR>
      <TR><TH>Clear These Compression Stats:</TH>
            <TD>
               <FORM name="ResetStats"><INPUT type="submit" name="ResetStats" value="Clear"></INPUT></FORM>
            </TD>
      </TR>
   </TABLE>

   <BR><BR>
   <font class=pageheading>Monitoring: Performance Profiler: Network Graph</font><BR><BR>
   <?
      echo
         ShowCompressionFlowDiagram(FormatBytes($UncompBytesSent) . " @\n" . FormatThroughput($UncompAvgLineSpeedSent), 
                                    FormatBytes($UncompBytesRecv) . " @\n" . FormatThroughput($UncompAvgLineSpeedRecv), 
                                    FormatBytes($CompBytesSent) .   " @\n" . FormatThroughput($CompAvgLineSpeedSent), 
                                    FormatBytes($CompBytesRecv) .   " @\n" . FormatThroughput($CompAvgLineSpeedRecv),
                                    $Bidirectional);
   ?>
   

   </DIV class="settings_table">

   <BR><BR>
   <font class=pageheading>Monitoring: Performance Profiler: Line Utilization</font><BR><BR>
  
   <DIV class=no_formatting>
   <TABLE>
      <TR><TD align=center><IMG src="images/before_after_compression_legend.png"></TD></TR>
      <TR><TD>
<?
   //
   // Graph the Uncompresed/Compressed throughput versus time
   //
   if ($GraphDisplayDuration == "day"){
      $Output = GraphPerfCounters("Last Day " . ($Bidirectional ? "(Outbound)":""), array($SimData["TieredUncompressedBytesSent"]["LastDay"]["Rate"], $SimData["TieredCompressedBytesSent"]["LastDay"]["Rate"]),
                         array("Uncompressed Bytes Sent","Compressed Bytes Sent"),
                         array(COLOR_PASS_BYTES, COLOR_PAYLOAD_BYTES), 8, 0, -1, 0, RESOLUTION_ONE_DAY);
      echo $Output . "<BR><BR>";

      if ($Bidirectional){
         $Output = GraphPerfCounters("Last Day (Inbound)", array($SimData["TieredUncompressedBytesRecv"]["LastDay"]["Rate"], $SimData["TieredCompressedBytesRecv"]["LastDay"]["Rate"]),
                            array("Uncompressed Bytes Sent","Compressed Bytes Sent"),
                            array(COLOR_PASS_BYTES, COLOR_PAYLOAD_BYTES), 8, 0, -1, 0, RESOLUTION_ONE_DAY);
         echo $Output . "<BR><BR>";
      }
      
   } else if ($GraphDisplayDuration == "hour"){
      $Output = GraphPerfCounters("Last Hour " . ($Bidirectional ? "(Outbound)":""), array($SimData["TieredUncompressedBytesSent"]["LastHour"]["Rate"], $SimData["TieredCompressedBytesSent"]["LastHour"]["Rate"]),
                         array("Uncompressed Bytes Sent","Compressed Bytes Sent"),
                         array(COLOR_PASS_BYTES, COLOR_PAYLOAD_BYTES), 8, 0, -1, 0, RESOLUTION_ONE_HOUR);
      echo $Output . "<BR><BR>";

      if ($Bidirectional){
         $Output = GraphPerfCounters("Last Hour (Inbound)", array($SimData["TieredUncompressedBytesRecv"]["LastHour"]["Rate"], $SimData["TieredCompressedBytesRecv"]["LastHour"]["Rate"]),
                            array("Uncompressed Bytes Sent","Compressed Bytes Sent"),
                            array(COLOR_PASS_BYTES, COLOR_PAYLOAD_BYTES), 8, 0, -1, 0, RESOLUTION_ONE_HOUR);
         echo $Output . "<BR><BR>";
      }
   } else if ($GraphDisplayDuration == "minute"){
   
      $Output = GraphPerfCounters("Last Minute " . ($Bidirectional ? "(Outbound)":""), array($SimData["TieredUncompressedBytesSent"]["LastMinute"]["Rate"], $SimData["TieredCompressedBytesSent"]["LastMinute"]["Rate"]),
                         array("Uncompressed Bytes Sent","Compressed Bytes Sent"),
                         array(COLOR_PASS_BYTES, COLOR_PAYLOAD_BYTES), 8, 0, -1, 0, RESOLUTION_ONE_MINUTE);
      echo $Output . "<BR><BR>";
      
      if ($Bidirectional){      
         $Output = GraphPerfCounters("Last Minute (Inbound)", array($SimData["TieredUncompressedBytesRecv"]["LastMinute"]["Rate"], $SimData["TieredCompressedBytesRecv"]["LastMinute"]["Rate"]),
                            array("Uncompressed Bytes Sent","Compressed Bytes Sent"),
                            array(COLOR_PASS_BYTES, COLOR_PAYLOAD_BYTES), 8, 0, -1, 0, RESOLUTION_ONE_MINUTE);
         echo $Output . "<BR><BR>";
      }
   }else{
      ThrowException("GraphDisplayDuration was invalid", true);
   }
?>
   </TD></TR></TABLE></DIV>
<?
   //
   // Show line utilization by protocol
   //
?>
   <BR><BR>
   <font class=pageheading>Monitoring: Performance Profiler: Service Classes</font><BR><BR>
   
<?
   $XMLStats = CallRPCMethod("ServiceClassGetStat" );
   $ServiceClassData = array();
   foreach ($XMLStats as $XMLStat){
      $ServiceClass = new SERVICE_CLASS($XMLStat["ClassName"],
                                        $XMLStat["UserCounters"]["LANFlowControlSendBytes"],
                                        $XMLStat["UserCounters"]["LANFlowControlReceiveBytes"],
                                        $XMLStat["UserCounters"]["WANFlowControlSendBytes"],
                                        $XMLStat["UserCounters"]["WANFlowControlReceiveBytes"] );

      array_push($ServiceClassData, $ServiceClass);
   }
   GraphProtocolBytes($ServiceClassData);
   echo "<BR><BR>";


   //
   // Break down traffic by service class
   //
?>
   <BR><BR>
   <font class=pageheading>Monitoring: Performance Profiler: Capacity Expansion</font><BR><BR>

<?
   //
   // Graph the bandwidth expansion
   //
   $UncompressedBytes       = 7000 * 1000;
   $WithTotalTransportBytes = 10000 * 1000;
   $CompressedBytes         = 13000 * 1000;
	GraphCompressionBytes("Expanded Throughput", "compression_bar",
                         array("Without\nOrbital Data", "With\nOrbital Data"),
                         array(max($UncompAvgLineSpeedSent, $UncompAvgLineSpeedRecv), $TTSpeed,));

?>
