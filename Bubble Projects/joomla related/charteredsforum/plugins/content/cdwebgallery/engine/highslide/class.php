<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class highslideWebGalleryEngine {
	
	/**
	 * Check the pre-requirements
	 * 
	 * @return string
	 */
	function preRequirements() {
		$message = plgContentCdWebGallery::checkScriptegrator('1.3.8', 'highslide', 'site');
		return $message;
	}

	/**
	 * Insert neccessary script to header
	 * 
	 * @return void
	 */
	function header() {
		
		$document = &JFactory::getDocument(); // set document for next usage
		
		$random_id = plgContentCdWebGallery::options('id');
		
		$enginefolder = plgContentCdWebGallery::engineFolder();
		
		// engine params
		$params = plgContentCdWebGallery::parseIni(dirname(__FILE__));
		$show_controls = ($params->get('show_controls', 1) ? 'true' : 'false');
		
		$controls_position = $params->get('controls_position', 'top center');
		$controls_opacity = $params->get('controls_opacity', 0.75);
		$hide_controls_onmouseout = ($params->get('hide_controls_onmouseout', 1) ? 'true' : 'false');
		$interval = $params->get('interval', 5000);
		$fixedControls = (string)$params->get('fixedControls');
		
		switch ($fixedControls) {
			case 'fit':
			default:
				$fixedControls = '\'fit\'';
				break;
			case '':
				$fixedControls = 'false';
				break;
			case '1':
				$fixedControls = 'true';
				break;
		}
		
			$script = "
			<!--
			// Add the controlbar
			hs.addSlideshow({
				slideshowGroup: '$random_id',
				interval: $interval,
				repeat: false,
				useControls: $show_controls,
				fixedControls: $fixedControls,
				overlayOptions: {
					opacity: $controls_opacity,
					position: '$controls_position',
					hideOnMouseOut: $hide_controls_onmouseout
				}
			});
			//-->";
			$document->addScriptDeclaration($script);
			
			$document->addStyleSheet($enginefolder . '/app/css/highslide.css', 'text/css');
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
		
		$slideshowGroup = 'slideshowGroup: \'' . $random_id . '\', ';
		
		// engine params
		$params = plgContentCdWebGallery::parseIni(dirname(__FILE__));
		
		$highslide_theme = $params->get('highslide_theme', 'white');
		
		switch ($highslide_theme) {
			case 'white':
			default:
				$wrapperClassName = 'outlineType: \'rounded-white\'';
				break;
			case 'dark':
				$wrapperClassName = 'wrapperClassName: \'dark\', outlineType: \'glossy-dark\'';
				break;
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
			
			$tag_a = '<a href="' . $img_src . '" class="highslide" title="' . $thumb_title . '" onclick="return hs.expand(this, { ' . $slideshowGroup . $wrapperClassName . ', captionText: \'' . $thumb_title . '\' } )"></a>';
			
			// remove doubble empty space
			$tag_a = str_replace('  ', '', $tag_a);			
			
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
