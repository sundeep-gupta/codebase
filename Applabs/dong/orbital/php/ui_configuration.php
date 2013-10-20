<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>


<?
   echo "<font class=pageheading>Configure Settings: UI</font><BR><BR>";
   echo "<font class=pageheading>UI: Graphing</font><BR><BR>";
   $Table = new HTML_TABLE();
   $ParamForm = new HTML_PARAMETER_FORM();
   echo
      "<div class=\"settings_table\">",
      $Table->Begin(),
      $ParamForm->Begin("ui_config1"),
      $Table->AddEntry("Display WAN Side Graph:",   $ParamForm->AddBooleanParam("UI.Graph.ShowWANGraph")),
      $Table->AddEntry("Display LAN Side Graph:",   $ParamForm->AddBooleanParam("UI.Graph.ShowLANGraph")),
      $Table->AddEntry("Combine Send/Receive Graphs:", $ParamForm->AddBooleanParam("UI.Graph.CombineSndRecvGraph") ),
      $Table->AddEntry("Uncompressed/Compressed Ratio Graph:",   $ParamForm->AddBooleanParam("UI.Graph.ShowCompressedRatio")),
      $Table->AddEntry("Autoscale Graphs:", $ParamForm->AddBooleanParam("UI.Graph.AutoScale") ),
      $Table->AddEntry("Graph Refresh Rate:", $ParamForm->AddTextParam("UI.Graph.RefreshRate", 4) . "seconds" ),
      $Table->AddEntry("Autorefresh Graph:", $ParamForm->AddBooleanParam("UI.Graph.AutoRefresh") ),
      $Table->AddEntry("", $ParamForm->AddSubmit() ),
      $ParamForm->End(),
      $Table->End(),
      "</DIV>";
   echo "</CENTER><BR>";

?>

<?
   echo "<font class=pageheading>UI: Miscellaneous</font><BR><BR>";
   $Table = new HTML_TABLE();
   $ParamForm = new HTML_PARAMETER_FORM();
   echo
      "<div class=\"settings_table\">",
      $Table->Begin(),
      $ParamForm->Begin("ui_config2"),
      $Table->AddEntry("Lock Changes Via LCD:", $ParamForm->AddBooleanParam("UI.XF633.Lock") ),
      $Table->AddEntry("WebUI Port:", $ParamForm->AddTextParam("Http.Port", 3) ),
      $Table->AddEntry("Max Connections Shown On Connection Page:", $ParamForm->AddTextParam("UI.ConnList.ConnectionsShown", 3) ),
      $Table->AddEntry("", $ParamForm->AddSubmit() ),
      $ParamForm->End(),
      $Table->End(),
      "</DIV>";
   echo "</CENTER>";

?>

<? include(HTTP_ROOT_INCLUDES_DIR . "footer.php");  ?>
