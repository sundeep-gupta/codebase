<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   define('DONT_REQUIRE_RUNNING_SERVER', true);

   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
   isServerMatchVMIP();
   if ($HaRunning && isServerMatchVMIP()) {
      if (MSG_BOX::Ask("Restart?", "Are you sure you wish to restart " . ProdName() . "? (Doing so will make the " . ProdName() . " unavailable for about 10 seconds)") == MSG_BOX_YES){
         // Secondary system takes it over. Approximately time is 10 seconds
         HTML::InsertCountdownRedirect(RESTART_TIME_HA);
         RestartOrbital();
      }else{
         echo HTML::InsertRedirect("./index.php", 1);
      }
   }
   else{
      if (MSG_BOX::Ask("Restart?", "Are you sure you wish to restart " . ProdName() . "? (Doing so will make the " . ProdName() . " unavailable for about 3 minutes)") == MSG_BOX_YES){
         HTML::InsertCountdownRedirect(RESTART_TIME);
         RestartOrbital();
      }else{
         echo HTML::InsertRedirect("./index.php", 1);
      }
   }
   exit();
      
 ?>
