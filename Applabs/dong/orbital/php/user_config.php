<? include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
   

   //
   // Display a drop down form element, with the different user types.
   //
   function RenderUserTypes($CurSelectedType = -1)
   {
      echo "<SELECT NAME='Type'>\n";
      echo "   <option value='1' " . (($CurSelectedType==1) ? "SELECTED" : "") . ">Admin</option>\n";
      echo "   <option value='2' " . (($CurSelectedType==2) ? "SELECTED" : "") . ">Viewer</option>\n";
      echo "<SELECT>\n";
   }


   $UserAccounts = GetParamAsStruct("UserAccounts");

   if (isset($_GET["Update"]))
   {
      $UpdateType = $_GET["Update"];
      $Username = $_GET["Username"];
      if ($_GET["Password"] != "<ENCRYPTED>") $Password = sha1($_GET["Password"]);
      else $Password = $_GET["OldEncryptedPassword"];
      $Type = (int)$_GET["Type"];

      if ($UpdateType == "Add")
      {
         $AddUser = true;
         if (trim($Username) == "")
         {
            ThrowException("Empty Username Cannot be Added", false);
            $AddUser = false;
         }
         else
         {
            foreach ($UserAccounts as $User)
            {
               if ($User["Username"] == $Username)
               {
                  ThrowException("The user you are attempting to add already exists in the system!<br><br>", false);
                  $AddUser = false;
                  break;
               }
            }
         }

         if ($AddUser)
         {
            $NewAccount["Username"] = $Username;
            $NewAccount["Password"] = $Password;
            $NewAccount["Type"] = $Type;

            array_push($UserAccounts, $NewAccount);
            SetParamAsStruct("UserAccounts", $UserAccounts);
         }
      }
      else if ($UpdateType == "Delete")
      {
         $NewAccountList = array();
         foreach ($UserAccounts as $User)
         {
            if ($User["Username"] != $Username)
            {
               array_push($NewAccountList, $User);
            }
         }
         $UserAccounts = $NewAccountList;
         SetParamAsStruct("UserAccounts", $UserAccounts);
      }
      else if ($UpdateType == "Update")
      {
         for ($c=0; $c < count($UserAccounts); $c++)
         {
            $UpdateUser = &$UserAccounts[$c];
            if ($UpdateUser["Username"] == $Username)
            {
               $UpdateUser["Password"] = $Password;
               $UpdateUser["Type"] = $Type;
               break;
            }
         }

         SetParamAsStruct("UserAccounts", $UserAccounts);
      }
   }

?>

   
   
   <font class="pageheading">Security: Manage User</font><BR><BR>

   <!-- SHOW CURRENT USERS/PASSWORD -->
   <TABLE width="500">


      <TR>
      <TH>Username</TH><TH>Password</TH><TH>Type</TH><TH></TH><TH></TH>
      </TR>

      <? // Iterate through the user list

         $ProxyNum = 0;
         foreach ($UserAccounts as $User)
         { ?>
         <FORM>
            <TR>
            <TD>
               <INPUT type="hidden" name="Username" value="<?=$User["Username"]?>">
               <INPUT type="hidden" name="OldEncryptedPassword" value="<?=$User["Password"]?>">
               <?=$User["Username"]?>
            </TD>
            <TD class="">
               <INPUT type="text" name="Password" value="<ENCRYPTED>" size="20">
            </TD>
            <TD>
               <? RenderUserTypes($User["Type"]);?>
            </TD>
            <TD>
               <INPUT type="Submit" name="Update" value="Update" type="Get">
            </TD>
            <TD>
               <INPUT type="Submit" name="Update" value="Delete" type="Get">
            </TD>
            </TR>
         </FORM>
      <? }
      ?>

         <FORM>
            <TR>
            <TD>
               <INPUT type="text" name="Username" value="">
            </TD>
            <TD>
               <INPUT type="text" name="Password" value="" size="20">
            </TD>
            <TD>
               <? RenderUserTypes(); ?>
            </TD>
            <TD>
               <INPUT type="Submit" name="Update" value="Add" type="Get">
            </TD>
            <TD></TD>
            </TR>
         </FORM>
   </TABLE>

<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>

<?
//
// Copyright 2002,2003 Orbital Data Corporation
//
/*
 * $Author: Mark Cooper $
 * $Modtime: 5/02/03 12:34p $
 * $Log: /source/vpn_filter/http_root/user_config.php $
 *
 * 2     5/02/03 12:35p Mark Cooper
 */
?>
