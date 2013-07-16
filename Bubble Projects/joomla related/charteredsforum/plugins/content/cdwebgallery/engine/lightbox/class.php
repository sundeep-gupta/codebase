<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class lightboxWebGalleryEngine {
	
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
		
		// add script
		$document->addScript($enginefolder . '/app/js/jquery.lightbox.js');
		// add CSS
		$document->addStyleSheet($enginefolder . '/app/css/lightbox.css', 'text/css');
		
		$random_id = plgContentCdWebGallery::options('id');
		
		$script = '
		<!--
		jQuery(document).ready(function($){
			$(\'a[rel*=webgallery_lightbox_' . $random_id . ']\').lightBox({
				overlayOpacity: 0.6,
				imageLoading: \'' . $enginefolder . '/app/images/lightbox-ico-loading.gif\',
				imageBtnClose: \'' . $enginefolder . '/app/images/lightbox-btn-close.gif\',
				imageBtnPrev: \'' . $enginefolder . '/app/images/lightbox-btn-prev.gif\',
				imageBtnNext: \'' . $enginefolder . '/app/images/lightbox-btn-next.gif\',
				imageBlank: \'' . $enginefolder . '/app/images/lightbox-blank.gif\',
				containerResizeSpeed: 400,
				txtImage: \'\',
				txtOf: \'-\'
			});
		});
		//-->';
		$document->addScriptDeclaration($script);
		
	}

	/**
	 * Return tag array
	 * 
	 * @param $image_set
	 * 
	 * @return array
	 */
	function tag($image_set) {
		
		$random_id = plgContentCdWebGallery::options('id');
		
		$rel_tag = 'webgallery_lightbox_' . $random_id;
		
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
			
			$tag_a = '<a href="' . $img_src . '" rel="' . $rel_tag . '" title="' . $thumb_title . '"></a>';			
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