<?php

$path = '/customers/crea2ive.com/crea2ive.com/httpd.www';
if (! file_exists($path)) {
    $path = 'D:';
}

define('ROOT',$path);
define('PROJECT','Creative');

define('LIB',   ROOT.'/Bubble/');
define('VIEW',  ROOT.'/Bubble/'.PROJECT.'/view');
define('MODEL', ROOT.'/Bubble/'.PROJECT.'/model');
define('AJAX', ROOT.'/Bubble/'.PROJECT.'/view/AJAX');

require_once (ROOT.'/Bubble/'.PROJECT.'/PresenterFactory.php');

session_start();
$class = $_GET['action'];
$method = '__default';

$class_file = AJAX.'/'.$class.'.php';

if (file_exists($class_file)) {

    require_once($class_file);
    $class .= 'Ajax';

    if (class_exists($class)){
    	$instance  = new $class();
    	echo $instance->get_xml();
    }
}
# TODO: Write Error Pages
?>
