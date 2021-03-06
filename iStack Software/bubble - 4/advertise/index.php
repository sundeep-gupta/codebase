<?php

require_once 'path_cnfg.php';
require_once(path_cnfg('pathToLibDir').'func_common.php');
require_once(path_cnfg('pathToLibDir').'func_checkUser.php');
require_once(path_cnfg('pathToCnfgDir').'cnfg_vars.php');
require_once(path_cnfg('pathToLibDir').'vars_gbl.php');

#$cookie = $_COOKIE['log_in_cookie'];

define('PRJ_NAME', 'Advertise');
define ('LIB', '/srv/www/php-lib');

require (LIB.'/Bubble/'.PRJ_NAME.'/PresenterFactory.php');

if (isset($_GET{'action'})) {
    $module = $_GET{'action'};
} else {
    $module = 'index';
}
if (isset($_GET{'class'})) {
    $class = $_GET{'class'};
} else {
    $class = $module;
}

if (isset($_GET{'event'})) {
    $event = $_GET{'event'};
} else {
    $event = '__default';
}  

$class_file = LIB.'/Bubble/'.PRJ_NAME.'/modules/'.$module.'/'.$class.'.php';

if (file_exists($class_file)) {
    require_once($class_file);
    if (class_exists($class)){
	$instance  = new $class();
	$result    = $instance->$event();
	$presenter = PresenterFactory::getPresenter($instance, $result);
	$presenter->display();
    } 
}

?>
