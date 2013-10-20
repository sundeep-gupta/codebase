<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class singleWebGalleryTheme {
	
	/**
	 * Check the pre-requirements
	 * 
	 * @return string or boolean
	 */
	function preRequirements() {
		
		switch(plgContentCdWebGallery::options('integration')) {
			case 'phocagallery':
			case 'directory':
				return JText::sprintf('CDWEBGALLERY_NOTALLOWED_INTEGRATION', $integration);
				break;
			default:
				break;
		}
		
		$mode = plgContentCdWebGallery::options('mode');
		if ($mode == 'gallery') return JText::_('CDWEBGALLERY_SINLE_ONE_IMAGE');
		
		$title = plgContentCdWebGallery::options('title');
		
		if ($title) return JText::sprintf('CDWEBGALLERY_SINLE_NO_TITLE', $title);
		
		return '';
	}
	
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
		$theme = '';
		
		$params = plgContentCdWebGallery::parseIni(dirname(__FILE__));
		$img_display = $params->get('img_display', 'original');
		
		foreach ($tags as $tag) {
			
			switch ($img_display) {
				case 'thumbnail':
					$tag_img = $tag->img_thumb;
					break;
				case 'original':
				default:
					$tag_img = $tag->img;
					break;
			}
			
			$theme .= str_replace('><', ' class="webgallery_single">' . $tag_img . '<', $tag->a);
		}
		unset($tags);
		return $theme;
	}
}

?>
