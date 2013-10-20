<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class cdwebgalleryWebGalleryIntegration {

	/**
	 * Check the pre-requirements
	 * 
	 * @return string	Error message. Empty string if everything is ok.
	 */
	function preRequirements() {
		$message = '';
		return $message;
	}
	
	/**
	 * Integration
	 * 
	 * @return array	Image set parameters.
	 */
	function integration($match) {
		
		// images
		$image_match = ($match[2] ? trim(strip_tags($match[2], '<img>')) : '');

		// make image array - $image_array
		preg_match_all('(<img.*?>)', $image_match, $image_array);
		$image_array = (isset($image_array[0]) ? $image_array[0] : array());
		
		// settings
		$settings_match = (isset($match[1]) ? $match[1] : '');
		
		unset($image_match);

		// if no images in array, return
		if (!$image_array) {
			return;
		}
		
		$abs_path = plgContentCdWebGallery::absPath();

		// prevent non-exists images
		$image_array_tmp = array();
		foreach ($image_array as $img) {
			$img_path = JPath::clean($abs_path . DS . plgContentCdWebGallery::getAttr($img, 'src'));
			if (JFile::exists($img_path)) {
				$image_array_tmp [] = $img;
			}
		}
		$image_array = $image_array_tmp;
		
		$i = 0;
		$image_set = array();
		foreach ($image_array as $image)
		{
			$image_set[$i]->img_tag = $image;
			$image_set[$i]->img_src = plgContentCdWebGallery::getAttr($image, 'src');
			$image_set[$i]->img_src_path = JPath::clean($abs_path . DS . $image_set[$i]->img_src);
			$image_set[$i]->img_alt = plgContentCdWebGallery::getAttr($image, 'alt');
			$image_set[$i]->img_title = plgContentCdWebGallery::getAttr($image, 'title');

			$i++;
		}
				
		// >>> define thumbnail variables
		// absolute path to the thumbnail cache foler
		$thumb_cache_dir = plgContentCdWebGallery::cacheDir();
		
		// set watermark
		if (preg_match('#watermark\s?=\s?"(yes|no)"#', $settings_match, $watermark)) {
			$watermark = trim($watermark[1]);
			 
		} else {
			$watermark = plgContentCdWebGallery::pluginParams('watermark', 'yes');
		}
		
		$watermark = ($watermark == 'yes' ? 1 : 0);
		
		// create a thumbnail cache
		$thumbnail_names = plgContentCdWebGallery::createThumbnails($image_set, $thumb_cache_dir, $watermark);

		$i = 0;
		foreach ($thumbnail_names as $thumb)
		{
			$image_set[$i]->thumb_name = $thumb;
			$image_set[$i]->thumb_path = $thumb_cache_dir . DS . $image_set[$i]->thumb_name;
			$image_set[$i]->thumb_src = JURI::root(true) . '/cache/' . $image_set[$i]->thumb_name;

			$thumb_size = getimagesize($image_set[$i]->thumb_path);
			$image_set[$i]->thumb_width = (isset($thumb_size[0]) ? $thumb_size[0] : '');
			$image_set[$i]->thumb_height = (isset($thumb_size[1]) ? $thumb_size[1] : '');

			$i++;
		}
		
		return $image_set;
	}

}

?>