<?php

#require ("~private/conf.php");
#require ("~lib/Bubble/HTML/PageHeader.php");
#require ("~lib/Bubble/HTML/HTMLHead.php");
#require ("~lib/Bubble/HTML/ThreePaneHTMLOutput.php");
#require ("~lib/Bubble/Utils.php");

/*
 * Write the logic to find the page to be displayed
 * And then redirect to corresponding page Handler...
 */

#
# 
#
define('PRJ_NAME', 'Framework');

require ('lib/Bubble/'.PRJ_NAME.'/PresenterFactory.php');

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

$class_file = 'lib/Bubble/'.PRJ_NAME.'/modules/'.$module.'/'.$class.'.php';

if (file_exists($class_file)) {
    require_once($class_file);
    if (class_exists($class)){
	$instance  = new $class();
	$result    = $instance->$event();
	$presenter = PresenterFactory::getPresenter($instance, $result);
	$presenter->display();
    } 
}

#$page = new ThreePaneHTMLOutput();




?>