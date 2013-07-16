<?php

$path = '/home/premiumb';
$dbhost = 'localhost';
$dbuser = 'premiumb_premium';
$dbname = 'premiumb_premiumb';
$dbpass = 'premium';
/* Email ID for Rent In Page */
$rentin_email = 'sundeep.techie@gmail.com';
/* Email ID for Rent Out Page */
$rentout_email = 'sundeep.techie@gmail.com';
/* Email ID for Contact Us page */
$pb_contact   = 'sundeep.techie@gmail.com';
/* Email ID for Sell page */
$sell_email  = 'sundeep.techie@gmail.com';
/* Email ID for Buy Page */
$buy_email = 'sundeep.techie@gmail.com';

$pb_email     = 'sundeep.techie@gmail.com';


if (! file_exists($path)) {
    $path   = 'D:';
    $dbhost = 'localhost';
    $dbuser = 'root';
    $dbname = 'test';
    $dbpass = '';

/* Email ID for Rent In Page */
    $rentin_email = 'info@premiumbrokers.co.in';
/* Email ID for Rent Out Page */
    $rentout_email = 'info@premiumbrokers.co.in';
/* Email ID for Contact Us page */
    $pb_contact   =  'info@premiumbrokers.co.in';
/* Email ID for Sell page */
    $sell_email  =  'info@premiumbrokers.co.in';
/* Email ID for Buy Page */
    $buy_email =  'info@premiumbrokers.co.in'; 
/* Email ID for generic mails like to send mail to others*/
    $pb_email     =  'info@premiumbrokers.co.in';
}

define('LIB',$path);
define('VIEW',$path.'/Bubble/PremiumBrokers/view');
define('PB_LIB',$path);
define('REDIRECT_ENABLED', true);

define('DB_HOST', $dbhost);
define('DB_NAME', $dbname);
define('DB_USER', $dbuser);
define('DB_PASS', $dbpass);
define('ADMIN_PASS','admin');

// Email Constants 
define('EMAIL_RENTIN', $rentin_email);  # email sent to rent in page
define('EMAIL_BUY',    $buy_email);  # email sent to rent in page
define('EMAIL_SELL',   $sell_email);
define('EMAIL_RENTOUT',$rentout_email);
define('EMAIL_PB',     $pb_email);      #from address of pb for addressbook msg
define('EMAIL_CONTACT',$pb_contact);
define('EMAIL_NOREPLY',$pb_email);
define('EMAIL_REQUIRE',$pb_email);

require_once (PB_LIB.'/Bubble/PremiumBrokers/PresenterFactory.php');

session_start();
#print_r($_POST);
#$_GET['action'] = 'Contact';
#$_GET['event'] = 'Authenticate';
#$_POST['password'] = 'demo';
#$_POST['sub'] = 'sub';
#$_POST['presenter'] = '/premium3/controller.php?action=AddressBook';

#action=Sell&event=property_form
if (isset($_GET['action'])) {
    $class = $_GET['action'];
} else {
    $class = 'Index';
}

if (isset($_GET['event'])) {
    $method = $_GET['event'];
} else {
    $method = '__default';
}

$class_file = PB_LIB.'/Bubble/PremiumBrokers/model/'.$class.'.php';

if (file_exists($class_file)) {

    require_once($class_file);
    $class .= 'Handler';

    if (class_exists($class)){   
	$instance  = new $class();
	$result    = $instance->$method();
	$presenter = PresenterFactory::get_presenter($instance, $result);
	echo $presenter->get_html_text();
    } 
}

?> 
