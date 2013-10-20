<?php
/*
// "Very Simple Image Gallery" Plugin for Joomla 1.5 - Version 1.5.2
// License: http://www.gnu.org/copyleft/gpl.html
// Author: Andreas Berger - http://www.bretteleben.de
// Copyright (c) 2009 Andreas Berger - andreas_berger@bretteleben.de
// Project page and Demo at http://www.bretteleben.de
// ***Last update: 2009-12-05***
*/

defined( '_JEXEC' ) or die( 'Restricted access' );

class JElementbexml extends JElement{
	var	$_name = 'Very Simple Image Gallery';
	var $_version = '1.5.2';

	function fetchElement($name, $value, &$node, $control_name){
		$view =  $node->attributes('view');

		switch ($view){

		case 'intro':
            $html="<div style='background-color:#c3d2e5;margin:-4px;padding:2px;'>";
            $html.="<b>".$this->_name." Version: ".$this->_version."</b><br />";
            $html.="for support and updates visit:&nbsp;";
            $html.="<a href='http://www.bretteleben.de' target='_blank'>www.bretteleben.de</a>";
            $html.="</div>";
		break;

		case 'gallery':
            $html="<div style='background-color:#c3d2e5;margin:-4px;padding:2px;'>";
            $html.="<b>Gallery</b><br />Settings regarding the gallery in general.";
            $html.="</div>";
		break;

		case 'thumbs':
            $html="<div style='background-color:#c3d2e5;margin:-4px;padding:2px;'>";
            $html.="<b>Thumbnails</b><br />Settings regarding the thumbnails (size, quality, position, ...).";
            $html.="</div>";
		break;

		case 'captions':
            $html="<div style='background-color:#c3d2e5;margin:-4px;padding:2px;'>";
            $html.="<b>Captions</b><br />Show title and/or text for images. Captions are set in the article using the code {vsig_c}parameters{vsig_c} (see Howto).";
            $html.="</div>";
		break;

		case 'links':
            $html="<div style='background-color:#c3d2e5;margin:-4px;padding:2px;'>";
            $html.="<b>Links</b><br />Link images to any target (default or selective). Links are set in the article using the code {vsig_l}parameters{vsig_l} (see Howto).";
            $html.="</div>";
		break;

		case 'sets':
            $html="<div style='background-color:#c3d2e5;margin:-4px;padding:2px;'>";
            $html.="<b>Sets</b><br />This feature allows to split galleries to multiple sets and enables necessary navigation (see Howto).";
            $html.="</div>";
		break;

		default:
            $html="<div style='background-color:#c3d2e5;margin:-4px;padding:2px;'>";
            $html.="<b>Other settings</b>";
            $html.="</div>";
		break;

		}
		return $html;
	}
}