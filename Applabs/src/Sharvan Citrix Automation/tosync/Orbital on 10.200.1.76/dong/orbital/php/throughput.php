<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_VIEWER);
?>

      <script language="javascript">
      <!--//
      function show_popup_graph()
      {
         window.open("./popup_graph.php","_blank","toollbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=no,resizable=yes,width=620,height=320");
      }  
      //-->
      </script>

<?
      //
      // Display Graph auto refresh toggle
      //
      $GraphRefreshRate = GetParameter("UI.Graph.RefreshRate");
      $AutoRefresh      = GetParameter("UI.Graph.AutoRefresh");

      if (isset($_GET["ToggleAutoRefresh"]))
      {
         $AutoRefresh = !$AutoRefresh;
         SetParameter("UI.Graph.AutoRefresh", $AutoRefresh);
      }
?>
   <? //
      // This code refreshes all of the graphs on the page without redrawing the page.
      // It updates the graphs by having one of the images actually point back at this page.
   ?> 
   <script type="text/javascript">
      function refreshGraphImages() {
         
         document.images["redrawimage"].src = "throughput.php?variable="+Math.random();
         setTimeout('refreshGraphImages()', <?=($GraphRefreshRate*1000)?>);

         if (document.images["WANBytesTransmitted"] != null){
            document.images["WANBytesTransmitted"].src    = "temp/WANBytesTransmitted.png?variable="+Math.random();
         }

         if (document.images["LANBytesTransmitted"] != null){
            document.images["LANBytesTransmitted"].src    = "temp/LANBytesTransmitted.png?variable="+Math.random();
         }

         if (document.images["WANBytesReceived"] != null){
            document.images["WANBytesReceived"].src    = "temp/WANBytesReceived.png?variable="+Math.random();
         }

         if (document.images["LANBytesReceived"] != null){
            document.images["LANBytesReceived"].src    = "temp/LANBytesReceived.png?variable="+Math.random();
         }

         if (document.images["Non-AcceleratedTraffic"] != null){
            document.images["Non-AcceleratedTraffic"].src    = "temp/Non-AcceleratedTraffic.png?variable="+Math.random();
         }

         if (document.images["WANTraffic"] != null){
            document.images["WANTraffic"].src    = "temp/WANTraffic.png?variable="+Math.random();
         }

         if (document.images["LANTraffic"] != null){
            document.images["LANTraffic"].src    = "temp/LANTraffic.png?variable="+Math.random();
         }
      }

      <?if ($AutoRefresh){?>
          setTimeout('refreshGraphImages()', <?=($GraphRefreshRate*1000)?>);
      <?}?>
   </script>


   <BODY>
      <div align="center">
         Auto-refresh <B><?=$AutoRefresh?"ON":"OFF"?></B>: <A href="./throughput.php?ToggleAutoRefresh">Toggle</A>
         
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A href="javascript:show_popup_graph()" alt="foo">Popup Graph</a>

         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <A href="./ui_configuration.php">Graph Settings</A>
      
      <BR>

   <!-- Display the throughput graph -->
   <DIV class="no_bg_color">
   <?
      $Grapher = new PERF_GRAPHER();
      $Grapher->SetGraphAckProgress( GetParameter("UI.Graph.GraphSeqNumAdv") );
      echo $Grapher->Render();      
   ?>
   </DIV>
   <img src="throughput.php" height="1" width="1" name="redrawimage">

<br>


<? include(HTTP_ROOT_INCLUDES_DIR . "footer.php"); ?>

</HTML>

<?
//
// Copyright 2002,2003 Orbital Data Corporation
//
?>
