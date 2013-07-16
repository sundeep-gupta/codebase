<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/* For test purpose */
 $_POST['ID'] = 2;
 $_POST['start_date'] = '2010-2-23';
 $_POST['end_date'] = '2010-6-23';
require_once('Subscription.php');
session_start();
$_SESSION['userid'] = 8;
if(!isset($_SESSION['userid'])) {
    include('index.php'); exit;
}
if(! isset($_POST['ID'])) {
    echo "Please select a cuisine <a href='cuisine_show.php'>Here</a>"; exit;
}
if(!( isset($_POST['start_date']) && isset($_POST['end_date']))) {
    echo 'Please select the date correctly!'; exit;
}
$subscription = new Subscription();
$subscription->set_userid($_SESSION['userid']);
$subscription->set_cuisineid($_POST['ID']);
$subscription->set_start_date($_POST['start_date']);
$subscription->set_end_date($_POST['end_date']);
$subscription->create();
echo "Congrats! You are now subscribed!";

?>
