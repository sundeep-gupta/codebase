<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class tooltipWebGalleryEngine {
	
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
		
		// run code just once
		static $once = 0;
		
		if (!$once) {
			
			$document = &JFactory::getDocument(); // set document for next usage
		
			$enginefolder = plgContentCdWebGallery::engineFolder();
			
			// add script
			$document->addScript($enginefolder . '/app/js/jquery.tooltip.js');
			// add CSS
			$document->addStyleSheet($enginefolder . '/app/css/tooltip.css', 'text/css');
			
			$preview_script = "
			<!--
			jQuery(document).ready(function($){
				var images = $('a[rel*=webgallery_tooltip]');
				images.click( function () {
					return false;
        		}).tooltip({ 
				    delay: 0,
				    fade: 250,
				    top: 10,
				    left: 10,
				    track: true, 
				    showURL: false, 
				    bodyHandler: function() {
				    	var title = $(this).children('img').attr('title');				    
				    	var img = '<div class=\"cdwebgallery_tooltip\"><img src=\"'+this.href+'\" title=\"\" alt=\"\" /><span>' + title + '<\/span><\/div>';
				    	return img;
			    	} 
				});
			});
			//-->";
			$document->addScriptDeclaration($preview_script);
			$once = 1;
		}
		
		
		
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
		
		$i = 0;
		foreach($image_set as $image) {	
			
			$thumb_src_path = $image->thumb_src;
			
			$thumb_width = $image->thumb_width;
			$thumb_height = $image->thumb_height;
			$thumb_alt = $image->img_alt;
			$thumb_title = $image->img_title;
			
			$img_tag = '<img src="' . $thumb_src_path . '" width="' . $thumb_width . '" height="' . $thumb_height . '" alt="" title="' . $thumb_title . '" />';
			
			$img_src = $image->img_src;
			
			$tag_a = '<a href="' . $img_src . '" rel="webgallery_tooltip" title=""></a>';			
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