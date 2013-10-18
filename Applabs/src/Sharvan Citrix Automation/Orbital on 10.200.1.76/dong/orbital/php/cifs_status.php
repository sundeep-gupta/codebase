<? include("includes/header.php");  ?>

<?
   function SortIt($a,$b) {
      if ($a["IdleTime"] == $b["IdleTime"]) return 0;
      return $a["IdleTime"] > $b["IdleTime"] ? 1 : -1;
   }
   if (!$CifsVisible) {
     echo "<BR><BR>";
     echo "<center><img src='./images/warning-large.gif'></center>";
     ThrowException("This box is not licensed for CIFS acceleration!", false);
     echo " </td> <tr> </table>";
     include("footer.php");
     exit();
   }
   echo "<font class=pageheading>Monitoring: CIFS Status</font><BR><BR>";
   function CifsRow($h,$n) {
      echo "<TR> <TH align=center> ",
      	$h,
      	" </th> <td align=center> ",
      	$n,
      	" </td> </tr>";
   }
   $S = OrbitalGet("SYSTEM",
   		array("CifsUnacceleratedConnections",
   			"CifsUnhandledOperations",
   			"CifsProtocolErrors",
   			"CifsLockBreaks",
   			"CifsWriteIoErrors",
   			"CifsWriteBehindBytes",
   			"CifsDiscardedReadBytes",
   			"CifsReadAheadBytes",
   			"CifsActiveCount",
   			"CifsPassthroughCount"
   			));

   echo "<CENTER>";
   $RA = $S["CifsReadAheadBytes"]["Rate"];
   $DI = $S["CifsDiscardedReadBytes"]["Rate"];
   $WB = $S["CifsWriteBehindBytes"]["Rate"];
   echo "<br><br>";
   if ($S["CifsActiveCount"] || $S["CifsPassthroughCount"] != 0) {
#	   echo GraphPerfCounters("CIFS Accelerated Traffic",
#							array($RA, $DI, $WB),
#							array("Read","Unused", "Write"),
#							array("blue:1.5", "blue", "red"), 8, 0);
	   echo GraphPerfCounters("CIFS Accelerated READ Traffic",
							array($RA),
							array("Read"),
							array("dodgerblue4"), 8, 0);
           echo "<br><br><br>";
	   echo GraphPerfCounters("CIFS Accelerated WRITE Traffic",
							array($WB),
							array("Write"),
							array("dodgerblue4"), 8, 0);
           echo "<br><br><br>";
           echo "<DIV class=\"settings_table\">";
           echo "<center><TABLE>";
           CifsRow("Currently Active Accelerated Connections",$S["CifsActiveCount"]);
           CifsRow("Currently Active Non-accelerated Connections",$S["CifsPassthroughCount"]);
           if ($S["CifsUnacceleratedConnections"] != 0) CifsRow("Historically Non-accelerated Connections",$S["CifsUnacceleratedConnections"]);
           if ($S["CifsWriteIoErrors"] != 0) CifsRow("Historical write accelerated operations reporting errors",$S["CifsWriteIoErrors"]);
           if ($S["CifsUnhandledOperations"] != 0) CifsRow("Historical unhandled protocol operations",$S["CifsUnhandledOperations"]);
           if ($S["CifsProtocolErrors"] != 0) CifsRow("Historical protocol errors detected",$S["CifsProtocolErrors"]);
           if ($S["CifsLockBreaks"] != 0) CifsRow("Lock Breaks",$S["CifsLockBreaks"]);
           echo "</TABLE>";
           echo "</DIV>";

	   $CifsInstances = GetInstances("CIFS");
	   $Conns = OrbitalGet("CIFS",array("ConnectionInstanceNumber","TotalReadAheadBytes","TotalWriteBehindBytes","Passthrough"),
	   				$CifsInstances["Instances"]);
       $CifsConnections = array();
       foreach($Conns as $OneCon) {
          array_push($CifsConnections,$OneCon["ConnectionInstanceNumber"]);
       }
	   $Attributes = array("ClientLogicalAddress", "ClientPhysicalAddress",
                           "ServerLogicalAddress", "ServerPhysicalAddress",
                           "Duration", "InstanceNumber", "BytesTransferred", "IdleTime", "Accelerated", "Agent", "FilterInstanceNumber");
	   $Cifs = OrbitalGet("CONNECTION",$Attributes,$CifsConnections);
	   //
	   // Now, graft the Totals onto the specific instances
	   //
	   $i = 0;
       foreach($Conns as $OneCon) {
          $Cifs[$i]["TotalReadAheadBytes"] = $OneCon["TotalReadAheadBytes"];
          $Cifs[$i]["TotalWriteBehindBytes"] = $OneCon["TotalWriteBehindBytes"];
          $Cifs[$i]["CifsPassthrough"] = $OneCon["Passthrough"];
          $i = $i + 1;
       }
       //
       // Now sort into the two bins, pipelined and unpipelined connections
       //
       $Pipe = array();
       $Unpipe = array();
	   foreach($Cifs as $OneCon) {
	      if ($OneCon["CifsPassthrough"] == 1) {
	         array_push($Unpipe,$OneCon);
	      } else {
	         array_push($Pipe,$OneCon);
	      }
	   }

	   if (sizeof($Unpipe) != 0) {
	      //
	      // List the unaccelerated connections (or at least the first ten)
	      //
	      usort($Unpipe,"SortIt");
	      ?>
	         <BR><BR>
	         <TABLE width=100%>
	         <tr> <th colspan=7><?=sizeof($Unpipe)?> Non-accelerated CIFs Connection(s) </th></tr>
	         <tr>
	         	<th>Details</th>
	         	<th>Client</th>
	         	<th></th>
	         	<th>Server</th>
	         	<th>Duration</th>
	         	<th>Idle</th>
		        <TH><?=ProdName()?> Partner</TH>
		     </tr>
	      <?
	      for ($i = 0; $i < 10 && $i < sizeof($Unpipe); $i = $i + 1) {
	         $OneConnection = $Unpipe[$i];
			 $ClientAddress = FormatIPAddressPort($OneConnection["ClientLogicalAddress"]);
			 $ServerAddress = FormatIPAddressPort($OneConnection["ServerLogicalAddress"]);
			 $BytesTransferred = $OneConnection["BytesTransferred"];
			 if ($OneConnection["Agent"]["Accelerated"]) {
				$Agent = FormatAgent($OneConnection["Agent"]);
			 } else {
				$Agent = "<i>None</i>";
			 }
			 $Duration      = $OneConnection["Duration"];
			 $InstanceNumber = $OneConnection["InstanceNumber"];
			 $IdleTime = $OneConnection["IdleTime"];
		   ?>
				 <TR>
					<TD align=center><a href="./connection_info.php?InstanceNumber=<?=$InstanceNumber?>">
					   <img src="./images/icon-info.gif" border="0" alt="Click Here For Detailed Connection Information"> </a></TD>
					<TD><?=$ClientAddress?></TD>
					<TD align="center"><=></TD>
					<TD><?=$ServerAddress?></TD>
					<TD align="center"><?=(int)$Duration?>&nbsp;secs</TD>
					<TD align="center"><?=(int)$IdleTime?>&nbsp;secs</TD>
					<TD align="center"><?=$Agent?></TD>
				 </TR>
		   <?
	      }
	      echo "</table>";
	   }

?>
   <BR><BR>
   <TABLE width=100%>
<? if (sizeof($Pipe) != 0) { ?>
      <TR><TH colspan=9><?=sizeof($Pipe)?> Accelerated Cifs Connections</TH></TR>
      <TR>
         <TH>Details</TH>
         <TH>Client</TH>
         <TH></TH>
         <TH>Server</TH>
         <TH>Duration</TH>
         <TH>Idle</TH>
         <TH>Read</TH>
         <TH>Write</TH>
         <TH><?=ProdName()?> Partner</TH>
      </TR>
<? }else{
      echo "<TR><TH>Non-accelerated Cifs Connections</TH></TR>";
   }
?>
<?
   usort($Pipe,"SortIt");
   foreach ($Pipe as $OneConnection)
   {
         $ClientAddress = FormatIPAddressPort($OneConnection["ClientLogicalAddress"]);
         $ServerAddress = FormatIPAddressPort($OneConnection["ServerLogicalAddress"]);
         $BytesTransferred = $OneConnection["BytesTransferred"];
         if ($OneConnection["Agent"]["Accelerated"]) {
            $Agent = FormatAgent($OneConnection["Agent"]);
         } else {
            $Agent = "<i>None</i>";
         }
         $Duration      = $OneConnection["Duration"];
         $InstanceNumber = $OneConnection["InstanceNumber"];
	     $IdleTime = $OneConnection["IdleTime"];
   ?>
         <TR>
            <TD align=center><a href="./connection_info.php?InstanceNumber=<?=$InstanceNumber?>">
               <img src="./images/icon-info.gif" border="0" alt="Click Here For Detailed Connection Information"> </a></TD>
            <TD><?=$ClientAddress?></TD>
            <TD align="center"><=></TD>
            <TD><?=$ServerAddress?></TD>
            <TD align="center"><?=(int)$Duration?>&nbsp;secs</TD>
            <TD align="center"><?=(int)$IdleTime?>&nbsp;secs</TD>
            <TD align="center"><?=FormatBytes($OneConnection["TotalReadAheadBytes"])?></TD>
            <TD align="center"><?=FormatBytes($OneConnection["TotalWriteBehindBytes"])?></TD>
            <TD align="center"><?=$Agent?></TD>
         </TR>
   <?
   }
   }
   echo "</CENTER>";

?>

<? include(HTTP_ROOT_INCLUDES_DIR . "footer.php"); ?>
