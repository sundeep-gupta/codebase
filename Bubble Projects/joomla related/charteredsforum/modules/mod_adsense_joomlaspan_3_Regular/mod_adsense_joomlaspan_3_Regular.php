<?php
/*
* @package Google AdSense Module 3.0 Regular for Joomla 1.5 from Joomlaspan.com
* @copyright Copyright (C) 2007 Joomlaspan.com. All rights reserved.
* @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
* Joomla! is free software.
* This extension is made for Joomla! 1.5;

** WE LOVE JOOMLA! **
*/

defined( '_JEXEC' ) or die( 'Restricted access' );

$adcss = $params->get('joomlaspan_ad_css');
$clientID = $params->get('joomlaspan_ad_client');
$altadurl = $params->get('joomlaspan_alternate_ad_url');
$altcolor = $params->get('joomlaspan_alternate_color');
$adtype = $params->get('joomlaspan_ad_type');
$adchannel = $params->get('joomlaspan_ad_channel');
$uifeatures = $params->get('joomlaspan_ad_uifeatures');

//sizes
$joomlaspan_ad_format = $params->get('joomlaspan_ad_format');
$joomlaspan_format = explode("-", $joomlaspan_ad_format);
$joomlaspan_ad_width = explode("x", $joomlaspan_format[0]);
$joomlaspan_ad_height = explode("_", $joomlaspan_ad_width[1]);

//colors
$border = $params->get('joomlaspan_color_border');
$bg = $params->get('joomlaspan_color_bg');
$link = $params->get('joomlaspan_color_link');
$text = $params->get('joomlaspan_color_text');
$url = $params->get('joomlaspan_color_url');

if ($adcss) 
	{ 
	echo "<div style=\"" . $adcss . "\">\r\n"; 
	}
		echo "<!-- Google AdSense Reg by Joomlaspan :: http://www.joomlaspan.com :: for Joomla! 1.5 -->\r\n"
		. "<script type=\"text/javascript\"><!--\r\n";
	
		if ($clientID) 
			{ 
			echo "google_ad_client = \"" . $clientID . "\";\r\n";
			} else {
			echo "google_ad_client = \"pub-1107008511660248\";\r\n";
			}
	
		if ($altcolor) 
			{ 
			echo "google_alternate_color = \"" . $altcolor . "\";\r\n";
			} else {
	
			if ($altadurl) 
				{ 
				echo "google_alternate_ad_url = \"" . $altadurl . "\";\r\n";
				} else {
				echo "google_alternate_ad_url = \"http://www.alternate-ad-url.com/alternate\";\r\n";
				} 
			}
	
		echo "google_ad_width = " .  $joomlaspan_ad_width[0] . "; \r\n"
		. "google_ad_height = " . $joomlaspan_ad_height[0] . "; \r\n"
		. "google_ad_format = \"" . $joomlaspan_format[0] . "\"; \r\n";
	
		if ($adtype) 
			{ 
			echo "google_ad_type = \"" . $adtype . "\"; \r\n";
			}
	
		if ($clientID == NULL) 
			{ 
			echo "google_ad_channel = \"2337602155\"; \r\n";
			} else {
			echo "google_ad_channel = \"" . $adchannel . "\"; \r\n";
			}
	
			echo "google_color_border = \"" . $border . "\"; \r\n"
			. "google_color_bg = \"" . $bg . "\"; \r\n"
			. "google_color_link = \"" . $link . "\"; \r\n"
			. "google_color_text = \"" . $text . "\"; \r\n"
			. "google_color_url = \"" . $url . "\"; \r\n";
		
		if ($uifeatures != NULL) 
			{
			echo "google_ui_features = \"rc:" . $uifeatures . "\"; \r\n";
			}
		echo "//--> \r\n"
		. "</script>\r\n"
		. "<script type=\"text/javascript\" src=\"http://pagead2.googlesyndication.com/pagead/show_ads.js\">\r\n"
		. "</script>\r\n"
		. "<!-- Google AdSense Reg by Joomlaspan :: http://store.joomlaspan.com :: for Joomla! 1.5 -->\r\n";
if ($adcss) 
	{ 
	echo '</div>'; 
	}
?>