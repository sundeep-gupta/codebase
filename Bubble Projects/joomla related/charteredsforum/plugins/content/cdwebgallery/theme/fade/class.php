<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class fadeWebGalleryTheme {
	
	/**
	 * Check the pre-requirements
	 * 
	 * @return string or boolean
	 */
	function preRequirements() {
		$message = plgContentCdWebGallery::checkScriptegrator('1.3.8', 'jquery', 'site');
		return $message;
	}
	
	/**
	 * Header
	 * 
	 * @return void
	 */
	function header() {
		$document = &JFactory::getDocument(); // set document for next usage
    	
		$params = plgContentCdWebGallery::parseIni(dirname(__FILE__));
		
		$dimming_opacity = $params->get('dimming_opacity', 0.45);
		$fade_color = $params->get('fade_color', '#fff');
		
		$themefolder = plgContentCdWebGallery::themeFolder();
		
		static $run_once = 0;
		
		if (!$run_once) {
			
			// add script
			$document->addScript($themefolder . '/js/jquery.fadeimage.js');
			$document->addStyleSheet($themefolder . '/css/css.css', 'text/css');
			
			$document->addScriptDeclaration("
			<!--
			jQuery(function($) {
				$('.webgallery_fade a').fadeimage({ color: '$fade_color', opacity: '$dimming_opacity' });
			});
			//-->");
			$run_once = 1;
		}
	}
	
	/**
	 * Return tag wrapped by necessary style
	 * 
	 * @param $tags
	 * 
	 * @return string
	 */
	function template($tags = array()) {
		
		$title = plgContentCdWebGallery::options('title');
		
		$theme = '';
		$theme .= '<div class="webgallery_fade">';
		if ($title) {
			$theme .= '<h3 class="title">' . $title . '</h3>';
		}
		$theme .= '<ul>';
		$theme .= "\n";
		foreach ($tags as $tag) {
			$theme .= '<li>';
				$theme .= str_replace('><', '>' . $tag->img_thumb . '<', $tag->a);
			$theme .= '</li>';
			$theme .= "\n";
		}
		$theme .= '</ul>';
		$theme .= '<hr class="webgallery_clr" />'; // cleaner
		$theme .= '</div>';
		unset($tags);
		
		return $theme;
	}
}

?>
