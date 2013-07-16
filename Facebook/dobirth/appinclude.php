<?php
// Awesome Facebook Application
// 
// Name: Day of Birth
// 

require_once 'facebook.php';

// Create our Application instance.
$facebook = new Facebook(array(
  'appId'  => '173641592651350',
  'secret' => 'c91fb6b1809cd241efb959ec36388804',
  'cookie' => true,
));

/*  $user = $facebook->require_login(); #get the current user
#Catch an invalid session_key
try {
if (!$facebook->api_client->users_isAppAdded()) {
$facebook->redirect($facebook->get_add_url());
}
} catch (Exception $ex) {
#If invalid then redirect to a login prompt
$facebook->set_user(null, null);
$facebook->redirect($appcallbackurl);
}*/
?>