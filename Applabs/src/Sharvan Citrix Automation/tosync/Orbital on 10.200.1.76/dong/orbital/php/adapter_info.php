<?
   include("includes/header.php");

   if (isset($_GET["InstanceNumber"]))
   {
      $InstanceNumber = (int)$_GET["InstanceNumber"];
   }
   else
   {
      ThrowException("Instance Number not specified on get request line.",true);
   }

   $Adapter = OrbitalGet("ADAPTER", "", $InstanceNumber);

   if (array_key_exists("Fault",$Adapter)) {
      ThrowException("Adapter Instance " . $InstanceNumber . " Not Found",true);
   }

   
?>

<font class="pageheading">Detailed Information For Adapter <?=$Adapter["DisplayName"]?></font><br><br>

<?
   $Grapher = new PERF_GRAPHER();
   $Grapher->LoadData("ADAPTER", (int)$_GET["InstanceNumber"]);
   echo $Grapher->Render();


if (0) {

?>

<br><br> <h2> <center> Loss Statistics </center> </h2>
<?
   //
   // Show Loss Statistic
   //
   $LossPercent = array();
   for ($i=0;
        $i < sizeof($Adapter["PacketsTransmitted"]["Rate"]) -1;
        $i++)
   {
      if ($Adapter["PacketsTransmitted"]["Rate"][$i] > 0)
      {
         $LossPercent[$i] = ($Adapter["PacketsTransmitted"]["Rate"][$i] -
                             $Adapter["PacketsTransmittedGood"]["Rate"][$i])  /
                            $Adapter["PacketsTransmitted"]["Rate"][$i];
         $LossPercent[$i] = $LossPercent[$i] * 100;
      }
      else
      {
         $LossPercent[$i] = 0;
      }
   }

   GraphPerfCounters("Percent Loss",
                     array($LossPercent),
                     array("Percent Loss"),
                     array("darkgreen"));
}
?>


<?
   //
   // Show FEC Graph
   //
   if ($Adapter["TotalFECBytesCorrected"] != 0) {

      ECHO "<br> <h2> <center> FEC Statistics </center> </h2>";

      GraphPerfCounters("WAN Correction",
                        array($Adapter["FECBytesCorrected"]["Rate"], $Adapter["PayloadReceivedGood"]["Rate"]),
                        array("Dynamically Corrected Bits","Goodput Bits"),
                        array("red:1.5", "red"), 8, 0);

   }
?>

   <CENTER>
   <BR>
   <DIV class=settings_table>
   <TABLE>
<?
   $Info = AdapterInfo($Adapter,$InstanceNumber);
   foreach ($Info as $Label => $Value)
   {
?>
      <TR class="row-1">
         <TH><?=$Label?></TH>
         <TD align=center><?=$Value?></TD>
      </TR>
<? } ?>
   </TABLE>
   </DIV>
   </CENTER>
