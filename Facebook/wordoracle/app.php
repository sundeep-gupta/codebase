<?php
    require_once 'app_info.php';
    try {
        $success = getPermanentAccessToken(FB_APP_URL . '/app.php', $_GET['code']);
    } catch(Exception $e) {
        error_log($e);
    }
?>
<html>
<head>
<title>WordOracle</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
 <title>WordOracle</title>
  <meta property="og:title" content="WordOracle"/>
  <meta property="og:type" content="bar"/>
  <meta property="og:image" content="http://profile.ak.fbcdn.net/hprofile-ak-snc4/hs355.snc4/41800_157551267602956_958536_n.jpg"/>
  <meta property="og:site_name" content="WordOracle"/>
  <meta property="fb:app_id" content="<?php echo FB_APPID; ?>"> <!-- Replace app id with your own-->
  <meta property="og:description" content="Thought of the day"/>
  <meta property="fb:admins" content="652390905,100001542439351"/>
  <link type="text/css" rel="stylesheet" href="style.css">
  <script src="http://connect.facebook.net/en_US/all.js#xfbml=1"></script>
</head>
<table cellspacing="0" cellpadding="0" width="700" height="110" background="http://insha.in/fb/dobirth/background3.png">
  <tr>
    <td valign="left" height="90" font style="color:brown;font-size:12pt;font-family:book antiqua;font-weight:bold;">Thank you for subscribing to WordOracle!
    </td> </tr>
    <tr><td>
      <h3 font style="color:grey;font-size:12pt;font-family:monotype corsiva;font-weight:bold;">A <a href="#"><img src="http://insha.in/fb/wordoracle/bubble.png"></a>Product. Copyright 2010</h3>
       </td></tr>
  </table>
</html>
