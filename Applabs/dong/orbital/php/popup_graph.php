<?
   require("includes/configure.php");
   include("includes/orbital_lib.php");

   if (GetParameter("UI.PasswordProtectFrontPage") != 0) {
      $Auth = new OD_AUTH();
      $Auth->CheckLogin();
      $Auth->CheckRights(AUTH_LEVEL_VIEWER);
   } else {
      define('NO_LOGIN_REQUIRED', false);
   }
   
   $GraphRefreshRate = GetParameter("ui.graph.refreshrate");
?>

<HTML>
   <HEADER>
      <TITLE>Orbital Throughput: <?=GetHostname()?></TITLE>
      <META http-equiv="refresh" content="<?=$GraphRefreshRate?>;URL=./popup_graph.php">
      <META http-equiv="Expires" content="<?=$GraphRefreshRate?>">
      <META http-equiv="Pragma" content="no-cache">
      <META http-equiv="Cache-control" content="no-cache">      
   </HEADER>
   <BODY>
<?
   $Grapher = new PERF_GRAPHER();
   $Grapher->SetCombineSendRecv(true);
   $Grapher->SetShowFastSide(false);
   $Grapher->SetShowSlowSide(true);
   $Grapher->SetDisplayLegend(false);
   $Grapher->SetIsResizable(true);
   echo $Grapher->Render();

?>
   </BODY>
</HTML>
