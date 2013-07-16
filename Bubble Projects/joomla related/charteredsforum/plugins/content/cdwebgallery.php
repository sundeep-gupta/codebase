<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 * @author		Daniel Rataj, <info@greatjoomla.com>
 * @package		Joomla
 * @subpackage	Content
 * @category   	Plugin
 * @version		1.0.4
 * @copyright	Copyright (C)  2007 - 2008 Core Design, http://www.greatjoomla.com
 * @license     http://www.gnu.org/licenses/gpl.html GNU/GPL
 */

// no direct access
defined('_JEXEC') or die('Restricted access');

// Import library dependencies
jimport('joomla.plugin.plugin');
jimport('joomla.filesystem.file');
jimport('joomla.filesystem.folder');

class plgContentCdWebGallery extends JPlugin
{

	/**
	 * Constructor
	 *
	 * For php4 compatability we must not use the __constructor as a constructor for plugins
	 * because func_get_args ( void ) returns a copy of all passed arguments NOT references.
	 * This causes problems with cross-referencing necessary for the observer design pattern.
	 *
	 * @param object $subject The object to observe
	 * @param object $params  The object that holds the plugin parameters
	 * @since 1.5
	 */
	function plgContentCdWebGallery(&$subject)
	{
		parent::__construct($subject);

		// load plugin parameters
		$this->plugin = &JPluginHelper::getPlugin('content', 'cdwebgallery');
		$this->params = new JParameter($this->plugin->params);		
	}

	/**
	 * Call the prepare function
	 *
	 * Method is called by the view
	 *
	 * @param 	object		The article object.  Note $article->text is also available
	 * @param 	object		The article params
	 * @param 	int			The 'page' number
	 */
	function onPrepareContent(&$article, &$params, $limitstart=0)
	{
		// define language
		JPlugin::loadLanguage('plg_content_cdwebgallery', JPATH_ADMINISTRATOR);
		
		$expressionlist = JFolder::folders($this->absPath() . DS . 'plugins' . DS . 'content' . DS . 'cdwebgallery' . DS . 'expression');
		
		foreach ($expressionlist as $expression) {
			
			$class_file = dirname(__FILE__) . DS . 'cdwebgallery' . DS . 'expression' . DS . $expression . DS . 'class.php';
			
			// integration file doesn't exists, use default - cdwebgallery
			if (!JFile::exists($class_file)) return false;
			
			// set expression class name
			$classname = $expression . 'WebGalleryExpression';
			
			// register class
			JLoader::register($classname, $class_file);
			
			$regex = '';
			
			// call EXPRESSION::regex() function
			// return regular expression (string)
			if (is_callable(array($classname, 'regex'))) {
				$regex = call_user_func(array($classname, 'regex'));
			}
			
			// if no regular expression, run default one
			if (!$regex) $regex = "#{webgallery(?:\s?(.*?)?)?}(.*?){/webgallery}#is";
			
			if (preg_match($regex, $article->text)) {
				// call EXPRESSION::callback() function
				if (is_callable(array($classname, 'callback'))) {
					return $article->text = '<div id="webgallery">' . preg_replace_callback($regex, array($classname, 'callback'), $article->text) . '</div>';
				} else {
					return false;
				}
			}			
		}
	}

	/**
	 * Check it user inserted $theme (via preg_match function) exists
	 * 
	 * @param $theme
	 * 
	 * @return boolean		True if theme exists.
	 */
	function checkTheme($theme = '') {
		if (!$theme) return false;
		jimport('joomla.filesystem.folder');
		$list = JFolder::folders(dirname(__FILE__) . DS . 'cdwebgallery' . DS . 'theme');

		if (in_array($theme, $list)) return true;
		return false;
	}

	/**
	 * Check it user inserted $engine (via preg_match function) exists
	 * 
	 * @param $engine
	 * 
	 * @return boolean		True if engine exists.
	 */
	function checkEngine($engine) {
		if (!$engine) return false;
		jimport('joomla.filesystem.folder');
		$list = JFolder::folders(dirname(__FILE__) . DS . 'cdwebgallery' . DS . 'engine');

		if (in_array($engine, $list)) return true;
		return false;
	}

	/**
	 * Create a thumbnail
	 * 
	 * @param $image_set
	 * @param $thumb_abs_path
	 * @param $thumb_prefix
	 * @param $watermark
	 * 
	 * @return array				Thumbnail information
	 */
	function createThumbnails($image_set, $thumb_abs_path, $watermark = 1) {

		// load thumbnail.class.php file
		require_once(dirname(__FILE__) . DS . 'cdwebgallery' . DS . 'utils' . DS . 'php' . DS . 'webgallery.class.php');

		$outputFormat = plgContentCdWebGallery::pluginParams('thumb_output', 'JPG');
		
		$jpg_quality = plgContentCdWebGallery::pluginParams('jpg_quality', 70);
		
		$thumb_width = plgContentCdWebGallery::pluginParams('thumb_width', 100);;
		
		$thumb_height = plgContentCdWebGallery::pluginParams('thumb_height', 100);;

		$watermark_image = plgContentCdWebGallery::pluginParams('watermark_name', 'magnify.png');
		
		$watermark_image_path = dirname(__FILE__) . DS . 'cdwebgallery' . DS . 'images' . DS . $watermark_image;
		$watermark_valign = plgContentCdWebGallery::pluginParams('watermark_valign', 'BOTTOM');;
		$watermark_halign = plgContentCdWebGallery::pluginParams('watermark_halign', 'RIGHT');;

		$thumbnail_name_array = array();
		
		$thumb_prefix = 'thumb_';
		
		foreach ($image_set as $image) {
			$image_src = $image->img_src;
				
			$image_filename = basename($image_src);
				
			$image_abs_path = $image->img_src_path;
			
			$thumbnail_name = $thumb_prefix . $image_filename . '_' . md5($image_abs_path) . '_' . $thumb_width . 'x' . $thumb_height . '_wm-' . $watermark . '.' . strtolower($outputFormat);

			$thumbnail_path = $thumb_abs_path . DS . $thumbnail_name;
			
			// if thumbnail already exists, return
			if (!JFile::exists($thumbnail_path)) {
				
				// create a thumbnail
				$thumb_class = new webGalleryThumbnail($image_abs_path);
				$thumb_class->output_format = $outputFormat;

				if (strtolower($outputFormat) == 'jpg') {
					$thumb_class->quality = $jpg_quality;
				}

				if ($watermark) {
					$thumb_class->img_watermark = $watermark_image_path;
					$thumb_class->img_watermark_Valing = $watermark_valign;
					$thumb_class->img_watermark_Haling = $watermark_halign;
				}

				$thumb_class->size_width($thumb_width); // thumbnail width
				$thumb_class->size_height($thumb_height); // thumbnail height
				$thumb_class->process(); // create thumbnail
				
				$saved_img = $thumb_class->save($thumbnail_path);
				// write generate thumbnail via Joomla! FTP
				if ($saved_img) JFile::write($thumbnail_path, $saved_img);
			}
			
			if (JFile::exists($thumbnail_path)) $thumbnail_name_array []= $thumbnail_name;
		}
		return $thumbnail_name_array;
	}

	/**
	 * Get attribute from HTML tag (based on regular expression)
	 * 
	 * @param $html_tag
	 * @param $attr
	 * 
	 * @return string	HMTL attribute
	 */
	function getAttr($html_tag, $attr) {
		preg_match('#' . $attr . '\s?=\s?"(.*?)"#', $html_tag, $attr_value);
		if (isset($attr_value[1])) return $attr_value[1];
		return '';
	}

	/**
	 * Return absolute path to Joomla! root
	 * 
	 * @return string	Path to the Joomla! root directory (absolute path)
	 */
	function absPath() {
		return dirname(dirname(dirname(__FILE__)));
	}
	
	/**
	 * Cache dir
	 * 
	 * @return string	Path to the cache directory.
	 */
	function cacheDir($rel = false) {
		$cachedir = 'cache';
		if ($rel) return JURI::root(true) . '/' . $cachedir;
		return plgContentCdWebGallery::absPath() . DS . $cachedir;
	}

	/**
	 * Retrieve plugin parameters
	 * 
	 * @param $param
	 * @param $def_val
	 * 
	 * @return string		Plugin parameter.
	 */
	function pluginParams($param = '', $def_val = '') {

		$folder = 'content';
		$plg_name = 'cdwebgallery';

		// load plugin parameters
		$plugin = &JPluginHelper::getPlugin($folder, $plg_name);
		$pluginParams = new JParameter($plugin->params);

		return $pluginParams->get($param, $def_val);
	}

	/**
	 * Load theme and return IMG and A tags
	 * 
	 * @param $theme
	 * @param $tag
	 * 
	 * @return string	Theme tag.
	 */
	function loadTheme($theme = 'default', $tag = array()) {

		$document = &JFactory::getDocument(); // set document for next usage

		$live_path_abs = JURI::root(true) . '/';

		// set helper.php file
		$theme_class_file = dirname(__FILE__) . DS . 'cdwebgallery' . DS . 'theme' . DS . $theme . DS . 'class.php';

		if (!JFile::exists($theme_class_file)) {
			$theme = 'default';
			// set helper.php file
			$theme_class_file = dirname(__FILE__) . DS . 'cdwebgallery' . DS . 'theme' . DS . $theme . DS . 'class.php';
		}

		$classname = $theme . 'WebGalleryTheme';
		JLoader::register($classname, $theme_class_file);
		
		// check the pre-requirements
		$run_theme = '';
		// call theme::requirements() function
		if (is_callable(array($classname, 'preRequirements'))) {
			$run_theme = call_user_func(array($classname, 'preRequirements'));
		}

		// stop the script if pre-requirements failed
		if ($run_theme) {
			JError::raiseNotice('', JText::_($run_theme));
			return false;
		}
		
		// call THEME::header() function
		if (is_callable(array($classname, 'header'))) {
			call_user_func(array($classname, 'header'), $theme);
		}
		
		// call THEME::template() function
		$themed_tag = call_user_func(array($classname, 'template'), $tag);
		return $themed_tag;
	}

	/**
	 * Save random id session
	 * 
	 * @param $count
	 * @param $title
	 * @param $theme
	 * 
	 * @return void
	 */
	function saveOptions($count = 0, $title = '', $theme = 'default', $integration = 'cdwebgallery', $engine = 'popup') {

		$session = &JFactory::getSession();
		$session_name = 'cdWebGalleryOptions';
		
		if ($count > 1) {
			$mode = 'gallery';
		} else {
			$mode = 'single';
		}
		
		$random = mt_rand(1, 1000);
		
		jimport('joomla.helper.arrayhelper');
		
		$gallery_settings = array();
		$gallery_settings['mode'] = $mode;
		$gallery_settings['theme'] = $theme;
		$gallery_settings['integration'] = $integration;
		$gallery_settings['title'] = $title;
		$gallery_settings['id'] = $random;
		$gallery_settings['engine'] = $engine;
		$obj = JArrayHelper::toObject($gallery_settings, 'stdClass');
		
		$session->set($session_name, $obj);
	}

	/**
	 * Retrieve random options from session
	 * 
	 * @param $mode
	 * 
	 * @return integer, string or object
	 */
	function options($mode = 'id') {
		$session = &JFactory::getSession();
		$session_name = 'cdWebGalleryOptions';
		$session_obj = $session->get($session_name);
		
		$random = null;
		
		if (!is_null($session_obj)) {
			switch ($mode) {
				default:
					if (isset($session_obj->$mode)) {
						$random = $session_obj->$mode;
					}
					break;
				case '':
				case 'all':
					$random = (object) $session_obj;
					break;
			}
		}
		return $random;
	}

	/**
	 * Routine to check Scriptegrator plugin
	 * 
	 * @param $version_number
	 * @param $library
	 * @param $place
	 * 
	 * @return string	Error message if some option is missing.
	 */
	function checkScriptegrator($version_number = '1.3.8', $library = 'jquery', $place = 'site') {
		$message = '';
		
		// Scriptegrator check
		if (!class_exists('JScriptegrator')) {
			$message = JText::_('CDWEBGALLERY_ENABLE_SCRIPTEGRATOR');
		} else {
			$message = JScriptegrator::check($version_number, $library, $place);
		}
		
		return $message;
	}
	
	/**
	 * Parse INI file and load the settings from file
	 * 
	 * @param $path_to_ini
	 * 
	 * @return object
	 */
	function parseIni($dir = '', $filename = 'params.ini') {
		if (!$dir) $dir = dirname(__FILE__);
		
		$path_to_ini = $dir . DS . $filename;
		
		if (JFile::exists($path_to_ini)) {
			$data = JFile::read($path_to_ini);
		} else  {
			$data = null;
		}
		
		return new JParameter($data);
	}
	
	/**
	 * Integration routine
	 * 
	 * @param $integration
	 * 
	 * @return array		Image set.
	 */
	function integration($integration = 'cdwebgallery', $match = array()) {
		$abspath = plgContentCdWebGallery::absPath() . DS . 'plugins' . DS . 'content';
		
		$class_file = $abspath . DS . 'cdwebgallery' . DS . 'integration' . DS . $integration . DS . 'class.php';
		
		// integration file doesn't exists, use default - cdwebgallery
		if (!JFile::exists($class_file)) {
			JError::raiseNotice('', JText::sprintf('CDWEBGALLERY_UNKNOWN_INTEGRATION', $integration));
			return;
		}

		// set engine class name
		$classname = $integration . 'WebGalleryIntegration';
		
		// register class
		JLoader::register($classname, $class_file);
		
		// check the pre-requirements
		$run_integration = '';
		if (is_callable(array($classname, 'preRequirements'))) {
			// call INTEGRATION::requirements() function
			$run_integration = call_user_func(array($classname, 'preRequirements'));
		}

		// stop the script if pre-requirements failed
		if ($run_integration) {
			JError::raiseNotice('', JText::_($run_integration));
			return;
		}
		// call INTEGRATION::integration() function
		$image_set = call_user_func(array($classname, 'integration'), $match);
		
		return $image_set;
		
		/*
		 $image_set MUST RETURN THE ARRAY WITH OBJECTS AND THE FOLLOWING ITEMS INSIDE
		 NOTE: (the values are just examples)

		 [0] => stdClass Object
		 (
			 [img_tag] => <img style="margin: 5px;" src="images/stories/gallery-demo/single-images/global_config_site_tab_ss.png" alt="Site tab" title="Joomla! global configuration - Site tab" height="114" width="152" />
			 [img_src] => images/stories/gallery-demo/single-images/global_config_site_tab_ss.png
			 [img_src_path] => D:\xampp\htdocs\joomla15\images\stories\gallery-demo\single-images\global_config_site_tab_ss.png
			 [img_alt] => Site tab
			 [img_title] => Joomla! global configuration - Site tab
			 [thumb_name] => thumb_webgallery_100x100_watermark-1_global_config_site_tab_ss.jpg
			 [thumb_path] => D:\xampp\htdocs\joomla15\cache\thumb_webgallery_100x100_watermark-1_global_config_site_tab_ss.jpg
			 [thumb_src] => /joomla15/cache/thumb_webgallery_100x100_watermark-1_global_config_site_tab_ss.jpg
			 [thumb_width] => 120
			 [thumb_height] => 100
		 )
		 */
	}
	
	/**
	 * Engine routine
	 * 
	 * @param $engine
	 * 
	 * @return string		Class name.
	 */
	function engine($engine = 'popup') {
		$abspath = plgContentCdWebGallery::absPath() . DS . 'plugins' . DS . 'content';
		
		$class_file = $abspath . DS . 'cdwebgallery' . DS . 'engine' . DS . $engine . DS . 'class.php';
		
		if (!JFile::exists($class_file)) {
			return false;
		}
		
		// set engine class name
		$classname = $engine . 'WebGalleryEngine';

		// register class
		JLoader::register($classname, $class_file);
		
		// check the pre-requirements
		$run_engine = '';
		if (is_callable(array($classname, 'preRequirements'))) {
			// call ENGINE::requirements() function
			$run_engine = call_user_func(array($classname, 'preRequirements'));
		}

		// stop the script if pre-requirements failed
		if ($run_engine) {
			JError::raiseNotice('', JText::_($run_engine));
			return false;
		}
		
		// call ENGINE::header() function if is possible
		if (is_callable(array($classname, 'header'))) call_user_func(array($classname, 'header'));
		
		return $classname;
	}
	
	/**
	 * Theme folder
	 * 
	 * @return string		Path to the folder theme.
	 */
	function themeFolder() {
		$folder = JURI::root(true) . '/plugins/content/cdwebgallery/theme/' . plgContentCdWebGallery::options('theme');
		if ($folder) return $folder;
		return '';
	}
	
	/**
	 * Engine folder
	 * 
	 * @return string		Path to the engine theme.
	 */
	function engineFolder() {
		$folder = JURI::root(true) . '/plugins/content/cdwebgallery/engine/' . plgContentCdWebGallery::options('engine');
		if ($folder) return $folder;
		return '';
	}
}

?>
