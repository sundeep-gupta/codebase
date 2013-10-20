<?php

$path = '/home/premiumb';
if (! file_exists($path)) {
    $path = 'D:';
}

define('LIB',$path);
define('VIEW',$path.'/Bubble/PremiumBrokers/view');
define ('PB_LIB',$path);

require_once (PB_LIB.'/Bubble/PremiumBrokers/PresenterFactory.php');

session_start();

$class = 'Index';
$method = '__default';

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
