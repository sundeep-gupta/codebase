<?php

$path = '';
if (! file_exists($path)) {
    $path = 'D:';
}

define('ROOT',$path);
define('PROJECT','SmartConnexions');

define('LIB',   ROOT.'/Bubble/');
define('VIEW',  ROOT.'/Bubble/'.PROJECT.'/view');
define('MODEL', ROOT.'/Bubble/'.PROJECT.'/model');

require_once (ROOT.'/Bubble/'.PROJECT.'/PresenterFactory.php');

session_start();

$class = 'Index';
$method = '__default';

$class_file = MODEL.'/'.$class.'.php';

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
