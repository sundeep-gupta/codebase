<?php
/**
* googleSearch_cse component
* This component allows you to add Google Adsense Search to your Joomla site
* with the search results displayed right inside your Joomla page!
* @version 1.5
* @package None
* @copyright (C) Copyright 2006-2009 by kksou.com
* Author: kksou
* Website: http://www.kksou.com/php-gtk2
* v1.5 May 12, 2008
*/

defined('_JEXEC') or die();
require_once(JPATH_COMPONENT.DS.'googlesearch.lib.php');

$db =& JFactory::getDBO();
$db->setQuery("SELECT * FROM #__googleSearch_conf LIMIT 1");
$rows = $db->loadObjectList();
$r = $rows[0];

$app = new googleSearch_DisplayForm($r);

?>
