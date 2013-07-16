<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class reflectionWebGalleryTheme {
	
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
		$document = &JFactory::getDocument(); // set document
		
		$themefolder = plgContentCdWebGallery::themeFolder();
		
		$params = plgContentCdWebGallery::parseIni(dirname(__FILE__));
		
		$reflection_height = $params->get('reflection_height', 0.33);
		$reflection_opacity = $params->get('reflection_opacity', 0.5);
		
		// add script
		$document->addScript($themefolder . '/js/jquery.reflection.js');
		
		// add style
		$document->addStyleSheet($themefolder . '/css/css.css', 'text/css');
		
		static $run_once = 0;
		
		if (!$run_once) {
			
			$document->addScriptDeclaration("
			<!--
			jQuery(function($) {
				$(\".webgallery_reflection a img\").reflect({
					height: $reflection_height,
					opacity: $reflection_opacity
				});
			});
			//-->
			");
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
		$theme .= '<div class="webgallery_reflection">';
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
