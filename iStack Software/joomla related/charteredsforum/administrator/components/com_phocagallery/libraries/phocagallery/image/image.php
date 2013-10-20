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

class PhocaGalleryImage
{
	function getFormatIcon() {
		$paramsC 	= JComponentHelper::getParams('com_phocagallery') ;
		$iconFormat = $paramsC->get( 'icon_format', 'gif' );
		return $iconFormat;
	}

	function getImageSize($filename, $returnString = 0) {
		
		phocagalleryimport('phocagallery.image.image');
		phocagalleryimport('phocagallery.path.path');
		
		$path			= &PhocaGalleryPath::getPath();
		$fileNameAbs	= JPath::clean($path->image_abs . $filename);
		$formatIcon 	= &PhocaGalleryImage::getFormatIcon();
		
		if (!JFile::exists($fileNameAbs)) {
			$fileNameAbs	= $path->image_abs_front . 'phoca_thumb_l_no_image.' . $formatIcon;
		}

		if ($returnString == 1) {
			$imageSize = getimagesize($fileNameAbs);
			return $imageSize[0] . ' x '.$imageSize[1];
		} else {
			return getimagesize($fileNameAbs);
		}
	}
	
	function getRealImageSize($filename) {
	
		phocagalleryimport('phocagallery.file.thumbnail');
		
		$thumbName			= PhocaGalleryFileThumbnail::getThumbnailName ($filename, 'large');
		list($w, $h, $type) = GetImageSize($thumbName->abs);
		$size = '';
		if (isset($w) && isset($h)) {
			$size['w'] 	= $w;
			$size['h']	= $h;
		} else {
			$size = '';
		}
		return $size;
	}
	
	
	function correctSizeWithRate($width, $height) {
		$image['width']		= 100;
		$image['height']	= 100;
		
		if ($width > $height) {
			if ($width > 100) {
				$image['width']		= 100;
				$rate 				= $width / 100;
				$image['height']	= $height / $rate;
			} else {
				$image['width']		= $width;
				$imageHeight	= $height;
			}
		} else {
			if ($height > 100) {
				$image['height']	= 100;
				$rate 				= $height / 100;
				$image['width'] 	= $width / $rate;
			} else {
				$image['width']		= $width;
				$image['height']	= $height;
			}
		}
		return $image;
	}
	
	function correctSize($imageSize, $size = 100, $sizeBox = 100, $sizeAdd = 0) {

		$image['size']	= $imageSize;
		if ($image['size'] < $size ) {
			$image['size']		= $size;
			$image['boxsize'] 	= $size;
		} else {
			$image['boxsize'] 	= $image['size'] + $sizeAdd;
		}
		return $image;		
	}
	
	function correctSwitchSize($switchHeight, $switchWidth) {

		$switchImage['height'] 	= $switchHeight;
		$switchImage['centerh']	= ($switchHeight / 2) - 18;
		$switchImage['width'] 	= $switchWidth;
		$switchImage['centerw']	= ($switchWidth / 2) - 18;
		$switchImage['height']	= $switchImage['height'] + 5;
		return $switchImage;		
	}
	
	function setBoxSize($imageHeight, $imageWidth, $name, $detail=0, $download=0, $vm=0, $startpiclens=0, $trash=0, $publishunpublish=0, $geo=0, $camerainfo=0,  $extlink1=0, $extlink2=0, $boxSpace=0, $imageShadow = '', $rateImage = 0, $camerainfo = 0, $iconfolder = 0, $imgdescbox = 0) {
		
		$boxWidth 	= 0;
		if ($detail == 1) {
			$boxWidth = $boxWidth + 20;
		}
		if ($download > 0) {
			$boxWidth = $boxWidth + 20;
		}
		if ($vm == 1) {
			$boxWidth = $boxWidth + 20;
		}
		if ($startpiclens == 1) {
			$boxWidth = $boxWidth + 20;
		}
		if ($trash == 1) {
			$boxWidth = $boxWidth + 20;
		}
		if ($publishunpublish == 1) {
			$boxWidth = $boxWidth + 20;
		}
		if ($geo == 1) {
			$boxWidth = $boxWidth + 20;
		}
		if ($camerainfo == 1) {
			$boxWidth = $boxWidth + 20;
		}
		if ($extlink1 == 1) {
			$boxWidth = $boxWidth + 20;
		}
		if ($extlink2 == 1) {
			$boxWidth = $boxWidth + 20;
		}
		if ($camerainfo == 1) {
			$boxWidth = $boxWidth + 20;
		}
		
		// Name
		if ($name == 1 || $name == 2) {
			$imageHeight['boxsize'] = $imageHeight['boxsize'] + 20;
		}
		
		// Rate Image
		if ($rateImage == 1) {
			$imageHeight['boxsize'] = $imageHeight['boxsize'] + 25;
		}

		$boxHeightRows 			= ceil($boxWidth/$imageWidth['boxsize']);
		$imageHeight['boxsize'] = (20 * $boxHeightRows) + $imageHeight['boxsize'];

		
		if ( $imageShadow != 'none' ) {		
			$imageHeight['boxsize'] = $imageHeight['boxsize'] + 18;
		}
		
		// Icon folder - is not situated in image boxes but it affect it
		// There were no icons but icon is here
		if ($iconfolder == 1 && $boxWidth == 0) {
			$imageHeight['boxsize'] = $imageHeight['boxsize'] + 20;
		}
		
		// Image Description Box Heiht in Category View
		$imageHeight['boxsize'] = $imageHeight['boxsize'] + (int)$imgdescbox;
	
		$imageHeight['boxsize'] = $imageHeight['boxsize'] + $boxSpace;
		return $imageHeight['boxsize'];
	}
}
?>