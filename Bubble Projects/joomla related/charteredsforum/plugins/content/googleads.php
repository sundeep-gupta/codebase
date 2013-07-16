<?php
/**
* googleAds plugin
* This plugin allows you to display Google Ads right inside your content pages.
* All you need is to copy and paste your AdSense unit code in your content item,
* and enclose them with the tags {googleAds} ... {/googleAds}
* Author: kksou
* Copyright (C) 2006-2008. kksou.com. All Rights Reserved
* Website: http://www.kksou.com/php-gtk2
* v1.5 May 30, 2008
* v1.51 August 17, 2008 added support for PHP4
* v1.52 December 9, 2008
- fixed the warning messasge "Notice: Undefined offset: 0 in googleads.php on line 53"
- fixed the warning messasge "Notice: Trying to get property of non-object on line 42"
*/

defined( '_JEXEC' ) or die( 'Direct Access to this location is not allowed.' );

jimport( 'joomla.event.plugin' );

class plgContentgoogleAds extends JPlugin {

	function plgContentgoogleAds( &$subject, $params ) {
		parent::__construct( $subject, $params );
 	}

	function onPrepareContent( &$row, &$params, $limitstart=0 ) {

		$plugin = new Plugin_googleAds($row);

		return true;
	}
}

class Plugin_googleAds {

	function Plugin_googleAds( &$row ) {

		$regex = '%\{googleAds\}(\n|\r\n|</p>|<p>|&nbsp;|<br\s/>)*(.*?)(\n|\r\n|</p>|<p>|&nbsp;|<br\s/>)*\{/googleAds\}%is';

		$plugin =& JPluginHelper::getPlugin('content', 'googleAds');

		if (isset($plugin->params)) {
			$pluginParams = new JParameter( $plugin->params );

			if ( !$pluginParams->get( 'enabled', 1 ) ) {
				$row->text = preg_replace( $regex, '', $row->text );
				return true;
			}
		}

		$contents = $row->text;
		if (preg_match_all( $regex, $contents, $matches_array, PREG_SET_ORDER )) {
			$count = count( $matches_array[0] );
			if ($count==0) return true;
			foreach($matches_array as $matches) {
				$this->process($row, $matches);
			}
			#$row->text = preg_replace( $regex, '', $row->text );
		}
		return true;
	}

	function process(&$row, $matches) {
		$str = $this->fix_str2($matches[2]);
		$row->text = str_replace($matches[0], $str, $row->text);
	}

	function fix_str($str) {
		$str = preg_replace(array('%&lt;\?php(\s|&nbsp;|<br\s/>|<br>|<p>|</p>)%s', '/\?&gt;/s', '/-&gt;/'), array('<?php ', '?>', '->'), $str);
		return $str;
	}

	function fix_str2($str) {
		$str = str_replace('<br>', "\n", $str);
		$str = str_replace('<br />', "\n", $str);
		$str = str_replace('<p>', "\n", $str);
		$str = str_replace('</p>', "\n", $str);
		$str = str_replace('&#39;', "'", $str);
		$str = str_replace('&quot;', '"', $str);
		$str = str_replace('&lt;', '<', $str);
		$str = str_replace('&gt;', '>', $str);
		$str = str_replace('&amp;', '&', $str);
		$str = str_replace('&nbsp;', ' ', $str);
		$str = str_replace('&#160;', "\t", $str);
		return $str;
	}
}

?>
