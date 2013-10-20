<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);

   $showCombineGraph = GetParameter("UI.Graph.CombineCompressionSendRevcGraph");
   $showCompRatioGraph = GetParameter("UI.Graph.ShowCompressedRatio");
?>
<?
      //
      // Display Graph auto refresh toggle
      //
      $GraphRefreshRate = GetParameter("UI.Graph.RefreshRate", GRAPH_DEFAULT_REFRESH_RATE);
      $AutoRefresh      = GetParameter("UI.Graph.AutoRefresh", 0);

      if (isset($_GET["ToggleAutoRefresh"]))
      {
         $AutoRefresh = !$AutoRefresh;
         SetParameter("UI.Graph.AutoRefresh", $AutoRefresh);
      }

      if ($AutoRefresh){
         echo HTML::InsertRedirect("./compression_graph.php", $GraphRefreshRate);
      }

?>

   <BODY>
      <div align="center">
         Auto-refresh <B><?=$AutoRefresh?"ON":"OFF"?></B>: <A href="./throughput.php?ToggleAutoRefresh">Toggle</A>

         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A href="javascript:show_popup_graph()" alt="foo">Popup Graph</a>

         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <A href="./ui_configuration.php">Graph Settings</A>

      <BR><BR>

<?
   //
   // Graph the Uncompresed/Compressed throughput versus time
   //
   $Output = GraphPerfCounters("Line Usage Before and After Compression (Bytes Sent)", array($SimData["UncompressedBytesSent"]["Rate"], $SimData["CompressedBytesSent"]["Rate"]),
                      array("Uncompressed Bytes Sent","Compressed Bytes Sent"),
                      array(COLOR_PASS_BYTES, COLOR_PAYLOAD_BYTES), 8);
   echo $Output . "<BR><BR>";

   $Output = GraphPerfCounters("Line Usage Before and After Compression (Bytes Recv)", array($SimData["UncompressedBytesRecv"]["Rate"], $SimData["CompressedBytesRecv"]["Rate"]),
                      array("Uncompressed Bytes Recv","Compressed Bytes Recv"),
                      array(COLOR_PASS_BYTES, COLOR_PAYLOAD_BYTES), 8);
   echo $Output . "<BR><BR>";

include(HTTP_ROOT_INCLUDES_DIR ."footer.php");

?>
