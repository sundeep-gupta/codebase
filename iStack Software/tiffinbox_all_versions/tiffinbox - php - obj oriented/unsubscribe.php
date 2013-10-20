<?php
/* For test purpose */
// $_POST['sub_id'] = 3;
require_once('Subscription.php');
session_start();
$_SESSION['userid'] = 8;
if(!isset($_SESSION['userid'])) {
    include('index.php'); exit;
}
if(! isset($_POST['sub_id'])) {
    echo "Please select a subscription to unsubscribe."; exit;
}
// Get the subscription details.
$subscription = new Subscription($_POST['sub_id']);
if ( $subscription->get_userid() != $_SESSION['userid']) {
    echo "You are not authorized to unsubscribe !"; exit;
}
$subscription->deactivate();
echo "Congrats! You are now subscribed!";

?>
