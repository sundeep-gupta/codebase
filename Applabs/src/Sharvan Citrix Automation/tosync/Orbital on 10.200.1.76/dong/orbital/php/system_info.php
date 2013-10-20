<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_VIEWER);

?>

<?

   $Parameters = OrbitalGet("PARAMETER");

   print("<H2><CENTER>System Parameters</CENTER></H2>\n");
   
   echo("<TABLE>");
   echo("<TR>");
      echo("<TH>Attribute</TH>");
      echo("<TH>Value</TH>");
   echo("</TR>");
   
   foreach ($Parameters as $Name=>$Value)
   {        
      echo("<TR class=\"row-1\">");
         echo("<TH align=left>" . $Name . "</TH>");
         echo("<TD align=left>" . $Value["Text"] . "</TD>");
      echo("</TR>");
   }
   print("</TABLE>\n");    

   $InstanceNumber = 1;
   $Adapters = OrbitalGet("ADAPTER");
   
   foreach($Adapters as $ix => $value) {
      $InstanceNumber = $value["InstanceNumber"];
      $DisplayName = $value["DisplayName"];

      $Info = AdapterInfo($value,$InstanceNumber);
      echo("<center> <h2> Detailed Information For Adapter " . $DisplayName . "</h2> </center>");
   
   
      echo("<TABLE class=\"width500\" align=\"center\">");
      echo("<TR align=center class=\"table_header\">");
         echo("<TD>Attribute</TD>");
         echo("<TD>Value</TD>");
      echo("</TR>");

   
      foreach ($Info as $Label => $Value)
      {
         echo("<TR class=\"row-1\">");
            echo("<TD align=center>" . $Label . "</TD>");
            echo("<TD align=center>" . $Value . "</TD>");
         echo("</TR>");
      }
      echo("</TABLE>");
   }
      ?>
