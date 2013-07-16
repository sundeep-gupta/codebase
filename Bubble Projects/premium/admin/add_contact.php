<?php 
$path = '/home/premiumb';
if (! file_exists($path)) {
    $path = '/srv/www';
}

define('LIB',$path.'/php-lib');
define('VIEW',$path.'/Bubble/PremiumBrokers/view');
define ('PB_LIB',$path);
require("$path/Bubble/PremiumBrokers/SAS/sas.php"); 

require_once (PB_LIB.'/Bubble/PremiumBrokers/PresenterFactory.php');

session_start();

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
# TODO: Write Error Pages
?> 



?>
<html>
<head>
</head>
<body>


<h1> HI </h1>

<a href="/home/premiumb/Backufiles/Footer.php">hi</a>

</body>
</html>