<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class uiGalleryWebGalleryEngine {
	
	/**
	 * Check the pre-requirements
	 * 
	 * @return string
	 */
	function preRequirements() {
		$message = plgContentCdWebGallery::checkScriptegrator('1.3.8', 'jquery', 'site');
		return $message;
	}
	
	/**
	 * Insert neccessary script to header
	 * 
	 * @return void
	 */
	function header() {
		
		$document = &JFactory::getDocument(); // set document for next usage
		
		$enginefolder = plgContentCdWebGallery::engineFolder();
		
		$random_id = plgContentCdWebGallery::options('id');
		
		$params = plgContentCdWebGallery::parseIni(dirname(__FILE__));
		$theme = $params->get('theme', 'smoothness');
		
		$preview_script = "
		<!--
		jQuery(document).ready(function($){
			var ui_links = $('a.webgallery_uigallery_$random_id');
			ui_links.uigallery({ theme: \"$theme\" });
		});
		//-->";
		$document->addScriptDeclaration($preview_script);
		
		JScriptegrator::importUI('ui.dialog');
		JScriptegrator::importUITheme($theme, 'ui.dialog');
		
		// add CSS
		$document->addStyleSheet($enginefolder . '/app/css/uigallery.css', 'text/css');
		// add script
		$document->addScript($enginefolder . '/app/js/jquery.uigallery.js');
	}

	/**
	 * Return tag array
	 * 
	 * @param $image_set
	 * 
	 * @return array
	 */
	function tag($image_set) {
		
		$tag_array = array();
		
		$random_id = plgContentCdWebGallery::options('id');
		
		$i = 0;
		foreach($image_set as $image) {	
			
			$thumb_src_path = $image->thumb_src;
			
			$thumb_width = $image->thumb_width;
			$thumb_height = $image->thumb_height;
			$thumb_alt = $image->img_alt;
			$thumb_title = $image->img_title;
			
			$img_tag = '<img src="' . $thumb_src_path . '" width="' . $thumb_width . '" height="' . $thumb_height . '" alt="" title="' . $thumb_title . '" />';
			
			$img_src = $image->img_src;
			
			$img_src_path = $image->img_src_path;
			
			$img_attributes = getimagesize($img_src_path);
			$img_w = $img_attributes[0];
			$img_h = $img_attributes[1];
			
			$tag_a = '<a href="' . $img_src . '" class="webgallery_uigallery_' . $random_id . '" rel="'.$img_w . 'x' . $img_h . '" title=""></a>';
			
			// add html tag to array items
			
			$tag_array[$i]->img = $image->img_tag;
			$tag_array[$i]->img_thumb = $img_tag;
			$tag_array[$i]->a = $tag_a;
			$tag_array[$i]->title = $thumb_alt;
			
			$i++;
		}
		return $tag_array;
	}
	
}

?>