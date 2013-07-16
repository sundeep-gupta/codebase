<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class greyboxWebGalleryEngine {
	
	/**
	 * Check the pre-requirements
	 * 
	 * @return string
	 */
	function preRequirements() {
		$message = '';
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
		
		// add CSS
		$document->addStyleSheet($enginefolder . '/app/gb_styles.css', 'text/css');
		
		$path = JURI::root(true) . '/plugins/content/cdwebgallery/engine/greybox/app/';
		
		$document->addScript("$enginefolder/app/application.js.php?path=$path");
		
		$document->addScript("$enginefolder/app/AJS.js");
		$document->addScript("$enginefolder/app/AJS_fx.js");
		$document->addScript("$enginefolder/app/gb_scripts.js");
		
	}

	/**
	 * Return tag array
	 * 
	 * @param $image_set
	 * 
	 * @return array
	 */
	function tag($image_set) {
	
		$options = plgContentCdWebGallery::options('all');
		$random_id = $options->id;
		$mode = $options->mode;
		unset($options);
		
		if ($mode == 'gallery') {
			$rel_tag = 'gb_imageset[\'' . $random_id . '\']';
		} else {
			$rel_tag = 'gb_image[]';			
		}
		
		$tag_array = array();
		
		$i = 0;
		
		foreach($image_set as $image) {
			
			
			$thumb_src_path = $image->thumb_src;
			
			$thumb_width = $image->thumb_width;
			$thumb_height = $image->thumb_height;
			$thumb_alt = $image->img_alt;
			$thumb_title = $image->img_title;
			
			$img_tag = '<img src="' . $thumb_src_path . '" width="' . $thumb_width . '" height="' . $thumb_height . '" alt="' . $thumb_alt . '" title="' . $thumb_title . '" />';
			
			$img_src = $image->img_src;
			
			$tag_a = '<a href="' . $img_src . '" title="' . $thumb_title . '" rel="' . $rel_tag . '"></a>';			
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
