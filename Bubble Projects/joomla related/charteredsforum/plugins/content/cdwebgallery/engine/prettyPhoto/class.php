<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class prettyPhotoWebGalleryEngine {
	
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
		
		$enginefolder = plgContentCdWebGallery::engineFolder();
		
		// add script
		$document->addScript($enginefolder . '/app/js/jquery.prettyPhoto.js');
		// add CSS
		$document->addStyleSheet($enginefolder . '/app/css/prettyPhoto.css', 'text/css');
		
		$params = plgContentCdWebGallery::parseIni(dirname(__FILE__));
		
		// theme
		$theme = $params->get('theme', 'light_rounded');
		
		$options = plgContentCdWebGallery::options('all');
		$random_id = $options->id;
		$mode = $options->mode;
		unset($options);
		
		if ($mode == 'gallery') {
			$rel = 'webgallery_prettyPhoto_' . $random_id;
			$script = '
			<!--
			jQuery(document).ready(function($){
				$("a[rel*=\''.$rel.'\']").prettyPhoto( {
					animationSpeed: \'normal\',
					padding: 40,
					opacity: 0.35,
					showTitle: false,
					allowresize: true,
					theme: \'' . $theme . '\'
				});
			});
			//-->';
			$document->addScriptDeclaration($script);
		} else {
			static $run_once = 0;
			
			if (!$run_once) {
				$rel = 'webgallery_prettyPhoto_single';
				$script = '
				<!--
				jQuery(document).ready(function($){
					$("a[rel*=\''.$rel.'\']").prettyPhoto( {
						animationSpeed: \'normal\',
						padding: 40,
						opacity: 0.35,
						showTitle: false,
						allowresize: true,
						theme: \'' . $theme . '\'
					});
				});
				//-->';
				$document->addScriptDeclaration($script);
				$run_once = 1;
			}
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
		
		$options = plgContentCdWebGallery::options('all');
		$random_id = $options->id;
		$mode = $options->mode;
		unset($options);
		
		if ($mode == 'gallery') {
			$rel_tag = 'webgallery_prettyPhoto_'.$random_id.'[' . $random_id . ']';;
		} else {
			$rel_tag = 'webgallery_prettyPhoto_single';
		}
		
		
		$tag_array = array();
		
		$i = 0;
		foreach($image_set as $image) {	
			
			$thumb_src_path = $image->thumb_src;
			
			$thumb_width = $image->thumb_width;
			$thumb_height = $image->thumb_height;
			$thumb_alt = $image->img_alt;
			$thumb_title = $image->img_title;
			
			$img_tag = '<img src="' . $thumb_src_path . '" width="' . $thumb_width . '" height="' . $thumb_height . '" alt="' . $thumb_title . '" title="' . $thumb_title . '" />';
			
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