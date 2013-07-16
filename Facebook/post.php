<?php  // begin php code

    require_once 'facebook.php';
    require_once 'app_info.php';


    $appurl =  FB_APP_URL . '/app.php';
    $facebook = getFacebookObject();
    $session = getSession();
    if ($session) {
        try {
            $uid = $facebook->getUser();
            $me = $facebook->api('/me');
            $q = "SELECT name FROM user WHERE uid='$uid'";
            $query = $facebook->api_client->fql_query($q);
        } catch (FacebookApiException $e) {
            error_log($e);
        }
    }  
    
    $name=$me['name'];
      $message="
You were born on Sunday!  <br />
As per Thai culture, Each day of the week has its own significance & dictates character.<br /> 
*Sunday born Character: Respectable, Carefree, Wise, and Beloved by both friends and relatives  <br />
*Very lucky day: Wednesday                                                                           <br />
*Very lucky colour: green                                                                                  <br />
*Lucky day: Tuesday                                                                            <br />
*Lucky colour: pink                                                                             <br />
";               

$attachment = array ( 'name' => 'Thought Of the Day',
'access_token'=> '165158873520727|2.AwMzoDs3A7FT3JcnAtU6Wg__.3600.1291579200-652390905|sOv-wN1p_-OugWAzLO6Lbn_35lE',
'description' => "This is Description",
'message' => 'This is message',
);
#$facebook->api('/me/feed','POST',$attachment);
print_r($attachment);
#165158873520727|2.Hrr6jssvBIDboRNotqnd_g__.3600.1292079600-652390905|c5wOYIkcNc7m5bJ2DiqjUIolZBM
#165158873520727|2.8kSlqSnc_ScnwO73RI_Vqw__.3600.1292083200-652390905|JwyKkL8B2VgB7vNE6ZsmHlYbPQE
#$attachment['access_token'] ='165158873520727165158873520727|2._ZhgiGD0W0kmK6BVWmy4VA__.3600.1291579200-100001542439351|TZIpz55q2GZ64FImOsPput9ChG4', 
#$facebook->api('/100001542439351/feed','POST',$attachment);
$attachment = json_encode($attachment); 
$mes = "Try this cool app!";    
 
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
  print_r($query);
  echo "Share this info with friends? Click here"; echo "<input type='button' value='Publish' onclick='post();'/>"; 
 echo"</td></tr>";
 echo "</table>";
?>
