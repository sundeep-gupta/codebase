<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class cdwebgalleryWebGalleryExpression {

	/**
	 * Regular expression
	 *
	 * @return string	Regular expression.
	 */
	function regex() {
		$regex = "#{webgallery(?:\s?(.*?)?)?}(.*?){/webgallery}#is";
		return $regex;
	}
	
	/**
	 * Callback function to process the regular expression
	 * 
	 * @param $match
	 * @return string
	 */
	function callback(&$match) {
				
		// $match[0] - whole regular result
		// $match[1] - settings
		// $match[2] - HTML

		// settings
		$settings_match = ($match[1] ? $match[1] : '');

		if (preg_match('#integration\s?=\s?"(.*?)"#', $settings_match, $integration)) {
			$integration = trim($integration[1]);
		} else {
			// no integration specified, use default one - cdwebgallery
			$integration = plgContentCdWebGallery::pluginParams('integration', 'cdwebgallery');
			if ($integration == '-1') $integration = 'cdwebgallery';
		}
		
		// integration
		$image_set = array();
		$image_set = plgContentCdWebGallery::integration($integration, $match);
		if (!$image_set) return; // prevent empty $image_set variable with images
		
		
		// set title
		$display_gal_title = plgContentCdWebGallery::pluginParams('display_gal_title', 0);

		$title = '';

		if ($display_gal_title) {
			if (preg_match('#title\s?=\s?"(.*?)"#', $settings_match)) {
				preg_match('#title\s?=\s?"(.*?)"#', $settings_match, $title);
				$title = (isset($title[1]) ? trim($title[1]) : '');
			}
		}
		
		// load theme
		if (preg_match('#theme\s?=\s?"(.*?)"#', $settings_match, $theme)) {
			$theme = trim($theme[1]);

			if (!plgContentCdWebGallery::checkTheme($theme)) $theme = 'default';

		} else {
			$theme = plgContentCdWebGallery::pluginParams('theme', 'default');
			if ($theme == '-1' or !plgContentCdWebGallery::checkTheme($theme))
			{
				$theme = 'default';
			}
		}
		
		// load engine class file
		if (preg_match('#engine\s?=\s?"(.*?)"#', $settings_match, $engine)) {
			$engine = trim($engine[1]);
			if (!plgContentCdWebGallery::checkEngine($engine)) {
				$engine = 'popup';
			}
		} else {
			$engine = plgContentCdWebGallery::pluginParams('engine', 'popup');
			if ($engine == '-1' or !plgContentCdWebGallery::checkEngine($engine))
			{
				$engine = 'popup';
			}
		}
		
		// save random id to session
		plgContentCdWebGallery::saveOptions(count($image_set), $title, $theme, $integration, $engine);
		
		// engine
		$classname = plgContentCdWebGallery::engine($engine);
		if (!$classname) return;		
	
		// call ENGINE::tag() function - the calling is  necessary
		$tag = call_user_func(array($classname, 'tag'), $image_set);

		// add theme to A and IMG tags
		$html_tag = plgContentCdWebGallery::loadTheme($theme, $tag);
		
		return $html_tag;
	}
}

?>