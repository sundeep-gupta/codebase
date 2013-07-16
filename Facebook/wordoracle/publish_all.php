<?php
    require_once 'facebook.php';
    require_once 'app_info.php';
    if (isAdmin()) {
        try {
            $success = publishAll();
            if($success) {
                $message = 'Successfully Published';
            } else {
                $message =  'Failed to publish on all users';
            }
        } catch (DatabaseException $e) {
            error_log($e);
        }
    } else {
        $message  = 'Must be an admin to access this page';
    }

?>
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
<table cellspacing="0" cellpadding="0" width="700" height="300" background="http://insha.in/fb/dobirth/background3.png">
  <tr>
    <td valign="left" font style="color:brown;font-size:12pt;font-family:book antiqua;font-weight:bold;"><?php echo $message; print isAdmin();?>
    </td> </tr>
  </table>
</html>
