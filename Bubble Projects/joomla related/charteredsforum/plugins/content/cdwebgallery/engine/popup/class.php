<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class popupWebGalleryEngine {
	
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
		
		$compress = plgContentCdWebGallery::pluginParams('compress', 1);
		
		static $run_once = 0;
		
		if (!$run_once) {
			$script = "
			<!--
			jQuery(document).ready(function($){
				$('a[rel^=webgallery_popup]').click( function (e) {
					e.preventDefault();
					var rel_attr = $(this).attr('rel').split(' ');
					var dimension = rel_attr[1].split('x');
					var width = (dimension[0] * 1) + 20;
					var height = (dimension[1] * 1) + 20;
					var link = $(this).attr('href');
					window.open( link, 'webgallery_popup', 'left=20, top=20, height=' + height + ', width=' + width + '' );
				});
			});
			//-->";
			$document->addScriptDeclaration($script);
			$run_once = 1;
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
			$img_src_path = $image->img_src_path;
			
			$src_dimension = getimagesize($img_src_path);
			$img_src_width = $src_dimension[0];
			$img_src_height = $src_dimension[1];
			unset($src_dimension);
			
			$tag_a = '<a href="' . $img_src . '" rel="webgallery_popup '.$img_src_width . 'x' . $img_src_height . '" title="' . $thumb_title . '"></a>';
			
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