<?
   include("includes/header.php"); 
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);

   include_once("performance_profiler_lib.php");

   

      $Grapher = new PERF_GRAPHER();
      $Grapher->SetGraphAckProgress(true);
      echo $Grapher->Render();
?>

