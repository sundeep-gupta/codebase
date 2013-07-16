<?php
/**
* googleSearch module
* This module complements the googleSearch component. 
* It allows you to add a Google search form as a module. 
* The search result will be displayed in the googleSearch component 
* - right inside your Joomla page!
* Author: kksou
* Copyright (C) 2006-2008. kksou.com. All Rights Reserved 
* Website: http://www.kksou.com/php-gtk2
* v1.5 May 16, 2008
*/

// no direct access
defined('_JEXEC') or die('Restricted access');

// Include the syndicate functions only once
require_once (dirname(__FILE__).DS.'helper.php');

$list = modGoogleSearchHelper::getList($params);
$Itemid = modGoogleSearchHelper::getItemid($params);
require(JModuleHelper::getLayoutPath('mod_googlesearch'));