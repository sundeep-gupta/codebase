<?

   //
   // Converts "foo_bar" => "foo.bar"
   //
   function UnescapeParamName($Name)
   {
      return str_replace("_", ".", $Name);
   }

   //
   // Converts "foo.bar" => "foo_bar"
   //
   function EscapeParamName($Name)
   {
      return str_replace(".", "_", $Name);
   }

   class HTML
   {
      function InsertBreak()
      {
         print("<BR></BR>\n");
      }

      function InsertRedirect($TargetPage = "", $Timeout=0)
      {
         if ($TargetPage == ""){
            $TargetPage = $_SERVER["PHP_SELF"];
         }
         return"<HTML>\n" .
               "<HEAD>\n" .
               "<META http-equiv=\"Refresh\" content=\"$Timeout; url=$TargetPage\">\n" .
               "</HEAD>\n" .
               "</HTML>\n";
      }

      function InsertCountdownRedirect($Timeout=10, $TargetPage = "./index.php", $Message="Please wait while Orbital restarts...")
      {
         echo HTML::InsertRedirect($TargetPage, $Timeout);

         echo "<SCRIPT LANGUAGE='JavaScript'>\n" .
              "var CountdownTimer = 100;\n" .
              "function starttimer(StartTime){\n" .
              "    CountdownTimer = StartTime;\n" .
              "    countdowntimer();\n" .
              "}\n" .
              "function countdowntimer() {\n" .
              "   CountdownTimer --;\n" .
              "   if (CountdownTimer < 0) { CountdownTimer = 0;}\n" .
              "   document.countdown.time.value = CountdownTimer;\n" .
              "   document.foo = CountdownTimer;\n" .
              "   window.setTimeout(\"countdowntimer()\", 1000);\n" .
              "}\n" .
              "</SCRIPT>\n" .
            "</HEAD>\n" .
            "<BODY onLoad=\"starttimer($Timeout);\">\n";

            ShowStatusMessage($Message);

         echo "<BR><BR>" .
              "<CENTER>" .
              "<IMG src='./images/clock_animation.gif'><BR><B>" .
              "<form name='countdown'>" .
                  "<input type=text name='time' size='2' style='border: 0' align=center>" .
              "</form>" .
              "</B>" .
              "</CENTER>" .
              "</BODY>";
      }//InsertCountdownRedirect()

      function InsertLink($TargetPage, $DisplayValue)
      {
         return "<A href=\"$TargetPage\">$DisplayValue</A>\n";
      }
   }

   //
   // This class displays an HTML message box inline with the page which prompts for a YES/NO response
   // Usage: if (MSG_BOX::Ask("Blah?", "Do this?") == MSG_BOX_YES){
   //           DoSomethingNow
   //        }else{
   //           UserClickedNo
   //        }
   //
   define("MSG_BOX_YES", 1);
   define("MSG_BOX_NO", 0);
   define("MSG_BOX_UNKNOWN", -1);
   class MSG_BOX
   {
      function Ask($Title, $Message){
         if (isset($_GET["MsgBoxResponse"])){

            // Make sure they don't refresh this page
            if (isset($_GET["LastRandKey"])) { $LastRandKey = $_GET["LastRandKey"];}else{$LastRandKey = 0;}
            if ( (isset($_SESSION["MSG_BOX_LAST_KEY"])) && ($_SESSION["MSG_BOX_LAST_KEY"] == $LastRandKey) ){
               ThrowException("You attempted to refresh this page<BR> twice. Don't do that!", true);
            }

            $_SESSION["MSG_BOX_LAST_KEY"] = $LastRandKey;

            return $_GET["MsgBoxResponse"];
         }

         echo "<CENTER>" .
               "<BR><BR>" .
               "<TABLE width=350>" .
                  "<TR>" .
                     "<TH><FONT size='+2'>$Title</FONT></TH>" .
                  "</TR>" .
                  "<TR>" .
                     "<TD><CENTER>" .
                        "<FONT size='+1'>" .
                           $Message . "<BR><BR>" .
                        "<A href='?" . $_SERVER["QUERY_STRING"] . "&MsgBoxResponse=1&LastRandKey=" . time() . "'>YES</A>&nbsp;&nbsp;&nbsp;&nbsp;" .
                        "<A href='?" . $_SERVER["QUERY_STRING"] . "&MsgBoxResponse=0&LastRandKey=" . time() . "'>NO</A><BR><BR>" .
                        "</FONT></CENTER>" .
                     "</TD>" .
                  "</TR>" .
               "</TABLE>" .
               "</CENTER>";
          exit();
      }
   }

   class HTML_TABLE
   {
      function Begin($Class="")
      {
         return "<TABLE>\n";
      }

      function AddHeader1($Value, $ColSpan=2)
      {
         return "<TR><TH colspan=$ColSpan>$Value</TH></TR>\n" ;
      }

      function AddHeader2($Value, $ColSpan=2)
      {
         return "<TR><TD colspan=$ColSpan>$Value</TD></TR>\n" ;
      }

      function AddEntry($Name, $Value, $Class="")
      {
         return "<TR><TH>$Name&nbsp;</TH><TD>$Value</TD></TR>\n";
      }

      function AddHiddenEntry($Name, $Value, $display)
      {
         if($display)
            return "<TR><TH>$Name&nbsp;</TH><TD>$Value</TD></TR>\n";
         else
            return;
      }

      function AddEntry2Row($Name, $Value, $Value2, $Class="")
      {
         return "<TR><TH>$Name&nbsp;</TH><TD>$Value<TD>$Value2</TD></TD></TR>\n";
      }

      function AddEntry2($Value, $Class="", $ColSpan=2)
      {
         return "<TR><TD colspan=$ColSpan>$Value</TD></TR>\n";
      }

      function AddEntry3($Value1, $Value2, $Value3, $Class="")
      {
         return "<TR><TD>$Value1&nbsp;</TD><TD>$Value2</TD><TD>$Value3</TD></TR>\n";
      }

      function EndRow($Text)
      {
         return "<TR>\n";
      }

      function AddCell($Text = "")
      {
         return "<TD>$Text</TD>\n";
      }

      function EndCell()
      {
         return "</TD>\n";
      }

      function End()
      {
         return "</TABLE>\n";
      }
   }

   class HTML_FORM
   {
      var $FormName;

      function Begin($Name, $Target="")
      {
         $Output = "";
         $this->FormName = $Name;
         if ($Target == "")
               { $Output = "<FORM name=$Name>\n"; }
         else  { $Output = "<FORM name=$Name action=\"$Target\">\n"; }

         $Output .= "<input type=hidden name=FormName value=$Name>";
         return $Output;
      }

      function BeginFormName($Name, $Target="")
      {
         $Output = "";
         $this->FormName = $Name;
         if ($Target == "")
               { $Output = "<FORM name=\"" . $Name . "\">\n"; }
         else  { $Output = "<FORM action=\"$Target\">\n"; }

         $Output .= "<input type=hidden name=FormName value=$Name>";
         return $Output;
      }

      function AddDropdown($DropdownName, $ItemNames, $ItemValues, $SeletectedItem=0, $Length=0)
      {
         $Output = "<SELECT Name=\"$DropdownName\" size=\"$Length\">\n";
         for ($i=0, $count = count($ItemNames); $i<$count; $i++)
         {
            $Output .= "<option value=\"";
            $Output .= $ItemValues[$i] . "\"";
            if ($SeletectedItem == $i) { $Output .= " SELECTED"; }
            $Output .= ">";
            $Output .= $ItemNames[$i];
            $Output .= "</option>\n";
         }
         $Output .= "</SELECT>\n";
         return $Output;
      }

      function AddRadioButtons($RadioName, $ItemNames, $ItemValues, $SeletectedItem=0, $Length=0, $OnClick="")
      {
         $Output = "";
         for ($i=0, $count = count($ItemNames); $i<$count; $i++)
         {
            $Output .= "<input type=radio name=$RadioName value=\"";
            $Output .= $ItemValues[$i] . "\"";
            if ($SeletectedItem == $i) { $Output .=" checked"; }
            if ($OnClick != "") { $Output .= " onClick='$OnClick'"; }
            $Output .= ">\n";
            $Output .= $ItemNames[$i];
         }
         return $Output;
      }

      function AddRadioButton($RadioName, $ItemValue, $Selected=0, $OnClick="")
      {
         return "<input type=radio name='$RadioName' value='$ItemValue'" . ($Selected ? " checked":"") . " onClick='$OnClick'>\n";
      }

      function AddList($ListName, $ItemNames, $Length=5, $width=0)
      {
         $Output = "";
         $style="";
         if($width > 0)
         {
            $width.="px";
            $style = "style=\"width: ". $width ."\"";
         }
         $Output .= "<SELECT NAME=\"$ListName\" $style SIZE=$Length>\n";
         foreach ($ItemNames as $Item)
         {
            $Output .= "<OPTION>$Item\n";
         }
         $Output .= "</SELECT>\n";
         return $Output;
      }

      function AddTextField($FieldName, $DefaultValue="", $Length=8)
      {
         if($Length != 0)
         {
	         $FieldName = str_replace(".", "_", $FieldName);
            return "<INPUT type=\"text\" name=\"$FieldName\" value=\"$DefaultValue\" size=\"$Length\" >\n";
         }
      }

      function AddTextField_MaxSize($FieldName, $DefaultValue="", $Length=10, $Max=10)
      {
         return "<INPUT type=\"text\" name=\"$FieldName\" value=\"$DefaultValue\" size=\"$Length\" maxlength=\"$Max\">\n";
      }

      //
      // A submit style button
      //
      function AddSubmit($ButtonName="", $ButtonText="Update")
      {
         return "<INPUT type=\"submit\" name=\"$ButtonName\" value=\"$ButtonText\"></INPUT>\n";
      }

      //
      // A normal button
      //
      function AddButton($ButtonName, $ButtonText, $OnClick="", $width=0)
      {
         $style="";
         if($width > 0)
         {
            $width.="px";
            $style = "style=\"width: ". $width ."\"";
         }
         if ($OnClick != ""){
            return "<INPUT type=\"button\" name=\"$ButtonName\" value=\"$ButtonText\" $style onClick=\"$OnClick\"></INPUT>\n";
         }else{
            return "<INPUT type=\"button\" name=\"$ButtonName\" value=\"$ButtonText\" $style></INPUT>\n";
         }
      }

      function End()
      {
         return "</FORM>\n";
      }

      function AddCheckBox($BoxName,$IsChecked=false) {
         $BoxName = str_replace(".", "_", $BoxName);
         $Output = "<input type=checkbox name=$BoxName ";
         if ($IsChecked) $Output .= "checked";
         $Output .= ">\n";
         return $Output;
      }

      function AddCheckBox_onClick($BoxName,$IsChecked=false, $onClickName) {
         $BoxName = str_replace(".", "_", $BoxName);
         if($IsChecked)
            $Output = "<input type=checkbox name=$BoxName value=$IsChecked onClick=$onClickName ";
         else
            $Output = "<input type=checkbox name=$BoxName value=0 onClick=$onClickName ";
         if ($IsChecked) $Output .= "checked";
         $Output .= ">\n";
         return $Output;
      }

      function AddHidden($Name,$Value) {
         return "<input type=hidden name=$Name value=$Value>";
      }
   }

   //
   // Allows for HTML-less generation of a form for getting/setting parameters
   //
   class HTML_PARAMETER_FORM extends HTML_FORM
   {
      var $RedirectOffThisPage = false;

      function IsSetRequest($Name="")
      {
         if (  (isset($_GET["FormName"]) && $_GET["FormName"] == $this->FormName ) &&
               ( ($Name == "") || (isset($_GET[ EscapeParamName($Name) ])) )  )
         {
            $this->RedirectOffThisPage = true;
            return TRUE;
         }
         else {return FALSE;}
      }

      function AddTextParam($Name, $Length=10 )
      {
         if ( $this->IsSetRequest($Name) )         // A set on this parameter was attempted
         {
            SetParameterText($Name, $_GET[ EscapeParamName($Name) ]);
         }

         $Value = GetParameterText($Name);
         $Value = str_replace("'", "", $Value);

         return parent::AddTextField($Name, $Value, $Length);
      }

      function AddTextParam_Unit($Name, $str, $Length=10 )
      {
         if ( $this->IsSetRequest($Name) )         // A set on this parameter was attempted
         {
            SetParameterText($Name, $_GET[ EscapeParamName($Name) ]);
         }

         $Value = GetParameterText($Name);
         $index =   strrpos($Value,$str);
         $val = substr($Value, 0, $index);
         if($str == "%")
         {
            $ext = substr($Value, $index);
         }
         else
         {
            $ext = substr($Value, $index + 1);
            $ext = FormatRateUnit($ext);
         }
         $val =  $val . " " .  $ext;
         return parent::AddTextField($Name, $val, $Length);

      }

      function AddTextParam_MaxSize($Name, $Length=10, $Max=10)
      {
         if ( $this->IsSetRequest($Name) )         // A set on this parameter was attempted
         {
            SetParameterText($Name, $_GET[ EscapeParamName($Name) ]);
         }

         $Value = GetParameterText($Name);
         $Value = str_replace("'", "", $Value);

         return parent::AddTextField_MaxSize($Name, $Value, $Length, $Max);
      }

      //
      // The $Live parameter means, when set to true, that click on the
      // check box update the parameter immediately
      //
      function AddBooleanParam($Name, $Live=false, $RadioNames=array())
      {
         if ( $this->IsSetRequest() )         // A set on this parameter was attempted
         {
            if (isset($_GET[ EscapeParamName($Name) ] ) &&
                  (count($RadioNames) <= 0 || $_GET[ EscapeParamName($Name) ] != 0))
            {
               SetParameter($Name, TRUE);
            }
            else { SetParameter($Name, FALSE); }
         }

         $Value = GetParameter($Name);
         $OnClick = $Live ? ("document." . $this->FormName . ".submit()") : "";
         return (count($RadioNames) <= 0 ? (
            $Live ? parent::AddCheckBox_onClick($Name, $OnClick) :
            parent::AddCheckBox($Name, $Value)) :
            parent::AddRadioButtons(EscapeParamName($Name), $RadioNames, array(0, 1), $Value ? 1 : 0, $OnClick));
      }

      function AddBooleanParam_onClick($Name, $OnClick="")
      {
         if ( $this->IsSetRequest() )         // A set on this parameter was attempted
         {
            if (isset($_GET[ EscapeParamName($Name) ] ))
            {
               SetParameter($Name, TRUE);
            }
            else { SetParameter($Name, FALSE); }
         }

         $Value = GetParameter($Name);
         return parent::AddCheckBox_onClick($Name, $Value, $OnClick);
      }
      #
      # Add a drop-down parameter. It's supported by a UINT parameter that runs
      #
      function AddDropdownParam($Name, $ItemNames, $ItemValues, $Length=0)
      {
         if ($this->IsSetRequest()) {
            if (isset($_GET[EscapeParamName($Name)])) {
               $Value = $_GET[EscapeParamName($Name)];
               SetParameter($Name,$Value+0);
            }
         }
         $Value = GetParameter($Name);
         $Index = array_search($Value,$ItemValues);
         return parent::AddDropdown($Name,$ItemNames,$ItemValues,$Index,$Length);
      }
      #
      # Add a parameter whose type is DISPLAY_PORT_LIST
      #
      function AddPortListParam($ParamName, $FieldNames)
      {
         if ( $this->IsSetRequest() )
         {
            $NewParam = "";

            $NewParam .= ($_GET["AccelState"] == 2) ? "E{" : "I{";
            if ( (  (int)$_GET["AccelState"] != 0)  ){
               $NewParam .= $_GET["AccelPorts"];
            }
            $NewParam .= "}";
            SetParameterText($ParamName, $NewParam );
         }

         $UnparsedPorts = GetParameterText($ParamName);
         $ParsedPorts = str_replace( array("{", "}", "I", "E"), "", $UnparsedPorts);
         $Mode = 0;
         if ($UnparsedPorts == "I{}"){   // Empty
            $Mode = 0;
         }
         else if ( strpos($UnparsedPorts, "I{") === 0 ){
            $Mode = 1;
         }
         else if ( strpos($UnparsedPorts, "E{") === 0 ){
            $Mode = 2;
         }

         $Output = "";
         $Output .= HTML_FORM::AddTextField("AccelPorts", $ParsedPorts) . 
                    "Example: 21,22,80, 1500-1550<BR>\n";

         $Count = 0;
         foreach($FieldNames as $FieldName)
         {
            $Output .= HTML_FORM::AddRadioButton("AccelState", $Count, $Count == $Mode) .
                       "$FieldName<BR>\n";
            $Count++;
         }

         return $Output;
      }//AddPortListParam

      function End()
      {
         return parent::End() .
                ($this->RedirectOffThisPage ? HTML::InsertRedirect() : "");
      }

   }
?>
