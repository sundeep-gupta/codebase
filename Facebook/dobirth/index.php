<?php
    require_once 'facebook.php';
    // Create our Application instance.
    $appid = '173641592651350'; 
    $facebook = new Facebook(array(
        'appapikey' => '90d34c73a48ad051424db197cd8bcf24',
        'secret' => 'c91fb6b1809cd241efb959ec36388804',
        'cookie' => true,
    ));
    $session = $facebook->getSession();

    $me = null;
    // Session based API call.
    if ($session) {
        try {
            $uid = $facebook->getUser();
            $me = $facebook->api('/me');
        } catch (FacebookApiException $e) {
            error_log($e);
        }
    }
    $appurl = 'http://www.insha.in/fb/dobirth/dopapp.php';
   // $authorize = 'https://graph.facebook.com/oauth/authorize?client_id='. $appid . '&redirect_uri=http://apps.facebook.com/dobirth/dobapp.php';
      $authorize = 'http://www.facebook.com/login.php?api_key='. $appid . '&connect_display=popup&v=1.0&next=http://apps.facebook.com/dobirth/dobapp.php&cancel_url=http://www.facebook.com/connect/login_failure.html&fbconnect=true&return_session=true&req_perms=read_stream,publish_stream,offline_access';
    // login or logout url will be needed depending on current user state.
    if ($me) {
        $logoutUrl = $facebook->getLogoutUrl();
    } else {
        $loginUrl = $facebook->getLoginUrl();
    }
    
?>
<!doctype html>
<html xmlns:fb="http://www.facebook.com/2008/fbml">
  <head>
    <title>Day Of Birth</title>
    <meta property="og:title" content="Day Of Birth"/>
    <meta property="og:type" content="bar"/>
    <meta property="og:image" content="http://profile.ak.fbcdn.net/hprofile-ak-snc4/hs355.snc4/41800_157551267602956_958536_n.jpg"/>
    <meta property="og:site_name" content="dobirth"/>
    <meta property="fb:app_id" content="173641592651350"> <!-- Replace app id with your own-->
    <meta property="og:description" content="Tell your date of birth"/>
    <script src="http://connect.facebook.net/en_US/all.js#appId=173641592651350&amp;xfbml=1"></script>
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
    <h1>Day of Birth</h1>
    
    
   <!-- <table cellspacing="0" cellpadding="0" width="700" bgcolor="black"><tr><td valign="left" height="700" width="700" style="word-wrap:break-word;background-image:url('http://insha.in/fb/dobirth/dark-c.png');background-repeat:no-repeat;background-position:50% 50%;"><font style="color:brown;font-size:10pt;font-family:book antiqua;font-weight:bold;text-align:justify;"> 
     <table cellspacing="0" cellpadding="0" width="700" height="700" background="http://insha.in/fb/dobirth/background3.png"><tr><td valign="left" height="700" width="700" style="background-image:url('http://insha.in/fb/dobirth/dark-c.png');background-repeat:no-repeat;"><font style="color:brown;font-size:10pt;font-family:book antiqua;font-weight:bold;">                        -->
       <table cellspacing="0" cellpadding="0" width="700" height="300" background="http://insha.in/fb/dobirth/background3.png"><tr><td valign="left" font style="color:brown;font-size:12pt;font-family:book antiqua;font-weight:bold;">
    <div>Hello <font style="color:black;font-size:12pt;font-family:book antiqua;font-weight:bold;"><?php echo $me['name']; ?>!</font></a></h2> <br />Welcome to Day of Birth App. Checkout Characteristic Traits of your Day of Birth</div>
    <div> <br />Click <a href= "<?php echo $authorize;?>">here</a> to access the application.</div>
  
</font></p></td></tr>
<tr><td valign="left" height="0" width="200"></td></tr>
    
    <?php if ($me) : ?>
    <a href="<?php echo $logoutUrl; ?>"><img src="http://static.ak.fbcdn.net/rsrc.php/z2Y31/hash/cxrz4k7j.gif"></a>
  <!--  <fb:comments xid="c_test_10101010" width="425"></fb:comments> -->
    <?php endif ?>

    </table>

</html>
