<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_VIEWER);

   if ( (isset($_GET["DisableOrbital"])) || (isset($_GET["EnableOrbital"]) ) )
   {
      $Auth->CheckRights(AUTH_LEVEL_ADMIN);

      if ( isset($_GET["DisableOrbital"]) ) { SetParameter("PassThrough", true); }
      if ( isset($_GET["EnableOrbital"] ) )  { SetParameter("PassThrough", false); }
      
      echo HTML::InsertRedirect("./status.php", 0);
   }
   $OrbitalEnabled = !GetParameter("PassThrough");
   $ResetExisting = GetParameter("ResetExistingSessions");
   $SoftboostEnable = isSoftboost();
?>

<font class="pageheading">Monitoring: System Status</font><BR><BR>
<DIV class="settings_table">

<TABLE width="600">

   <!-- SYSTEM STATUS BLOCK -->
   <TR>
   <TH>
      <?=ProdName()?>  Status:&nbsp;&nbsp;
   </TH>

   <TD>
      <FORM name="Enable" action="./status.php">

      <? if ($OrbitalEnabled)
         { ?>
            <FONT color="blue" size="+1">NORMAL</FONT>&nbsp;&nbsp;
            <INPUT type="submit" name="DisableOrbital" value="Disable"></INPUT>
      <? }
         else
         {?>
            <FONT color="red" size="+1">DISABLED</FONT>&nbsp;&nbsp;
            <INPUT type="submit" name="EnableOrbital" value="Enable">
      <? } ?>
      </FORM>

   </TD>
   </TR>


   <!-- SYSTEM MODE BLOCK -->
   <SCRIPT>
   <!--
      function onModeChange(Me, Question){
         if (!confirm(Question)){
            return false;
         }
         
         var subform = Me.form;
         subform.submit();
         return true;
      }
      // -->
   </SCRIPT>
   
   <TR>
   <TH>
      Mode:&nbsp;&nbsp;
   </TH>

   <TD>
      <?
         if (isset($_GET["SysMode"])){
            if ($_GET["SysMode"] == "NormalMode"){ $SimMode = false;}
            else                                 { $SimMode = true;}
            SetParameter("Simulator.Enabled", $SimMode);
            echo HTML::InsertRedirect();
         }
        $SimMode = GetParameter("Simulator.Enabled");
      ?>
      <FORM name="SystemMode">
         <INPUT type=radio name=SysMode value=NormalMode <?=!$SimMode?" CHECKED ":""?>
                  onClick="return onModeChange(this, 'Are you sure you wish to switch back to normal acceleration mode?')">
                  Normal Mode&nbsp;&nbsp;&nbsp;&nbsp;
         <INPUT type=radio name=SysMode value=SimMode    <?= $SimMode?" CHECKED ":""?>
                  onClick="return onModeChange(this, 'Are you sure you wish to switch to Performance Profiler mode? (Doing so will cause traffic to be monitored but NOT accelerated.)')">
                  Performance Profiler Mode
      </FORM>
   </TD>
   </TR>


   <!-- SYSTEM THROUGHPUT BLOCK -->
   <TR>
   <TH>
      Throughput:
   </TH>

   <TD>
      <?
         $Result = OrbitalGet("LIMIT", "MAXSENDRATE");
         $MaxAllowedSendRate = $Result["MAXSENDRATE"];
         if(!$SoftboostEnable)
         {
            $SplitRates = GetParameter("UI.UseSplitRates");
            $SendRate = GetMaxSendRate();
            $RecvRate = GetMaxRecvRate();
            if ($SplitRates) {
               echo "&nbsp;Current Send: <B> ".FormatThroughput($SendRate). " </B><br>";
               echo "&nbsp;Current Recv: <B> ".FormatThroughput($RecvRate). " </B><br>";
            } else {
               echo "&nbsp;Current: <B> ".FormatThroughput($SendRate). " </B>";
            }
         }
      ?>
      &nbsp;License Limit:     <B> <?= FormatThroughput($MaxAllowedSendRate) ?></B><BR>
      &nbsp;<a href="bw_scheduler.php">Adjust Using Bandwidth Management</a>
   </TD>
   </TR>

   <!-- SYSTEM UPTIME TIME -->
   <TR>
   <TH>
      Up Time:
   </TH>
   <TD><?=ToPrintableTime((int)GetSystemParam("UpTime"))?></TD>
   </TD>
   </TR>

   <!-- BANDWIDTH MODE -->
   <TR>
   <TH>
      Bandwidth Mode:
   </TH>
   <TD><?if($SoftboostEnable) {echo 'Softboost';}
         else {
            echo (GetParameter("Adapter.PassthroughTrafficAccount") ? 'Hardboost: <b>Partial Bandwidth</b>' : 'Hardboost: <b>Full Bandwidth</b>');
         }?></TD>
   </TD>
   </TR>

   <!-- Number of Active/Inactive connections -->
   <?
   $Param["Class"] = "NORB_CONNECTION";
   $Param["InstanceCount"] = 0;
   $Param["FirstInstance"] = 0;
   $Instances = xu_rpc_http_concise(
                  array(
                     'method' => "GetInstances",
                     'args'      => $Param,
                     'host'      => RPC_SERVER,
                     'uri'    => RPC_URI,
                     'port'      => RPC_PORT
                  ));
   $NumUnaccelConnections = $Instances["Count"];


   $Param["Class"] = "CONNECTION";
   $Param["InstanceCount"] = 0;
   $Param["FirstInstance"] = 0;
   $Instances = xu_rpc_http_concise(
                  array(
                     'method' => "GetInstances",
                     'args'      => $Param,
                     'host'      => RPC_SERVER,
                     'uri'    => RPC_URI,
                     'port'      => RPC_PORT
                  ));
   $NumAccelConnections = $Instances["Count"];
   ?>
   <TR>
   <TH>
      Active Connections:
   </TH>
   <TD>
      Accelerated Connections: <B><?=$NumAccelConnections?></B><BR>
      Unaccelerated Connections: <B><?=$NumUnaccelConnections?></B><BR>
   </TD>
   </TR>

   <!-- Software Version -->
   <TR>
   <TH>
      Software Version:
   </TH>
   <TD>
      <B><?=GetSystemParam("Version")?></B><BR>
   </TD>
   </TR>
<?
/*
   <!-- System Hardware -->
   <TR>
   <TH>
      System Hardware:
   </TH>
   <TD>
      <B><?=GetSystemParam("SystemHardwareType")?></B><BR>
   </TD>
   </TR>
*/
?>
   <!-- FTW Card Type -->
   <TR>
   <TH>
      FTW Card Type:
   </TH>
   <TD>
      <B><?=GetSystemParam("FTWCardType")?></B><BR>
   </TD>
   </TR>

</TABLE>
</DIV>

<?
//
// If we are in SuperUser mode, several other graphs are displayed
//
if ($Auth->IsSuperUser()){
   $Result = OrbitalGet("SYSTEM",
   		array(	"MainCPUIdleTime","MainCPUUsageTime",
   				"FastWindowStops","SlowWindowStops",
   				"FastWindowZeros","SlowWindowZeros",
   				"FastRTOs",		  "SlowRTOs", "VMUsage",
	   			"CompressionClearTextBytes", "CompressionCipherTextBytes", "DecompressionClearTextBytes", "DecompressionCipherTextBytes"
   				));
   if (GetLimit("Tcp.Compression")) {
		echo "<br>";
		GraphPerfCountersLinked("Compression",
			array($Result["CompressionClearTextBytes"]["Rate"],$Result["CompressionCipherTextBytes"]["Rate"]),
			array("Uncompressed","Compressed"),
			array("blue","blue:1.5"),8,0,0,0,time());
		echo "<br>";
		GraphPerfCountersLinked("Distant Compression",
			array($Result["DecompressionClearTextBytes"]["Rate"],$Result["DecompressionCipherTextBytes"]["Rate"]),
			array("Uncompressed","Compressed"),
			array("blue","blue:1.5"),8,0,0,0,time());
   }
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
   if (array_sum($Result["FastWindowStops"]["Rate"]) != 0 ||
       array_sum($Result["SlowWindowStops"]["Rate"]) != 0) {
	    echo "<br>";
   		GraphPerfCountersLinked("Window Stops",
   	       	 array($Result["FastWindowStops"]["Rate"],$Result["SlowWindowStops"]["Rate"]),
   		     array("Fast","Slow"),
   		     array("red","red:1.5"),1,0,0,0,time());
   }
   if (array_sum($Result["FastWindowZeros"]["Rate"]) != 0 ||
       array_sum($Result["SlowWindowZeros"]["Rate"]) != 0) {
	    echo "<br>";
   		GraphPerfCountersLinked("Window Zeros",
   	       	 array($Result["FastWindowZeros"]["Rate"],$Result["SlowWindowZeros"]["Rate"]),
   		     array("Fast","Slow"),
   		     array("red","red:1.5"),1,0,0,0,time());
   }

   if (array_sum($Result["FastRTOs"]["Rate"]) != 0 ||
       array_sum($Result["SlowRTOs"]["Rate"]) != 0) {
	    echo "<br>";
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

   $System = OrbitalGet("SYSTEM",array(
      "Version", "ActiveRecvEndPoints", "DesiredRecvWindow",
      "AvailablePackets", "TotalPacketCount", "RecvWindowRatio",
      "VMConsumption", "SocketCount", "SkbuffTotal", "SkbuffActive", "CifsPacketCount"
   ));
   $System["VMPoolSize"] = GetParameter("System.MaxVMPoolSize");
   echo "<TABLE>";
   foreach ($System as $Label => $Value)
   {
      ?>
            <TR>
               <TH><?=$Label?></TH>
               <TD><?=$Value?></TD>
            </TR>
      <?
   }
   echo "</TABLE>";
}
?>


<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
