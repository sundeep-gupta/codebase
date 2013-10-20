<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

// no direct access
defined('_JEXEC') or die('Restricted access');


class phocagalleryWebGalleryIntegration {

	/**
	 * Check the pre-requirements
	 *
	 * @return string	Error message. Empty string if everything is ok.
	 */
	function preRequirements() {
		$message = '';

		if (!phocagalleryWebGalleryIntegration::phocaInstalled()) $message = JText::_('CDWEBGALLERY_NO_PHOCA');
		
		return $message;
	}

	/**
	 * Integration
	 *
	 * @return array	Image set parameters.
	 */
	function integration($match) {

		$image_set = array();

		// settings
		if (isset($match[2])) {
			$settings = $match[2];
		} else {
			$settings = '';
		}

		$catid = explode(',', $settings);
		JArrayHelper::toInteger($catid);
		
		if (!class_exists('PhocaGalleryLoader')) require_once( JPATH_ADMINISTRATOR.DS.'components'.DS.'com_phocagallery'.DS.'libraries'.DS.'loader.php');
		
		phocagalleryimport('phocagallery.path.path');
		phocagalleryimport('phocagallery.file.file');
		phocagalleryimport('phocagallery.file.filethumbnail');

		$id = implode(',', $catid);

		$db = &JFactory::getDBO();

		if ($id > 0) {

			$query 	 = ' SELECT a.filename, a.title'
			. ' FROM #__phocagallery_categories AS cc'
			. ' LEFT JOIN #__phocagallery AS a ON a.catid = cc.id'
			.' WHERE a.catid IN ( ' . $id . ' )'
			. ' AND a.published = 1';
			$db->setQuery($query);
			$images = $db->loadObjectList();
				
			$params = plgContentCdWebGallery::parseIni(dirname(__FILE__) . DS . 'params.ini');
				
			$n = count( $images );
			for ($i = 0; $i < $n; $i++) {

				$image_size = $params->get('image', 'M');
					
				switch ($image_size) {
					case 'S':
						$imageName = PhocaGalleryFileThumbnail::getThumbnailName ($images[$i]->filename, 'small');
						break;
					case 'M':
						$imageName = PhocaGalleryFileThumbnail::getThumbnailName ($images[$i]->filename, 'medium');
						break;
					case 'O':
						$imageName = $images[$i]->filename;
						break;
					case 'L':
					default:
						$imageName = PhocaGalleryFileThumbnail::getThumbnailName ($images[$i]->filename, 'large');
						break;
				}

				$path = PhocaGalleryPath::getPath();

				$image_file_path = PhocaGalleryFile::getFileOriginal($images[$i]->filename);
				$img_src = str_replace('../', JURI::base(true) . '/' , $path->image_rel_full . $images[$i]->filename);
				
				$image_set[$i]->img_tag = '';
				$image_set[$i]->img_src = $img_src;
				$image_set[$i]->img_src_path = $image_file_path;
				$image_set[$i]->img_alt = $images[$i]->title;
				$image_set[$i]->img_title = $images[$i]->title;
				$image_set[$i]->thumb_name = basename($imageName->abs);
				$image_set[$i]->thumb_path = JPath::clean($imageName->abs);
				$image_set[$i]->thumb_src = str_replace('../', JURI::base(true) . '/' , $imageName->rel);
				
				$imagesize = getimagesize($image_set[$i]->thumb_path);
				$image_set[$i]->thumb_width = $imagesize[0];
				$image_set[$i]->thumb_height = $imagesize[1];
			}
		}
		return $image_set;
	}

	/**
	 * Check if PhocaGallery is installed
	 *
	 * @return boolean	True if exists.
	 */
	function phocaInstalled() {
		if (JComponentHelper::isEnabled('com_phocagallery', true)) return true;
		return false;
	}

}

?>