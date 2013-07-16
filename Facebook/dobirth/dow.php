<?php  // begin php code
 require_once 'facebook.php';
// require_once 'index.php';
define('FB_APIID', '173641592651350');

define('FB_SECRET', 'c91fb6b1809cd241efb959ec36388804');

define('FB_SESSION', 'YOUR_SESSION_key');
$facebook = new Facebook(array(
        'appapikey' => '90d34c73a48ad051424db197cd8bcf24',
        'secret' => 'c91fb6b1809cd241efb959ec36388804',
        'cookie' => true,
    ));
 $session = $facebook->getSession();
      if ($session) {
        try {
            $uid = $facebook->getUser();
            $me = $facebook->api('/me');
        } catch (FacebookApiException $e) {
            error_log($e);
        }
    }  
    
    $name=$me['name'];


//echo "thanks for submitting this data";
$fontStyle = "size=\"2\" face=\"Arial, Helvetica, sans-serif\"";
//$dayStrings = array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday");
//$mon = $_POST['mon'];
//$day = $_POST['day'];
//$year = $_POST['year'];

$mon = $_POST['imonth'];
$day = $_POST['iday'];
$year = $_POST['iyear'];

//echo " $day/$mon/$year";
      $tryagain = 'http://apps.facebook.com/dobirth';
//echo "$day";
if (!isset($mon) || !isset($day) || !isset($year))
  return;  // prevent processing of values not yet entered



$li= date('L', strtotime("$year-01-01"));

//echo $li;

  $m=$mon;
  $d=$day;
  $y=$year;
  
  if ($li != 1) {
  
      if (($m ==2) && ($d > 28))  {
      
  //      echo "<b>An invalid date ($m/$d/$y) was entered </b>";
  
  echo "<table cellspacing=\"0\" cellpadding=\"0\" width=\"700\" background=\"http://insha.in/fb/dobirth/background3.png\"><tr><td valign=\"left\" height=\"300\" width=\"700\"><font style=\"color:brown;font-size:11pt;font-family:book antiqua;font-weight:bold;\">";
  //echo "hello there";
echo "<b>An invalid date ($d/$m/$y) was entered! Click  <a href= \"$tryagain\">here</a> to try again (or Click on 'Back' button of the browser)</b>";

 // echo "Share this info with friends? Click here"; echo "<input type='button' value='Publish' onclick='post();'/>"; 
 echo"</td></tr>";
 echo "</table>";
  
  return;
      
      }
    }

   else if ($li != 0) {
  
      if (($m ==2) && ($d > 29))  {
      
       // echo "<b>An invalid date ($m/$d/$y) was entered </b>";
  
  echo "<table cellspacing=\"0\" cellpadding=\"0\" width=\"700\" background=\"http://insha.in/fb/dobirth/background3.png\"><tr><td valign=\"left\" height=\"300\" width=\"700\"><font style=\"color:brown;font-size:11pt;font-family:book antiqua;font-weight:bold;\">";
  //echo "hello there";
echo "<b>An invalid date ($d/$m/$y) was entered! Click  <a href= \"$tryagain\">here</a> to try again (or Click on 'Back' button of the browser)</b>";
 // echo "Share this info with friends? Click here"; echo "<input type='button' value='Publish' onclick='post();'/>"; 
 echo"</td></tr>";
 echo "</table>";
  
  return;
      
      }
    }
    

// simple range-checking
if (($mon < 1) || ($mon > 12) || 
    ($day < 1) || ($day > 31) ||
    ($year < 0))
{ 
  echo "<table cellspacing=\"0\" cellpadding=\"0\" width=\"700\" background=\"http://insha.in/fb/dobirth/background3.png\"><tr><td valign=\"left\" height=\"300\" width=\"700\"><font style=\"color:brown;font-size:11pt;font-family:book antiqua;font-weight:bold;\">";
  //echo "hello there";
echo "<b>An invalid date ($day/$mon/$year) was entered! Click  <a href= \"$tryagain\">here</a> to try again (or Click on 'Back' button of the browser)</b>";
 // echo "Share this info with friends? Click here"; echo "<input type='button' value='Publish' onclick='post();'/>"; 
 echo"</td></tr>";
 echo "</table>";
  return;
}



if ((($mon ==4) || ($mon ==6) || ($mon ==9) || ($mon =11)) && ($day > 30)) {
  echo "<table cellspacing=\"0\" cellpadding=\"0\" width=\"700\" background=\"http://insha.in/fb/dobirth/background3.png\"><tr><td valign=\"left\" height=\"300\" width=\"700\"><font style=\"color:brown;font-size:11pt;font-family:book antiqua;font-weight:bold;\">";
  //echo "hello there";
echo "<b>An invalid date ($day/$mon/$year) was entered! Click  <a href= \"$tryagain\">here</a> to try again (or Click on 'Back' button of the browser)</b>";
 // echo "Share this info with friends? Click here"; echo "<input type='button' value='Publish' onclick='post();'/>"; 
 echo"</td></tr>";
 echo "</table>";
  return;

   }

  
 /*if (($year%4 != 0) && ($mon = 2) && ($day >28)) {
  echo "<b>An invalid date ($mon/$day/$year) was entered </b>";
  return;
  
}  */
  

if ($mon < 3)
{
  $mon = $mon + 12;
  $year = $year - 1;
}

//if ($year < 1582) // account for gregorian calendar
 //$greg = 1;
//else
// $greg = 0;

//(d + (2 * m) + ((6 * (m + 1)) / 10) + y + (y / 4) - (y / 100) + (y / 400) + 1) % 7;
//$dow = ($day + (2 * $mon) + ((6 * ($mon + 1)) / 10) + $year + ($year / 4) - ($year / 100) + ($year / 400) + 1) % 7;
//$a4 = ($day + (2 * $mon) + ((6 * ($mon + 1)) / 10) + $year + ($year / 4) - ($year / 100) + ($year / 400) + 1);
$a1 =   ($day + (2 * $mon) + ((6 * ($mon + 1)) / 10));
//$a2 =   ($year + ($year / 4) - ($year / 100) + ($year / 400) + 1) % 7;
$a2 =   ($year + ($year / 4) - ($year / 100) + ($year / 400) + 1);
$a3 = intval($a1);
$a4 = intval($a2);
//echo " a1 =>$a1 ";
//echo " a2 =>$a2";
//echo " a3 => $a3";
//echo "a4 => $a4";

$dow = ($a3 + $a4) %7;
//echo "dow1 => $dow1";

//echo "dow => $dow";

echo "<font $fontStyle>";  // specify a font style

if ($dow > 6) {  // trap out-of-range errors
  echo "Something is amiss, the day ($dow) is invalid";
} else {
 // echo "The day of the week for $day/$mon/$year is:
  //   <b>$dayStrings[$dow]</b>";
}

switch ($dow){

	case '0':

  $message="
You were born on Sunday!  <br />
As per Thai culture, Each day of the week has its own significance & dictates character.<br /> 
*Sunday born Character: Respectable, Carefree, Wise, and Beloved by both friends and relatives  <br />
*Very lucky day: Wednesday                                                                           <br />
*Very lucky colour: green                                                                                  <br />
*Lucky day: Tuesday                                                                            <br />
*Lucky colour: pink                                                                             <br />
";                    

$attachment = array ( 'name' => 'Your Day of Birth & You',
'href' => 'http://apps.facebook.com/dobirth',
'description' => "$name was born on Sunday. Sunday born people are Respectable, Carefree, Wise, and Beloved by both friends and relatives. Their lucky day is Wednesday. Green is their Lucky color",
'media' => array (array ( 'type' => 'image',
'src' => 'http://insha.in/fb/dobirth/hands.png',
'href' => 'http://apps.facebook.com/dobirth'))
);
$attachment = json_encode($attachment); 
$mes = "Try this cool app!";    
	break;
	
	case '1':
  $message="
You were born on Monday!  <br />
As per Thai culture, Each day of the week has its own significance & dictates character.<br /> 
*Monday born Character: Good memory, Serious, Love to travel <br />
*Very lucky day: Saturday                                                                            <br />
*Very lucky colour: black                                                                                  <br />
*Lucky day: Wednesday                                                                             <br />
*Lucky colour: green                                                                             <br />
";                    
 
$attachment = array ( 'name' => 'Your Day of Birth & You',
'href' => 'http://apps.facebook.com/dobirth',
'description' => "$name was born on Monday! Monday born people have Good memory, are Serious and Love to travel. Their lucky day is Saturday. Black is their Lucky color",
'media' => array (array ( 'type' => 'image',
'src' => 'http://insha.in/fb/dobirth/hands.png',
'href' => 'http://apps.facebook.com/dobirth'))
);
$attachment = json_encode($attachment); 
$mes = "Try this cool app!";  
 break;

  case '2':
	  $message="
You were born on Tuesday!  <br />
As per Thai culture, Each day of the week has its own significance & dictates character.<br /> 
*Tuesday born Character:  Brave, Active, Broad and Serious mind  <br />
*Very lucky day: Thursday                                                                           <br />
*Very lucky colour: Yellow                                                                                  <br />
*Lucky day: Saturday                                                                            <br />
*Lucky colour: black                                                                             <br />
";                    
     
 $attachment = array ( 'name' => 'Your Day of Birth & You',
'href' => 'http://apps.facebook.com/dobirth',
'description' => "$name was born on Tuesday! Tuesday born people are Brave, Active, Broad and Serious mind. Their lucky day is Thursday. Yellow is their Lucky color",
'media' => array (array ( 'type' => 'image',
'src' => 'http://insha.in/fb/dobirth/hands.png',
'href' => 'http://apps.facebook.com/dobirth'))
);
$attachment = json_encode($attachment); 
$mes = "Try this cool app!";  
 break;
 
 case '3':
		  $message="
You were born on Wednesday!  <br />
As per Thai culture, Each day of the week has its own significance & dictates character.<br /> 
*Wednesday born Character: Hard working, Diligent, Honest, Ambitious, Gregarious, Fun loving  <br />
*Very lucky day: Monday                                                                           <br />
*Very lucky colour: white                                                                                  <br />
*Lucky day: Sunday                                                                            <br />
*Lucky colour: orange                                                                             <br />
";                    
         
$attachment = array ( 'name' => 'Your Day of Birth & You',
'href' => 'http://apps.facebook.com/dobirth',
'description' => "$name was born on Wednesday! Wednesday born people are Hard working, Diligent, Honest, Ambitious, Gregarious, Fun loving. Their lucky day is Monday. White is their Lucky color",
'media' => array (array ( 'type' => 'image',
'src' => 'http://insha.in/fb/dobirth/hands.png',
'href' => 'http://apps.facebook.com/dobirth'))
);
$attachment = json_encode($attachment); 
 $mes = "Try this cool app!";  
 break;

case '4':
		  $message="
You were born on Thursday!  <br />
As per Thai culture, Each day of the week has its own significance & dictates character.<br /> 
*Thursday born Character: Good heart, Graceful, Tranquil, Honest  <br />
*Very lucky day: Sunday                                                                           <br />
*Very lucky colour: orange                                                                                  <br />
*Lucky day: Friday                                                                            <br />
*Lucky colour: blue                                                                             <br />
";                    
          
$attachment = array ( 'name' => 'Your Day of Birth & You',
'href' => 'http://apps.facebook.com/dobirth',
'description' => "$name was born on Thursday! Thursday born people are Good heart, Graceful, Tranquil, Honest. Their lucky day is Sunday. Orange is their Lucky color",
'media' => array (array ( 'type' => 'image',
'src' => 'http://insha.in/fb/dobirth/hands.png',
'href' => 'http://apps.facebook.com/dobirth'))
);
$attachment = json_encode($attachment);  
$mes = "Try this cool app!";  
 break; 
 
case '5':
	 $message="
You were born on Friday!  <br />
As per Thai culture, Each day of the week has its own significance & dictates character.<br /> 
*Friday born Character: Ambitious, Gregarious, Fun loving  <br />
*Very lucky day: Tuesday                                                                           <br />
*Very lucky colour: pink                                                                                  <br />
*Lucky day: Monday                                                                            <br />
*Lucky colour: white                                                                             <br />
";  
 
$attachment = array ( 'name' => 'Your Day of Birth & You',
'href' => 'http://apps.facebook.com/dobirth',
'description' => "$name was born on Friday! Friday born people are Ambitious, Gregarious, Fun loving. Their lucky day is Tuesday. Pink is their Lucky color",
'media' => array (array ( 'type' => 'image',
'src' => 'http://insha.in/fb/dobirth/hands.png',
'href' => 'http://apps.facebook.com/dobirth'))
);
$attachment = json_encode($attachment);                 
$mes = "Try this cool app!";  
 break;

 case '6':
	  $message="
You were born on Saturday!  <br />
As per Thai culture, Each day of the week has its own significance & dictates character.<br /> 
*Saturday born Character: Logical, Tranquil, Reclusive  <br />
*Very lucky day: Friday                                                                           <br />
*Very lucky colour: blue                                                                                  <br />
*Lucky day: Wednesday                                                                             <br />
*Lucky colour: light green                                                                             <br />
";                    
  
$attachment = array ( 'name' => 'Your Day of Birth & You',
'href' => 'http://apps.facebook.com/dobirth',
'description' => "$name was born on Saturday! Saturday born people are Logical, Tranquil, Reclusive. Their lucky day is Friday. Blue is their Lucky color",
'media' => array (array ( 'type' => 'image',
'src' => 'http://insha.in/fb/dobirth/hands.png',
'href' => 'http://apps.facebook.com/dobirth'))
);
$attachment = json_encode($attachment);
       
$mes = "Try this cool app!";  
		break;	
  
 }
 
 echo "
<script type='text/javascript'>
function post() {
  //Facebook.streamPublish(\"\");
  Facebook.streamPublish(\"$mes\", $attachment);
 }
</script>
";
  echo "<table cellspacing=\"0\" cellpadding=\"0\" width=\"700\" background=\"http://insha.in/fb/dobirth/background3.png\"><tr><td valign=\"left\" height=\"300\" width=\"700\"><font style=\"color:brown;font-size:11pt;font-family:book antiqua;font-weight:bold;\">";
  //echo "hello there";
  echo $message;
  echo "Share this info with friends? Click here"; echo "<input type='button' value='Publish' onclick='post();'/>"; 
 echo"</td></tr>";
 echo "</table>";
?>