<html>
<head>
<title>Thought Today</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
 <title>Thought Today</title>
  <meta property="og:title" content="Thought Today"/>
  <meta property="og:type" content="bar"/>
  <meta property="og:image" content="http://profile.ak.fbcdn.net/hprofile-ak-snc4/hs355.snc4/41800_157551267602956_958536_n.jpg"/>
  <meta property="og:site_name" content="thoughttoday"/>
  <meta property="fb:app_id" content="<?php echo FB_APPID; ?>"> <!-- Replace app id with your own-->
  <meta property="og:description" content="Thought of the day"/>
  <meta property="fb:admins" content="652390905,100001542439351"/>
  <link type="text/css" rel="stylesheet" href="style.css">
  <script src="http://connect.facebook.net/en_US/all.js#xfbml=1"></script>
</head>

<fb:serverFbml>
<script type="text/fbml">
<fb:fbml>
    <fb:request-form
        method='POST'
        type='join my Smiley group'
        content='Would you like to join my Smiley group? 
            <fb:req-choice url="http://apps.facebook.com/smiley/yes.php" 
                label="Yes" />'
            <fb:req-choice url="http://apps.facebook.com/smiley/no.php" 
                label="No" />'
        <fb:multi-friend-selector 
            actiontext="Invite your friends to join your Smiley group.">
    </fb:request-form>
</fb:fbml>
</script>
</fb:serverFbml>

</html>
