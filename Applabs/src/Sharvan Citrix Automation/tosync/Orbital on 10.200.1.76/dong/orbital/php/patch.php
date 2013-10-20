<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   define('DONT_REQUIRE_RUNNING_SERVER', true);
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>

<font class="pageheading">System Tools: Update Software</font><BR><BR>

<?
   //
   // Downgrade to an old release
   //
   if (isset($_GET["ChangeRelease"]) )
   {      
      exec ("/usr/bin/sudo /orbital/util/orbsys --setcurrentrelease=" . $_GET["Release"] );

      ShowStatusMessage("Restarting system with selected version...");
      ShowStatusMessage("(this will take several minutes)");

      // *** Do not use restart.php it will be pointing to the new http_root which is not compatible
      // *** with the running orbital_server.
      //
      // Reboot the box.
      //
      if ($HaRunning && isServerMatchVMIP()) {
         // Secondary system takes it over. Approximately time is 3-5 seconds
         echo HTML::InsertRedirect("patch.php", RESTART_TIME_HA);
      }else {
         echo HTML::InsertRedirect("patch.php", 240);
      }
      SendCommand("reboot", "");

      exit();
   }


   //
   // Change to the production or debug Orbital binary
   //
   if (isset($_GET["ChangeVersionType"]) )
   {
      echo "<BR><BR><CENTER><A href=\"./restart.php\">Click here to restart Orbital with the new version type</A></CENTER>";
      
      exec ("/usr/bin/sudo /orbital/util/orbsys --setexecutable=" . $_GET["Type"] );

      echo HTML::InsertRedirect("restart.php", 1);

      exit();
   }

?>


   <FORM action="./install_patch_file.php" method="post" enctype="multipart/form-data">
      <TABLE width=500>
      <TR><TH> 
         Upgrade <?=ProdName()?> Software
      </TH><TH></TH></TR>

      <TR>
      <TD>
      Patch File:
         <INPUT TYPE="hidden" name="MAX_FILE_SIZE" value="100000000">
         <INPUT type="hidden" name="UpdateOrbital" value="">
         <input type=file name=userFile size=25>
      </TD>
      <TD>
         <INPUT type="Submit" name="AddPatchButton" value="Upload Patch" type="Get">
      </TD>
      </TD></TR>
      </TABLE>
   </FORM>

<?
   //
   // show the downgrade options
   //
   exec ("/orbital/util/orbsys --releases", $Releases);
   $CurrentRelease = exec ("/orbital/util/orbsys --currentrelease");      
   $Releases = array_reverse($Releases);
   $CurReleaseNum = array_search($CurrentRelease, $Releases, false);
   
   $Table = new HTML_TABLE();
   $ParamForm = new HTML_PARAMETER_FORM();
   echo 
      "<BR>",
      $Table->Begin(),
      $ParamForm->Begin("ChangeRelease"),
      $Table->AddHeader1("Downgrade Release"),
      
      $Table->AddEntry2("Currently Running Version:&nbsp;&nbsp;" . $CurrentRelease, "row-1-center"),
      
      $Table->AddEntry("Releases:&nbsp;&nbsp;"  . 
                                     $ParamForm->AddDropdown("Release", $Releases, $Releases, $CurReleaseNum) ,
                                     $ParamForm->AddSubmit("ChangeRelease", "Change")),
      $ParamForm->End(),
      $Table->End();
      

   //
   // Show the "change to a debug version" options
   //
      
   $VersionTypesNames = array("Default", "Level 1", "Level 2");
   $VersionTypesValues = array("server", "level1", "level2");
   
   $Table = new HTML_TABLE();
   $ParamForm = new HTML_PARAMETER_FORM();
   echo 
      "<BR>",
      $Table->Begin(),
      $ParamForm->Begin("ChangeVersionType"),
      $Table->AddHeader1("Change Version Type"),
      
      $Table->AddEntry("Type:&nbsp;&nbsp;"  . 
                                     $ParamForm->AddDropdown("Type", $VersionTypesNames, $VersionTypesValues) ,
                                     $ParamForm->AddSubmit("ChangeVersionType", "Change")),
      $ParamForm->End(),
      $Table->End();        

?>

</BODY>
</HTML>

<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
