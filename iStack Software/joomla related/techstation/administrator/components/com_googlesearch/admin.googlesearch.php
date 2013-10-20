<?php
/**
* admin.googlesearch.php
* Author: kksou
* Copyright (C) 2006-2009. kksou.com. All Rights Reserved
* Website: http://www.kksou.com/php-gtk2
* May 12, 2008
*/

defined('_JEXEC') or die();

JTable::addIncludePath(JPATH_COMPONENT.DS.'tables');
require_once(JPATH_COMPONENT.DS.'controller.php');
require_once(JPATH_COMPONENT.DS.'admin.googlesearch.lib.php');

$controller = new googleSearchController();
$controller->registerDefaultTask('listConfiguration');
$task = JRequest::getCmd('task');
$controller->execute($task);
$controller->redirect();

?>