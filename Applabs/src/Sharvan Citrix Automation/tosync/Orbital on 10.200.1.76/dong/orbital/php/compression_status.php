<?
   define('PAGE_REQUIRES_COMPRESSION_LICENSE', true);
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_VIEWER);

   function DrawCompressionBarChart($data, $chartname, $title){
		// Create the graph. These two calls are always required
		$graph = new Graph(300, 200,"auto");
		$graph->SetScale("textlin");

		// Adjust the margin a bit to make more room for titles
		$graph->img->SetMargin(20,20,40,40);
		$graph->SetMarginColor('white');

		// Create a bar pot
		$bplot = new BarPlot($data);

		// Adjust fill color
		$bplot->SetFillColor('orange');

		// Setup values
		$bplot->value->Show();
		$bplot->value->SetFormatCallback('FormatBytes');
		$bplot->value->SetFont(FF_FONT1,FS_BOLD);
		$bplot->SetFillColor( array(COLOR_PASS_BYTES, COLOR_PAYLOAD_BYTES,
                                  COLOR_PASS_BYTES, COLOR_PAYLOAD_BYTES) );

		// Make the bar a little bit wider
		$bplot->SetWidth(0.3);

		$graph->Add($bplot);

		// Setup the titles
		$graph->title->SetFont(FF_FONT2,FS_BOLD);
		$graph->title->Set($title);
		$graph->yaxis->Hide();
		$graph->xaxis->SetTickLabels( array("Uncompressed", "Compressed") );
      $graph->xaxis->SetLabelAlign("center", "top", "center");
		$graph->xaxis->SetFont(FF_FONT2,FS_BOLD);

		// Display the graph
		$graph->Stroke("temp/" . $chartname . "_graph.png");
		echo "   <IMG src='./temp/" . $chartname . "_graph.png?NoCache=" . time() . "'>";
	}

   $CompressionStats = OrbitalGet("SYSTEM",
         array("CompressConnectionCount",
               "CompressionClearTextBytes",
               "CompressionCipherTextBytes",
               "DecompressionClearTextBytes",
               "DecompressionCipherTextBytes",
               "TimeSincePerfCounterReset"
            ));

   $UncompressedSent = $CompressionStats["CompressionClearTextBytes"]["Total"];
   $CompressedSent   = $CompressionStats["CompressionCipherTextBytes"]["Total"];

   $UncompressedRecv = $CompressionStats["DecompressionClearTextBytes"]["Total"];
   $CompressedRecv   = $CompressionStats["DecompressionCipherTextBytes"]["Total"];

   $TimeSincePerfCounterReset = (int)$CompressionStats["TimeSincePerfCounterReset"];

   /* TEST DATA
  	$UncompressedSent = 500 * 10000;
  	$CompressedSent	= 400 * 10000;
  	$UncompressedRecv = 900 * 10000;
  	$CompressedRecv   = 850 * 10000;
   */
   $SendCompRatio    = FormatRatio($UncompressedSent,	$CompressedSent);
   $RecvCompRatio    = FormatRatio($UncompressedRecv, $CompressedRecv);

   $SlowSendRate        = GetParameter("SlowSendRate");
   if (($CompressedSent + $CompressedRecv) != 0) {
      $EffectiveThroughput = (($UncompressedSent + $UncompressedRecv) / ($CompressedSent + $CompressedRecv)) * $SlowSendRate;
   }else{
      $EffectiveThroughput = "N/A";
   }

	if (isset($_GET["ResetStats"])) {
      CallRPCMethod("ResetPerfCounters");
      echo HTML::InsertRedirect("./compression_status.php",2);
		exit();
   }

?>

   <font class=pageheading>Monitoring: Compression Status</font><BR><BR>

   <DIV class="settings_table">
	<TABLE>
		<TR><TH>Uncompressed Bytes Sent:</TH> <TD><?=FormatBytes($UncompressedSent)?></TD></TR>
		<TR><TH>Compressed Bytes Sent:</TH>   <TD><?=FormatBytes($CompressedSent)?></TD></TR>
		<TR><TH>Send Compression Ratio:</TH><TD><?=$SendCompRatio?></TD></TR>

		<TR></TR>
		<TR><TH>Uncompressed Bytes Recv:</TH> <TD><?=FormatBytes($UncompressedRecv)?></TD></TR>
		<TR><TH>Compressed Bytes Recv:</TH>   <TD><?=FormatBytes($CompressedRecv)?></TD></TR>
		<TR><TH>Recv Compression Ratio:</TH><TD><?=$RecvCompRatio?></TD></TR>

		<TR></TR>
		<TR><TH>Effective Bandwidth:</TH><TD><?=FormatThroughput($EffectiveThroughput)?></TD></TR>

		<TR></TR>
		<TR><TH>Elapsed Time Collecting Stats:</TH><TD><?=ToPrintableTime($TimeSincePerfCounterReset)?></TD></TR>

		<TR></TR>
		<TR><TH>Clear These Compression Stats:</TH>
            <TD>
               <FORM name="ResetStats"><INPUT type="submit" name="ResetStats" value="Clear"></INPUT></FORM>
            </TD>
      </TR>

   </TABLE>
	<DIV class="settings_table">

   <BR><BR>
   <font class=pageheading>Monitoring: Compression Status: Data Before And After Compression</font><BR><BR>
<?
	DrawCompressionBarChart( array($UncompressedSent, $CompressedSent), "compression_send_graph", "Bytes Sent");
	DrawCompressionBarChart( array($UncompressedRecv, $CompressedRecv), "compression_recv_graph", "Bytes Received");

?>
<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
