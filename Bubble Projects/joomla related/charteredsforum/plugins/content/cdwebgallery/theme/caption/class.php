<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class captionWebGalleryTheme {
	
	/**
	 * Header
	 * 
	 * @return void
	 */
	function header() {
		$document = &JFactory::getDocument(); // set document for next usage
		
		$themefolder = plgContentCdWebGallery::themeFolder();
		
		$document->addStyleSheet($themefolder . '/css/css.css', 'text/css');
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
		$theme .= '<div class="webgallery_caption">';
		if ($title) {
			$theme .= '<h3 class="title">' . $title . '</h3>';
		}
		$theme .= '<ul>';
		$theme .= "\n";
		foreach ($tags as $tag) {
			$theme .= '<li>';
			
			$display_alt = plgContentCdWebGallery::pluginParams('display_alt', 1);
			if ($display_alt and $tag->title) {
				$theme .= str_replace('><', '><span>' . $tag->title . '</span>' . $tag->img_thumb . '<', $tag->a);
			} else {
				$theme .= str_replace('><', '>' . $tag->img_thumb . '<', $tag->a);
			}
			
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
