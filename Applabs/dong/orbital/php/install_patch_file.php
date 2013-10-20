<?
   define('DONT_REQUIRE_RUNNING_SERVER', true);
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>

<BR><BR><BR>
<CENTER>
<?
   $PatchFilename = "update.bin";
   $UpgradeDir = SYSTEM_TEMP_DIR . "odupgrade/";
   
   @mkdir ($UpgradeDir);   
   chdir($UpgradeDir);

   if (!isset($_GET["ApplyPatch"]))
   {
      //
      // Move the patch file too the temp directory
      //
      if ($_FILES['userFile']['name']== "")
      {
         ThrowException("No patch file uploaded. Did you correctly select the patch file?", true);
      }
      else if ($_FILES['userFile']['size']== 0)
      {
         ThrowException("Unable to upload patch. Patch size may be too large!", true);
      }      

      //
      // Now verify that the patch was valid
      //
      $ReturnCode = 0;
      $Results = array();
      exec("/orbital/util/upgrade --verify " . $_FILES['userFile']['tmp_name'], $Results, $ReturnCode);

      if ($ReturnCode != 0) // Bad patch
      {

         ThrowException("Patch file was bad. Please retry the upload.", false);
         ThrowException("If this error persists, please contact customer support!", false);

         echo("Error Returned:");
         foreach ($Results  as $Line)
         {
            echo("$Line<br>\n");
         }      
         exit;
      }
      
      //
      // Now move the file into the final location that the upgrade script will use
      //
      @unlink ($UpdateDir . $PatchFilename);
      move_uploaded_file($_FILES['userFile']['tmp_name'], $UpgradeDir . $PatchFilename);
      
      ShowStatusMessage("Patch upload was successful. Restarting system.");

      //
      // Reboot the box and the patch file will get applied...
      //
      HTML::InsertCountdownRedirect(INSTALL_TIME, "./index.php", "(Please wait while the new software is installed)");

      exec("/usr/bin/sudo /sbin/reboot");
      //SendCommand("reboot", "");

   }
   
?>
</CENTER>

<? 
//
// Copyright 2002,2003 Orbital Data Corporation
//
/*
 * $Author: Mark Cooper $ 
 * $Modtime: 5/20/03 5:58p $ 
 */
?>
