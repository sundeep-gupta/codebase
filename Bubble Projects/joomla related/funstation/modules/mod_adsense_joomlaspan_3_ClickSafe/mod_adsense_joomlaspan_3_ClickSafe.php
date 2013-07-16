<?php
/*
* @package Google AdSense Module 3.0 ClickSafe for Joomla 1.5 from Joomlaspan.com
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
$border1 = $params->get('joomlaspan_color_border1');
$border2 = $params->get('joomlaspan_color_border2');
$border3 = $params->get('joomlaspan_color_border3',$border2);
$border4 = $params->get('joomlaspan_color_border4',$border2);

$bg1 = $params->get('joomlaspan_color_bg1');
$bg2 = $params->get('joomlaspan_color_bg2');
$bg3 = $params->get('joomlaspan_color_bg3',$bg2);
$bg4 = $params->get('joomlaspan_color_bg4',$bg2);

$link1 = $params->get('joomlaspan_color_link1');
$link2 = $params->get('joomlaspan_color_link2');
$link3 = $params->get('joomlaspan_color_link3',$link2);
$link4 = $params->get('joomlaspan_color_link4',$link2);

$text1 = $params->get('joomlaspan_color_text1');
$text2 = $params->get('joomlaspan_color_text2');
$text3 = $params->get('joomlaspan_color_text3',$text2);
$text4 = $params->get('joomlaspan_color_text4',$text2);

$url1 = $params->get('joomlaspan_color_url1');
$url2 = $params->get('joomlaspan_color_url2');
$url3 = $params->get('joomlaspan_color_url3',$url2);
$url4 = $params->get('joomlaspan_color_url4',$url2);

$ip_safe = 1;
if ($_SERVER["REMOTE_ADDR"] == $params->get('joomlaspan_ip_block1')) $ip_safe = 0;
if ($_SERVER["REMOTE_ADDR"] == $params->get('joomlaspan_ip_block2')) $ip_safe = 0;
if ($_SERVER["REMOTE_ADDR"] == $params->get('joomlaspan_ip_block3')) $ip_safe = 0;
if ($_SERVER["REMOTE_ADDR"] == $params->get('joomlaspan_ip_block4')) $ip_safe = 0;
if ($_SERVER["REMOTE_ADDR"] == $params->get('joomlaspan_ip_block5')) $ip_safe = 0;
if ($ip_safe) 
	{
		if ($adcss) 
			{ 
			echo "<div style=\"" . $adcss . "\">\r\n"; 
			}
		echo "<!-- Google AdSense by Joomlaspan :: http://www.joomlaspan.com :: for Joomla! 1.5 -->\r\n"
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
			
		if ($border2) 
			{ 
			echo "google_color_border = [\"" . $border1 . "\",\"" . $border2 . "\",\"" . $border3 . "\",\"" . $border4 . "\"]; \r\n";
			} else {
			echo "google_color_border = \"" . $border1 . "\"; \r\n";
			}
		
		if ($bg2) 
			{ 
			echo "google_color_bg = [\"" . $bg1 . "\",\"" . $bg2 . "\",\"" . $bg3 . "\",\"" . $bg4 . "\"]; \r\n";
			} else {
			echo "google_color_bg = \"" . $bg1 . "\"; \r\n";
			}
		
		if ($link2) 
			{ 
			echo "google_color_link = [\"" . $link1 . "\",\"" . $link2 . "\",\"" . $link3 . "\",\"" . $link4 . "\"]; \r\n";
			} else {
			echo "google_color_link = \"" . $link1 . "\"; \r\n";
			}
		
		if ($text2) 
			{ 
			echo "google_color_text = [\"" . $text1 . "\",\"" . $text2 . "\",\"" . $text3 . "\",\"" . $text4 . "\"]; \r\n";
			} else {
			echo "google_color_text = \"" . $text1 . "\"; \r\n";
			}
		
		if ($url2) 
			{ 
			echo "google_color_url = [\"" . $url1 . "\",\"" . $url2 . "\",\"" . $url3 . "\",\"" . $url4 . "\"]; \r\n";
			} else {
			echo "google_color_url = \"" . $url1 . "\"; \r\n";
			}
		
		if ($uifeatures != NULL) 
			{
			echo "google_ui_features = \"rc:" . $uifeatures . "\"; \r\n";
			}
		echo "//--> \r\n"
		. "</script>\r\n"
		. "<script type=\"text/javascript\" src=\"http://pagead2.googlesyndication.com/pagead/show_ads.js\">\r\n"
		. "</script>\r\n"
		. "<!-- Google AdSense by Joomlaspan :: http://store.joomlaspan.com :: for Joomla! 1.5 -->\r\n";
		if ($adcss) 
			{ 
			echo '</div>'; 
			}
	
	} else {
	echo '<div style="float: none; margin: 0px 0px 0px 0px;">' . $params->get('ip_block_alt_code') . '</div>';
	}
?>