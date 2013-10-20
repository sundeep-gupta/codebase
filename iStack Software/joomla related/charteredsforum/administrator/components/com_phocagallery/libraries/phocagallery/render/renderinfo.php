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

class PhocaGalleryRenderInfo
{	
	function getPhocaIc($output){
		$v	= PhocaGalleryRenderInfo::getPhocaVersion();
		$i	= str_replace('.', '',substr($v, 0, 3));
		$n	= '<p>&nbsp;</p>';
		$l	= 'h'.'t'.'t'.'p'.':'.'/'.'/'.'w'.'w'.'w'.'.'.'p'.'h'.'o'.'c'.'a'.'.'.'c'.'z'.'/';
		$p	= 'P'.'h'.'o'.'c'.'a'.' '.'G'.'a'.'l'.'l'.'e'.'r'.'y';
		$im = 'i'.'c'.'o'.'n'.'-'.'p'.'h'.'o'.'c'.'a'.'-'.'l'.'o'.'g'.'o'.'-'.'s'.'m'.'a'.'l'.'l'.'.'.'p'.'n'.'g';
		$s	= 's'.'t'.'y'.'l'.'e'.'='.'"'.'t'.'e'.'x'.'t'.'-'.'d'.'e'.'c'.'o'.'r'.'a'.'t'.'i'.'o'.'n'.':'.'n'.'o'.'n'.'e'.'"';
		$b	= 't'.'a'.'r'.'g'.'e'.'t'.'='.'"'.'_'.'b'.'l'.'a'.'n'.'k'.'"';
		$im2 = 'i'.'c'.'o'.'n'.'-'.'p'.'h'.'o'.'c'.'a'.'-'.'l'.'o'.'g'.'o'.'-'.'s'.'e'.'a'.'l'.'.'.'p'.'n'.'g';
		$i	= (int)$i * (int)$i;
		$str	= '';
		if ($output != $i) {
			$str		.= $n;
			$str		.= '<div style="text-align:center">';
		}
		if ($output == 1) {
			$str	.= '<a href="'.$l.'" '.$s.' '.$b.' title="'.$p.'">'. JHTML::_('image', 'components/com_phocagallery/assets/images/'.$im, $p). '</a>';
			$str	.= ' <a href="http://www.phoca.cz/" '.$s.' '.$b.' title="'.$p.'">'. $v .'</a>';
		} else if ($output == 2 || $output == 3) {
			$str	.= '<a  href="'.$l.'" '.$s.' '.$b.' title="'.$p.'">'. JHTML::_('image', 'components/com_phocagallery/assets/images/'.$im, $p). '</a>';
		} else if ($output == 4) {
			$str	.= ' <a href="'.$l.'" '.$s.' '.$b.' title="'.$p.'">Phoca Gallery</a>';
		} else if ($output == 5) {
			$str	.= ' <a href="'.$l.'" '.$s.' '.$s.' '.$b.' title="'.$p.'">'.$p.' '.$v.'</a>';
		} else if ($output == 6) {
			$str	.= ' <a href="'.$l.'" '.$s.' '.$b.' title="'.$p.'">'. JHTML::_('image', 'components/com_phocagallery/assets/images/'.$im2, $p). '</a>';
		} else if ($output == $i) {
			$str	.= '<!-- <a href="'.$l.'">site: www.phoca.cz | version: '.$v.'</a> -->';
		} else {
			$str	.= '<a href="'.$l.'" '.$s.' '.$b.' title="'.$p.'">'. JHTML::_('image', 'components/com_phocagallery/assets/images/'.$im, $p). '</a>';
			$str	.= ' <a href="http://www.phoca.cz/" '.$s.' '.$b.' title="'.$p.'">'. $v .'</a>';
		}
		if ($output != $i) {
			$str		.= '</div>' . $n;
		}
		return $str;
	}
	
	function getPhocaVersion() {
		$folder = JPATH_ADMINISTRATOR .DS. 'components'.DS.'com_phocagallery';
		if (JFolder::exists($folder)) {
			$xmlFilesInDir = JFolder::files($folder, '.xml$');
		} else {
			$folder = JPATH_SITE .DS. 'components'.DS.'com_phocagallery';
			if (JFolder::exists($folder)) {
				$xmlFilesInDir = JFolder::files($folder, '.xml$');
			} else {
				$xmlFilesInDir = null;
			}
		}

		$xml_items = '';
		if (count($xmlFilesInDir))
		{
			foreach ($xmlFilesInDir as $xmlfile)
			{
				if ($data = JApplicationHelper::parseXMLInstallFile($folder.DS.$xmlfile)) {
					foreach($data as $key => $value) {
						$xml_items[$key] = $value;
					}
				}
			}
		}
		
		if (isset($xml_items['version']) && $xml_items['version'] != '' ) {
			return $xml_items['version'];
		} else {
			return '';
		}
	}
}
?>