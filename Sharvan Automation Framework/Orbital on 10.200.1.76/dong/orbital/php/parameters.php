<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);

   function DisplayValue($PValue)
   {
      $PValue = str_replace("'", "" , $PValue);
      $Value = substr($PValue,0,1) == "'" ? $PValue : ("'" . $PValue . "'");
      $Value = str_replace(">", "&#062;", $Value);
      $Value = str_replace("''", "&#039;&#039;", $Value);
      return $Value;
   }
   
   foreach($_GET as $Key=>$Value) {
      if ($Key == "ResetAll") {
         $Params = array();
         $Result = xu_rpc_http_concise(
                        array(
                           'method' => "ResetToDefault",
                           'args'   => $Params,
                           'host'      => RPC_SERVER,
                           'uri'    => RPC_URI,
                           'port'      => RPC_PORT
                        )
         );
         TestForFault($Result, "Parameter " . $Value. " not found!");
      } else if ((int)$Key < 0) {
         $Params = $_SESSION["ParameterNames"][-(int)$Key];
         $Result = xu_rpc_http_concise(
                        array(
                           'method' => "ResetToDefault",
                           'args'   => $Params,
                           'host'      => RPC_SERVER,
                           'uri'    => RPC_URI,
                           'port'      => RPC_PORT
                        )
         );
         TestForFault($Result, "Parameter " . $Params. " not found!");
      } else {
         $Param = $_SESSION["ParameterNames"][$Key];
         SetParameterText($Param,$Value);
      }
   }
   //
   // Get all the parameters
   //
   $Parameters = GetAllParameters();
   unset($Parameters["UserAccounts"]); // Don't display, it confuses the logic....
   $Overrides = 0;
   $counter = 0;
   foreach($Parameters as $Param => $Value)
   {
      $counter++;
      $_SESSION["ParameterNames"][$counter] = $Param;
      if (!$Value["Default"]) {
         $Overrides++;
      }
   }

   ?>
   <div align="center">
   <table cellspacing="4" class="width50" > <tbody>
       <tr>
         <th><b>&nbsp;<?=($Overrides == 0 ? "ALL" : "OVERRIDDEN")?>&nbsp;PARAMETERS&nbsp;</b><br></th>
         <th><b>VALUE</b><br> </th>
         <? 
         if ($Overrides != 0) { 
            echo "<form name='all'>";
            echo "<td class='table_header'>&nbsp;&nbsp;";
            echo "<input type='hidden' name='ResetAll' value=1>";
            echo "<input type='submit' value='RESET ALL'>";
            echo "&nbsp;&nbsp;</td></form>";
         }
         ?>
       </tr>
   <?
   //
   // Show Overriden parameters at the top
   //
   $counter = 0;
   $othercounter = 0;
   $overrides = 0;
   foreach($Parameters as $Param => $Value)
   {
      $counter++;
      $Default = $Value["Default"];
      if (!$Default) {
         $othercounter++;
         $PValue = $Value["Text"];
         if ( ($othercounter % 2) == 0)
            echo "<TR class='row-1'>";
         else
            echo "<TR class='row-2'>";
         echo "<TD height=30 nowrap><i> <font color=red>". $Param . "</TD>\n";
         echo "<form name='$counter'>";
         echo "<td align=center nowrap height=30>";
         $NValue = DisplayValue($PValue);
         echo "<input type='text' size=25 name='$counter' value=" . $NValue. ">";
         echo "<input type='submit' value='SET'>";
         echo "</td>";
         echo "</form>";
         echo "<form name=Reset$counter>";
         echo "<td align=left nowrap height=30>";
         echo "<input type='hidden' name='-$counter' value=1>";
         echo "<input type='submit' value='RESET TO '>&nbsp;" . substr($Value["DefaultText"],0,20);
         echo "</TD>\n";
         echo "</form>";
         echo "</TR>\n" ;
         $overrides++;
      }
   }
   if ($overrides) {
      //
      // Make spacer
      //
      ?>
       <tr>
         <th>ALL&nbsp;PARAMETERS</th>
         <th>&nbsp;</th>
         <th> &nbsp;</th>
       </tr>
      <?
   }
   //
   // Show Non Overriden Parameters
   //
   $counter = 0;
   foreach($Parameters as $Param => $Value)
   {
      $counter++;
      $Default = $Value["Default"];
      $OriginalPName = $Param;
      $PValue = $Value["Text"];
      if ( ($counter % 2) == 0)
         echo "<TR class='row-1'>";
      else
         echo "<TR class='row-2'>";
      echo "<TD height=30 nowrap>";
      echo $Param;
      echo "</TD>\n";
      echo "<form name='$counter'>";
      echo "<td align=center nowrap height=30>";
      $Value = DisplayValue($PValue);
      echo "<input type='text' size=25 name='$counter' value=" . $Value. ">";
      echo "<input type='submit' value='SET'>";
      echo "</td>";
      echo "</form>";
      echo "</TR>\n" ;
   }
?>
  </tbody>
  </table>
</div>

<? 
//
// Copyright 2002,2003 Orbital Data Corporation
//
?>
