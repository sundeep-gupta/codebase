<?php
/**
* admin.googlesearch.html.php
* Author: kksou
* Copyright (C) 2006-2009. kksou.com. All Rights Reserved
* Website: http://www.kksou.com/php-gtk2
* May 12, 2008
*/

defined('_JEXEC') or die();

class HTML_googleSearch
{
	function listConfiguration($option, &$row)
	{
		HTML_googleSearch::setMessageToolbar();
		$app = new googleSearch_config($option, $row);
	}

	function setMessageToolbar()
	{
		JToolBarHelper::title('googleSearch Configuration', 'generic.png');
		JToolBarHelper::save();
	}

}

?>