<?php
/*
 * @package Joomla 1.5
 * @copyright Copyright (C) 2005 Open Source Matters. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 *
 * @component Phoca Gallery
 * @copyright Copyright (C) Jan Pavelka www.phoca.cz
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
 */
defined( '_JEXEC' ) or die( 'Restricted access' );

class PhocaGalleryImageFront
{
	/*
	 * Displaying image in CATEGORIES VIEW
	 */
	function getCategoriesImageBackground($imgCatSize, $smallImgHeigth, $smallImgWidth, $mediumImgHeight, $mediumImgWidth) {
		
		phocagalleryimport('phocagallery.image.image');
		phocagalleryimport('phocagallery.path.path');
		$formatIcon	= &PhocaGalleryImage::getFormatIcon();
		$path		= &PhocaGalleryPath::getPath();
		$imgBg 		= new JObject();
		
		switch ($imgCatSize) {	
			case 4:
			case 6:			
				$imgBg->image = 'background: url(\''
					.$path->image_rel_front_full . 'shadow3.'.$formatIcon
					.'\') 50% 50% no-repeat;height:'
					.$smallImgHeigth.'px;width:'
					.$smallImgWidth.'px;';
				$imgBg->width = $smallImgWidth + 20;//Categories Detailed View
			break;
			
			case 5:
			case 7:
				$imgBg->image = 'background: url(\''
					.$path->image_rel_front_full . 'shadow1.'.$formatIcon
					.'\') 50% 50% no-repeat;height:'
					.$mediumImgHeight.'px;width:'
					.$mediumImgWidth.'px;';
				$imgBg->width = $mediumImgWidth + 20;//Categories Detailed View
			break;
			
			case 1:
			case 3:
				$imgBg->image 	= 'width:'.$mediumImgWidth.'px;';
				$imgBg->width	= $mediumImgWidth +20;//Categories Detailed View
			break;
			
			case 0:
			case 2:
			default:
				$imgBg->image 	= 'width:'.$smallImgWidth.'px;';
				$imgBg->width	= $smallImgWidth + 20;//Categories Detailed View
			break;
		}
		return $imgBg;
	}
	
	function displayCategoriesImageOrFolder ($filename, $imgCategoriesSize, $rightDisplayKey = 0) {
		
		phocagalleryimport('phocagallery.image.image');
		phocagalleryimport('phocagallery.path.path');
		phocagalleryimport('phocagallery.file.filethumbnail');
		
		
		$formatIcon	= &PhocaGalleryImage::getFormatIcon();
		$path		= &PhocaGalleryPath::getPath();

		// if category is not accessable, display the key in the image:
		$key = '';
		if ((int)$rightDisplayKey == 0) {
			$key = '-key';
		}
		switch ($imgCategoriesSize) {	
			// user wants to display only icon folder (parameters) medium
			case 3:
			$fileThumbnail 		= PhocaGalleryFileThumbnail::getThumbnailName($filename, 'medium');
			$fileThumbnail->rel	= $path->image_rel_front . 'icon-folder-medium'.$key.'.' . $formatIcon;
			break;
			
			case 7:
			$fileThumbnail 		= PhocaGalleryFileThumbnail::getThumbnailName($filename, 'medium');
			$fileThumbnail->rel	= $path->image_rel_front . 'icon-folder-medium'.$key.'.' . $formatIcon;
			break;
			
			// user wants to display only icon folder (parameters) small
			case 2:
			$fileThumbnail 		= PhocaGalleryFileThumbnail::getThumbnailName($filename, 'small');
			$fileThumbnail->rel	= $path->image_rel_front . 'icon-folder-small-main'.$key.'.' . $formatIcon;
			break;
			
			case 6:
			$fileThumbnail 		= PhocaGalleryFileThumbnail::getThumbnailName($filename, 'small');
			$fileThumbnail->rel	= $path->image_rel_front . 'icon-folder-small-main'.$key.'.' . $formatIcon;
			break;
			
			// standard medium image next to category in categories view
			// if the file doesn't exist, it will be displayed folder icon
			case 1:
			$fileThumbnail = PhocaGalleryFileThumbnail::getThumbnailName($filename, 'medium');
			if (!JFile::exists($fileThumbnail->abs) || $rightDisplayKey == 0) {
				$fileThumbnail->rel	= $path->image_rel_front . 'icon-folder-medium'.$key.'.' . $formatIcon;
			}
			break;
			
			case 5:
			$fileThumbnail = PhocaGalleryFileThumbnail::getThumbnailName($filename, 'medium');
			if (!JFile::exists($fileThumbnail->abs) || $rightDisplayKey == 0) {
				$fileThumbnail->rel	= $path->image_rel_front . 'icon-folder-medium'.$key.'.' . $formatIcon;
			}
			break;
			
			// standard small image next to category in categories view
			// if the file doesn't exist, it will be displayed folder icon
			case 0:
			$fileThumbnail = PhocaGalleryFileThumbnail::getThumbnailName($filename, 'small');
			if (!JFile::exists($fileThumbnail->abs) || $rightDisplayKey == 0) {
				$fileThumbnail->rel	= $path->image_rel_front . 'icon-folder-small-main'.$key.'.' . $formatIcon;
			}
			break;
			
			case 4:
			default:
			$fileThumbnail = PhocaGalleryFileThumbnail::getThumbnailName($filename, 'small');
			if (!JFile::exists($fileThumbnail->abs) || $rightDisplayKey == 0) {
				$fileThumbnail->rel	=  $path->image_rel_front . 'icon-folder-small-main'.$key.'.' .$formatIcon;
			}
			break;
		}
		
		return $fileThumbnail;	
	}
	
	function displayImageOrNoImage ($filename, $size) {
	
		phocagalleryimport('phocagallery.image.image');
		phocagalleryimport('phocagallery.path.path');
		phocagalleryimport('phocagallery.file.filethumbnail');
		$path			= &PhocaGalleryPath::getPath();
		$fileThumbnail	= PhocaGalleryFileThumbnail::getThumbnailName($filename, $size);
		$formatIcon 	= &PhocaGalleryImage::getFormatIcon();
		
		
		//Thumbnail_file doesn't exists
		if (!JFile::exists($fileThumbnail->abs)) {
			switch ($size) {
				case 'large':
				$fileThumbnail->rel	= $path->image_rel_front . 'phoca_thumb_l_no_image.' .$formatIcon;
				break;
				
				case 'medium':
				$fileThumbnail->rel	= $path->image_rel_front . 'phoca_thumb_m_no_image.' .$formatIcon;
				break;
				
				default:
				case 'small':
				$fileThumbnail->rel	= $path->image_rel_front . 'phoca_thumb_s_no_image.'  .$formatIcon;
				break;	
			}
		}	
		return $fileThumbnail->rel;	
	}
	
	/*
	* Returns path to folder icon 
	*/
	function displayBackFolder ($size, $rightDisplayKey) {
	
		// if category is not accessable, display the key in the image:
		$key = '';
		if ((int)$rightDisplayKey == 0) {
			$key = '-key';
		}
		
		phocagalleryimport('phocagallery.image.image');
		phocagalleryimport('phocagallery.path.path');
		$path			= &PhocaGalleryPath::getPath();
		$formatIcon 	= &PhocaGalleryImage::getFormatIcon();
		
		$fileThumbnail->abs 	= '';
		
		$paramsC 	= JComponentHelper::getParams('com_phocagallery') ;
		
		if ( $paramsC->get( 'image_background_shadow' ) != 'none' ) {
			$fileThumbnail->rel	= $path->image_rel_front . 'icon-up-images'.$key.'.' . $formatIcon;
		} else {
			$fileThumbnail->rel	= $path->image_rel_front . 'icon-up-images'.$key.'.' . $formatIcon;
		}
		return $fileThumbnail->rel;	
	}
	
	function displayImageOrFolder ($filename, $size, $rightDisplayKey, $param= 'display_category_icon_image') {
		
		phocagalleryimport('phocagallery.image.image');
		phocagalleryimport('phocagallery.path.path');
		phocagalleryimport('phocagallery.file.filethumbnail');
		
		$paramsC = JComponentHelper::getParams('com_phocagallery') ;
		
		$formatIcon			= &PhocaGalleryImage::getFormatIcon();
		$path				= &PhocaGalleryPath::getPath();
		$fileThumbnail		= PhocaGalleryFileThumbnail::getThumbnailName($filename, $size);
		$displayCategoryIconImage	= $paramsC->get( $param, 0 );
		$imageBackgroundShadow 	= $paramsC->get( 'image_background_shadow', 'none' );

		
		// if category is not accessable, display the key in the image:
		$key = '';
		if ((int)$rightDisplayKey == 0) {
			$key = '-key';
		}
		
		//Thumbnail_file doesn't exists or user wants to display folder icon
		if (!JFile::exists($fileThumbnail->abs) || 
		    $displayCategoryIconImage != 1) {
			if ( $imageBackgroundShadow != 'none') {
				$fileThumbnail->rel	= $path->image_rel_front . 'icon-folder-medium'.$key.'.' . $formatIcon;
			} else {
				$fileThumbnail->rel	= $path->image_rel_front . 'icon-folder-medium'.$key.'.' . $formatIcon;
			}
		}	
		return $fileThumbnail;	
	}
	

}
?>