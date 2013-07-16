<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class paperclipWebGalleryTheme {
	
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
	function template($tags) {
		
		$title = plgContentCdWebGallery::options('title');
		
		$theme = '';
		if ($title) {
			$theme .= '<h3 class="title">' . $title . '</h3>';
		}
		$theme .= '<div class="webgallery_paperclip">';
		$theme .= '<div class="bg">';
		$theme .= '<ul>';
		$theme .= "\n";
		foreach ($tags as $tag) {
			$theme .= '<li>';				
				$theme .= str_replace('><', '><span>&nbsp;</span>' . $tag->img_thumb . '<', $tag->a);
				
				$display_alt = plgContentCdWebGallery::pluginParams('display_alt', 1);
				if ($display_alt and $tag->title) {
					$theme .= '<span>';
						$theme .= $tag->title;
					$theme .= '</span>';
				}
			$theme .= '</li>';
			$theme .= "\n";
		}
		$theme .= '</ul>';
		$theme .= '<hr class="webgallery_clr" />';
		$theme .= '</div>';
		$theme .= '</div>';
		unset($tags);
		
		return $theme;
	}
}

?>
