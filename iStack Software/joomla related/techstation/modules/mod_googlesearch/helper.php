<?php
/**
* googleSearch module - default.php
* Author: kksou
* Copyright (C) 2006-2009. kksou.com. All Rights Reserved
* Website: http://www.kksou.com/php-gtk2
* v1.5 May 16, 2008
*/

// no direct access
defined('_JEXEC') or die('Restricted access');

require_once (JPATH_SITE.DS.'components'.DS.'com_content'.DS.'helpers'.DS.'route.php');

class modGoogleSearchHelper
{
	function getList(&$params)
	{
		global $mainframe;

		$db			=& JFactory::getDBO();
		$user		=& JFactory::getUser();
		$userId		= (int) $user->get('id');

		$db =& JFactory::getDBO();

		$db->setQuery("SELECT * FROM #__googleSearch_conf LIMIT 1");
		$rows = $db->loadObjectList();
		$r = $rows[0];
		return $r;
	}

	function getItemid(&$params)
	{
		global $mainframe;

		$db			=& JFactory::getDBO();
		$user		=& JFactory::getUser();
		$userId		= (int) $user->get('id');

		$db =& JFactory::getDBO();

		$db->setQuery("SELECT id FROM #__menu where link LIKE 'index.php?option=com_googlesearch%' LIMIT 1");
		$Itemid = $db->loadResult();
		return $Itemid;
	}
}
