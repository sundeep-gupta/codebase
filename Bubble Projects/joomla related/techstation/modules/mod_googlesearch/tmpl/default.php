<?php
/**
* googleSearch module - default.php
* Author: kksou
* Copyright (C) 2006-2009. kksou.com. All Rights Reserved
* Website: http://www.kksou.com/php-gtk2
* v1.5 May 16, 2008
* v1.5.3 May 21, 2008
* v1.5.4 May 24, 2008
*/

// no direct access
defined('_JEXEC') or die('Restricted access');

$lib = JPATH_BASE.DS.'components'.DS.'com_googlesearch'.DS.'googlesearch.lib.php';

if (!file_exists($lib)) {
	print "ERROR >>> You need to install the latest version of <a href=\"http://www.kksou.com/php-gtk2/Joomla/googleSearch-component.php\">googleSearch component</a> to run this module!";
	return;
}
require_once($lib);

#$r = &$list;

$moduleclass_sfx = $params->get('moduleclass_sfx');
$app = new googleSearch_DisplayForm($list, 'mod_', '1.5', $Itemid, $moduleclass_sfx);
?>