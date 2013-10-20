<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class uiWebGalleryTheme {
	
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
		
		$themefolder = plgContentCdWebGallery::themeFolder();
		
		static $run_once = 0;
		
		if (!$run_once) {
			// add script
			$document->addStyleSheet($themefolder . '/css/css.css', 'text/css');
			
			$params = plgContentCdWebGallery::parseIni(dirname(__FILE__));
			$theme = $params->get('theme', 'smoothness');
			
			JScriptegrator::importUITheme($theme, 'ui.tabs');
			
			$document->addScriptDeclaration("
			<!--
			jQuery(function($) {
				$('.webgallery_ui ul li').hover(
					function() {
						$(this).addClass('ui-state-hover');
					},
					function() {
						$(this).removeClass('ui-state-hover');
					}
				);
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
		
		$params = plgContentCdWebGallery::parseIni(dirname(__FILE__));
		$theme = $params->get('theme', 'smoothness');
		
		$tmpl = '';
		$tmpl .= '<div class="webgallery_ui ' . $theme . '">';
			$tmpl .= '<div class="ui-tabs ui-widget ui-widget-content ui-corner-all">';
				$tmpl .= '<div class="ui-tabs-panel ui-widget-content ui-corner-bottom">';
					if ($title) {
						$tmpl .= '<div class="ui-widget-header ui-corner-all ui-helper-clearfix">';
						$tmpl .= '<span>' . $title . '</span>';
						$tmpl .= '</div>';
					}
					$tmpl .= '<ul class="ui-widget ui-helper-clearfix">';
					$tmpl .= "\n";
					foreach ($tags as $tag) {
						$tmpl .= '<li class="ui-state-default ui-corner-all">';
							$tmpl .= str_replace('><', '>' . $tag->img_thumb . '<', $tag->a);
							$display_alt = plgContentCdWebGallery::pluginParams('display_alt', 1);
							if ($display_alt and $tag->title) {
								$tmpl .= '<div class="title">';
									$tmpl .= $tag->title;
								$tmpl .= '</div>';
							}
						$tmpl .= '</li>';
						$tmpl .= "\n";
					}
					$tmpl .= '</ul>';
					$tmpl .= '<hr class="webgallery_clr" />'; // cleaner
				$tmpl .= '</div>';
			$tmpl .= '</div>';
		$tmpl .= '</div>';
		unset($tags);
		
		return $tmpl;
	}
}

?>
