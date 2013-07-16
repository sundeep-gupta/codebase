<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class fancyboxWebGalleryEngine {

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

		// engline params
		$params = plgContentCdWebGallery::parseIni(dirname(__FILE__));
		$zoom_speed_in = $params->get('zoom_speed_in', 500);
		$zoom_speed_out = $params->get('zoom_speed_out', 500);
		$show_overlay = ($params->get('show_overlay', 1) ? 'true' : 'false');
		$overlay_opacity = $params->get('overlay_opacity', 0.7);
		$overlay_color = $params->get('overlay_color', '#333');

		$options = plgContentCdWebGallery::options('all');
		$random_id = $options->id;
		$mode = $options->mode;

		unset($options);

		static $once = 0;
		
		if (!$once) {
			// add script
			$document->addScript($enginefolder . '/app/js/jquery.fancybox.js');
			// add CSS
			$document->addStyleSheet($enginefolder . '/app/css/jquery.fancy.css', 'text/css');
			$once = 1;
		}
		
		switch($mode) {
			case 'gallery':
			default:
				$script = '
					<!--
					jQuery(document).ready(function($){
						$("a[rel*=webgallery_fancybox_' . $random_id . ']").fancybox( {
							zoomSpeedIn: ' . $zoom_speed_in . ',
							zoomSpeedOut: ' . $zoom_speed_out . ',
							overlayShow: ' . $show_overlay . ',
							overlayOpacity: ' . $overlay_opacity . ',
							hideOnContentClick: true
						});
					});
					//-->';
				$document->addScriptDeclaration($script);
				break;
				
			case 'single':
				static $run_once = 0;

				if (!$run_once) {
					$script = '
						<!--
						jQuery(document).ready(function($){
							$("a[rel*=webgallery_fancybox_single]").fancybox( {
								zoomSpeedIn: ' . $zoom_speed_in . ',
								zoomSpeedOut: ' . $zoom_speed_out . ',
								overlayShow: ' . $show_overlay . ',
								overlayOpacity: ' . $overlay_opacity . ',
								hideOnContentClick: true,
								overlayColor: \'' . $overlay_color . '\'
							});
						});
						//-->
					</script>';
					$document->addScriptDeclaration($script);
					$run_once = 1;
				}
				break;
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
			$rel_tag = 'webgallery_fancybox_' . $random_id;
		} else {
			$rel_tag = 'webgallery_fancybox_single';
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