<?php

    require_once 'facebook.php';
    require_once 'app_info.php';

    $appurl = 'http://apps.facebook.com/wordoracle/app.php';
    $facebook = getFacebookObject();
    $session =  getSession();
    
    $me = null;
    $logoutUrl = null;
    $loginUrl = $facebook->getLoginUrl();
    if ($session) {
        try {
            $uid = $facebook->getUser();
            $me = $facebook->api('/me');
            $logoutUrl = $facebook->getLogoutUrl();
            $loginUrl = null;
        } catch (FacebookApiException $e) {
            error_log($e);
        }
    }
    $authorize = getAuthorizeURL($appurl);
?>
<!doctype html>
<html xmlns:fb="http://www.facebook.com/2008/fbml">
  <head>
    <title>WordOracle - Learn Word by Sentence</title>
    <meta property="og:title" content="WordOracle"/>
    <meta property="og:type" content="bar"/>
    <meta property="og:image" content="http://profile.ak.fbcdn.net/hprofile-ak-snc4/hs355.snc4/41800_157551267602956_958536_n.jpg"/>
    <meta property="og:site_name" content="WordOracle"/>
    <meta property="fb:app_id" content="<?php echo FB_APPID; ?>"> <!-- Replace app id with your own-->
    <meta property="og:description" content="Thought of the day"/>
    <script src="http://connect.facebook.net/en_US/all.js#appId=<?php echo FB_APPID; ?>&amp;xfbml=1"></script>
    <style>
      body {
        font-family: 'Lucida Grande', Verdana, Arial, sans-serif;
        background-image:url('dark-c.png');
      }
      h1 a {
        text-decoration: none;
        color: #000000;
      }
      h1 a:hover {
        text-decoration: underline;
      }
    </style>
  </head>
  
  <table cellspacing="0" cellpadding="0" width="700" height="110" background="http://insha.in/fb/dobirth/background3.png">
    <tr>
      <td valign="left" height="90" font style="color:brown;font-size:12pt;font-family:book antiqua;font-weight:bold;">
        <div>Hello <font style="color:black;font-size:12pt;font-family:book antiqua;font-weight:bold;"><?php echo $me['name']; ?>!</font></a></h2> <br />
          Welcome to WordOracle</div>
        <div> <br />Click <a href= "<?php echo $authorize;?>">here</a> to access the application.</div>
      </td></tr>
      <tr><td>
      <h3 font style="color:grey;font-size:12pt;font-family:monotype corsiva;font-weight:bold;">A <a href="#"><img src="http://insha.in/fb/wordoracle/bubble.png"></a>Product. Copyright 2010</h3>
       </td></tr>
    </table>
      <?php if ($me) : ?>
        <a href="<?php echo $logoutUrl; ?>"><img src="http://static.ak.fbcdn.net/rsrc.php/z2Y31/hash/cxrz4k7j.gif"></a>
      <?php endif ?>
</html>
