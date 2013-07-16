<?php
 // require_once 'req.php';
require_once 'facebook.php';
$facebook = new Facebook(array(
  'appapikey' => '90d34c73a48ad051424db197cd8bcf24',
 // 'appId'  => '173641592651350',
  'secret' => 'c91fb6b1809cd241efb959ec36388804',
  'cookie' => true,
));

$session = $facebook->getSession();

function list_months($list_name, $num_months, $sel_month = '') { 

  $list .= "<select name=$list_name>\n"; 
  if ($sel_month == '') $list .= "<option value=''>Month</option>\n"; 

//  $year = date("Y"); //get current year 
   $month = '1';
  for ($k=0; $k<$num_months; ++$k) { 
    if ($sel_month == $month)$list .= "<option value=$month selected>$month</option>\n"; 
    else $list .= "<option value=$month>$month</option>\n";  
    $month += 1; 
  } 

  $list .= "</select>\n"; 

  echo $list; 
 }

function list_days($list_name, $num_days, $sel_day = '') { 

  $list .= "<select name=$list_name>\n"; 
  if ($sel_day == '') $list .= "<option value=''>Day</option>\n"; 

//  $year = date("Y"); //get current year 
   $day = '1';
  for ($k=0; $k<$num_days; ++$k) { 
    if ($sel_day == $day)$list .= "<option value=$day selected>$day</option>\n"; 
    else $list .= "<option value=$day>$day</option>\n";  
    $day += 1; 
  } 

  $list .= "</select>\n"; 

  echo $list; 
 }
 
function list_years($list_name, $num_years, $sel_year = '') { 

  $list .= "<select name=$list_name>\n"; 
  if ($sel_year == '') $list .= "<option value=''>Year</option>\n"; 

//  $year = date("Y"); //get current year 
   $year = '2100';
  for ($k=0; $k<$num_years; ++$k) { 
    if ($sel_year == $year)$list .= "<option value=$year selected>$year</option>\n"; 
    else $list .= "<option value=$year>$year</option>\n";  
    $year -= 1; 
  } 

  $list .= "</select>\n"; 

  echo $list; 
 } 

/* function call examples */ 
//list_years("year", 10); 
//list_years("year", 200, 2010); 
//list_months("month", 12); 
//list_days("days", 31); 
?>
<html>
<head>
<title>Day of week</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
 <title>Day Of Birth</title>
  <meta property="og:title" content="Day Of Birth"/>
  <meta property="og:type" content="bar"/>
  <meta property="og:image" content="http://profile.ak.fbcdn.net/hprofile-ak-snc4/hs355.snc4/41800_157551267602956_958536_n.jpg"/>
  <meta property="og:site_name" content="dobirth"/>
  <meta property="fb:app_id" content="173641592651350"> <!-- Replace app id with your own-->
  <meta property="og:description" content="Tell your date of birth"/>
<meta property="fb:admins" content="652390905,100001542439351"/>
<link type="text/css" rel="stylesheet" href="style.css">
<script src="http://connect.facebook.net/en_US/all.js#xfbml=1"></script>

</head>

<iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fapps.facebook.com%2Fdobirth%2F&amp;layout=standard&amp;show_faces=true&amp;width=450&amp;action=like&amp;colorscheme=light&amp;height=80" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:450px; height:80px;" allowTransparency="true"></iframe>
       <table cellspacing="0" cellpadding="0" width="700" height="300" background="http://insha.in/fb/dobirth/background3.png"><tr><td valign="left" font style="color:brown;font-size:12pt;font-family:book antiqua;font-weight:bold;">
<form name="getDate" method="post" action="dow.php">
  <table border="0" cellspacing="0" cellpadding="4">
   <!-- <tr>
      <td nowrap>
        <font size="2" face="Arial, Helvetica, sans-serif">
         Enter Date (dd/mm/yyyy): 
      </font>
      </td>
      <td nowrap>
        <font size="2" face="Arial, Helvetica, sans-serif">
        <input name="day" type="text" size="2" maxlength="2">
        /
        <input name="mon" type="text" size="2" maxlength="2">
        /
        <input name="year" type="text" size="4" maxlength="4">       
        </font>
      </td>
      <td nowrap>
        <font size="2" face="Arial, Helvetica, sans-serif">
        ex: "05/20/1960"
        </font>
      </td>
    </tr>
         -->
    
    
    <tr><td> 
       <font size="2" face="Arial, Helvetica, sans-serif">
         Enter Date (dd/mm/yyyy): 
    <?php  list_days("iday", 31); ?><?php  list_months("imonth", 12); ?> <?php  list_years("iyear", 200, 2010); ?> 
    
     <input name="submit" type="submit" value="Submit Date">
    </td> </tr>
   
  </table>
  
    
</form>
</font></p></td></tr></table>
<!--<fb:comments xid="c_test_10101010" width="425"></fb:comments> -->
</html>
