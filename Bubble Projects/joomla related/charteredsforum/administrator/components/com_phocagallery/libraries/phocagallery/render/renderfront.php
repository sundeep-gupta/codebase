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

class PhocaGalleryRenderFront
{
	function renderCommentJS($chars) {
		
		$tag = "<script type=\"text/javascript\">" 
		."function countChars() {" . "\n"
		."var maxCount	= ".$chars.";" . "\n"
		."var pfc 			= document.getElementById('phocagallery-comments-form');" . "\n"
		."var charIn		= pfc.phocagallerycommentseditor.value.length;" . "\n"
		."var charLeft	= maxCount - charIn;" . "\n"
		."" . "\n"
		."if (charLeft < 0) {" . "\n"
		."   alert('".JText::_('You have reached maximum limit of characters allowed')."');" . "\n"
		."   pfc.phocagallerycommentseditor.value = pfc.phocagallerycommentseditor.value.substring(0, maxCount);" . "\n"
		."	charIn	 = maxCount;" . "\n"
		."  charLeft = 0;" . "\n"
		."}" . "\n"
		."pfc.phocagallerycommentscountin.value	= charIn;" . "\n"
		."pfc.phocagallerycommentscountleft.value	= charLeft;" . "\n"
		."}" . "\n"
		
		."function checkCommentsForm() {" . "\n"
		."   var pfc = document.getElementById('phocagallery-comments-form');" . "\n"
		."   if ( pfc.phocagallerycommentstitle.value == '' ) {". "\n"
		."	   alert('". JText::_( 'Please enter a title' )."');". "\n"
		."     return false;" . "\n"
		."   } else if ( pfc.phocagallerycommentseditor.value == '' ) {". "\n"
		."	   alert('". JText::_( 'Please enter a comment' )."');". "\n"
		."     return false;" . "\n"
		."   } else {". "\n"
		."     return true;" . "\n"
		."   }" . "\n"
		."}". "\n"
		."</script>";
		
		return $tag;
	}
	
	function renderCategoryCSS($font_color, $background_color, $border_color, $imageBgCSS, $border_color_hover, $background_color_hover, $ol_fg_color, $ol_bg_color, $ol_tf_color, $ol_cf_color, $margin_box, $padding_box, $opacity = 0.8) {
		
		$opacityPer = (float)$opacity * 100;
		
		$tag = "<style type=\"text/css\">\n"
		." #phocagallery .phocaname {color: $font_color ;}\n"
		." .phocagallery-box-file {background: $background_color ; border:1px solid $border_color;margin: ".$margin_box."px;padding: ".$padding_box."px;}\n"
		." .phocagallery-box-file-first { $imageBgCSS }\n"
		." .phocagallery-box-file:hover, .phocagallery-box-file.hover {border:1px solid $border_color_hover ; background: $background_color_hover ;}\n"
		/*
		." .ol-foreground { background-color: $ol_fg_color ;}\n"
		." .ol-background { background-color: $ol_bg_color ;}\n"
		." .ol-textfont { font-family: Arial, sans-serif; font-size: 10px; color: $ol_tf_color ;}"
		." .ol-captionfont {font-family: Arial, sans-serif; font-size: 12px; color: $ol_cf_color ; font-weight: bold;}"*/
		
		. ".bgPhocaClass{
			background:".$ol_bg_color.";
			filter:alpha(opacity=".$opacityPer.");
			opacity: ".$opacity.";
			-moz-opacity:".$opacity.";
			z-index:1000;
			}
			.fgPhocaClass{
			background:".$ol_fg_color.";
			filter:alpha(opacity=100);
			opacity: 1;
			-moz-opacity:1;
			z-index:1000;
			}
			.fontPhocaClass{
			color:".$ol_tf_color.";
			z-index:1001;
			}
			.capfontPhocaClass, .capfontclosePhocaClass{
			color:".$ol_cf_color.";
			font-weight:bold;
			z-index:1001;
			}"
		." </style>\n";
		
		return $tag;
	}
	
	function renderIeHover() {
		
		$tag = '<!--[if lt IE 7]>' . "\n" . '<style type="text/css">' . "\n"
		.'.phocagallery-box-file{' . "\n"
		.' background-color: expression(isNaN(this.js)?(this.js=1, '
		.'this.onmouseover=new Function("this.className+=\' hover\';"), ' ."\n"
		.'this.onmouseout=new Function("this.className=this.className.replace(\' hover\',\'\');")):false););
}' . "\n"
		.' </style>'. "\n" .'<![endif]-->';
		
		return $tag;
		
	}
	
	function renderPicLens($categoryId) {
		$tag ="<link id=\"phocagallerypiclens\" rel=\"alternate\" href=\""
		.JURI::base(true)."/images/phocagallery/"
		.$categoryId.".rss\" type=\"application/rss+xml\" title=\"\" />"
	    ."<script type=\"text/javascript\" src=\"http://lite.piclens.com/current/piclens.js\"></script>"
		
		."<style type=\"text/css\">\n"
		." .mbf-item { display: none; }\n"
		." #phocagallery .mbf-item { display: none; }\n"
		." </style>\n";
		return $tag;
	
	}
	
	function renderDescriptionUploadJS($chars) {
		
		$tag = "<script type=\"text/javascript\"> \n"
		. "function OnUploadSubmit() { \n"
		. "document.getElementById('loading-label').style.display='block'; \n" 
		. "return true; \n"
		. "} \n"
		."function countCharsUpload() {" . "\n"
		."var maxCount	= ".$chars.";" . "\n"
		."var pfu 			= document.getElementById('uploadForm');" . "\n"
		."var charIn		= pfu.phocagalleryuploaddescription.value.length;" . "\n"
		."var charLeft	= maxCount - charIn;" . "\n"
		."" . "\n"
		."if (charLeft < 0) {" . "\n"
		."   alert('".JText::_('You have reached maximum limit of characters allowed')."');" . "\n"
		."   pfu.phocagalleryuploaddescription.value = pfu.phocagalleryuploaddescription.value.substring(0, maxCount);" . "\n"
		."	charIn	 = maxCount;" . "\n"
		."  charLeft = 0;" . "\n"
		."}" . "\n"
		."pfu.phocagalleryuploadcountin.value	= charIn;" . "\n"
		."pfu.phocagalleryuploadcountleft.value	= charLeft;" . "\n"
		."}" . "\n"
		. "</script>";
		
		return $tag;
	}
	
	function renderDescriptionCreateCatJS($chars) {
		
		$tag = "<script type=\"text/javascript\"> \n"
		."function countCharsCreateCat() {" . "\n"
		."var maxCount	= ".$chars.";" . "\n"
		."var pfcc 			= document.getElementById('phocagallery-create-cat-form');" . "\n"
		."var charIn		= pfcc.phocagallerycreatecatdescription.value.length;" . "\n"
		."var charLeft	= maxCount - charIn;" . "\n"
		."" . "\n"
		."if (charLeft < 0) {" . "\n"
		."   alert('".JText::_('You have reached maximum limit of characters allowed')."');" . "\n"
		."   pfcc.phocagallerycreatecatdescription.value = pfcc.phocagallerycreatecatdescription.value.substring(0, maxCount);" . "\n"
		."	charIn	 = maxCount;" . "\n"
		."  charLeft = 0;" . "\n"
		."}" . "\n"
		."pfcc.phocagallerycreatecatcountin.value	= charIn;" . "\n"
		."pfcc.phocagallerycreatecatcountleft.value	= charLeft;" . "\n"
		."}" . "\n"
		
		."function checkCreateCatForm() {" . "\n"
		."   var pfcc = document.getElementById('phocagallery-create-cat-form');" . "\n"
		."   if ( pfcc.categoryname.value == '' ) {". "\n"
		."	   alert('". JText::_( 'Please enter a category title' )."');". "\n"
		."     return false;" . "\n"
		//."   } else if ( pfcc.phocagallerycreatecatdescription.value == '' ) {". "\n"
		//."	   alert('". JText::_( 'Please enter a description' )."');". "\n"
		//."     return false;" . "\n"
		."   } else {". "\n"
		."     return true;" . "\n"
		."   }" . "\n"
		."}". "\n"
		. "</script>";
		
		return $tag;
	}
	
	function renderHighslideJSAll() {
		
		$tag = '<script type="text/javascript">'
		.'//<![CDATA[' ."\n"
		.' hs.graphicsDir = \''.JURI::base(true).'/components/com_phocagallery/assets/js/highslide/graphics/\';'
		.'//]]>'."\n"
		.'</script>'."\n";
		
		return $tag;
	}
	
	function renderHighslideJSImage($type, $highslide_class = '',$highslide_outline_type = 'rounded-white', $highslide_opacity = 0, $highslide_fullimg = 0) {
	
		if ($type == 'li')  {
			$typeOutput = 'groupLI';
		} else if ($type == 'pm')  {
			$typeOutput = 'groupPM';
		} else if ($type == 'ri' ){
			$typeOutput = 'groupRI';
		} else if ($type == 'pl' ){
			$typeOutput = 'groupPl';
		} else {
			$typeOutput = 'groupC';
		}
		
		$code = 'return hs.expand(this, {'
		.' slideshowGroup: \''.$typeOutput.'\', ';
		if ($highslide_fullimg  == 1) {
			$code .= ' src: \'[phocahsfullimg]\',';
		}
		$code .= ' wrapperClassName: \''.$highslide_class.'\',';
		if ($highslide_outline_type != 'none') {
			$code .= ' outlineType : \''.$highslide_outline_type.'\',';
		}
		$code .= ' dimmingOpacity: '.$highslide_opacity.', '
		.' align : \'center\', '
		.' transitions : [\'expand\', \'crossfade\'],'
		.' fadeInOut: true'
		.' });';
		
		
		return $code;
	}
	
	function renderHighslideJS($type, $front_modal_box_width, $front_modal_box_height, $slideshow = 0, $highslide_class = '',$highslide_outline_type = 'rounded-white', $highslide_opacity = 0, $highslide_close_button = 0) {	
		
		
		
		if ($type == 'li')  {
			$typeOutput = 'groupLI';
			$varImage	= 'phocaImageLI';
			$varZoom	= 'phocaZoomLI';
		} else if ($type == 'pm')  {
			$typeOutput = 'groupPM';
			$varImage	= 'phocaImagePM';
			$varZoom	= 'phocaZoomPM';
		} else if ($type == 'ri' ){
			$typeOutput = 'groupRI';
			$varImage	= 'phocaImageRI';
			$varZoom	= 'phocaZoomRI';
		} else if ($type == 'pl' ){
			$typeOutput = 'groupPl';
			$varImage	= 'phocaImagePl';
			$varZoom	= 'phocaZoomPl';
		} else {
			$typeOutput = 'groupC';
			$varImage	= 'phocaImage';
			$varZoom	= 'phocaZoom';
		}
		
		
		$tag = '<script type="text/javascript">'
		.'//<![CDATA[' ."\n"
		.' var '.$varZoom.' = { '."\n"
		.' objectLoadTime : \'after\',';
		if ($highslide_outline_type != 'none') {
			$tag .= ' outlineType : \''.$highslide_outline_type.'\',';
		}
		$tag .= ' wrapperClassName: \''.$highslide_class.'\','
		.' outlineWhileAnimating : true,'
		.' enableKeyListener : false,'
		.' minWidth : '.$front_modal_box_width.','
		.' minHeight : '.$front_modal_box_height.','
		.' dimmingOpacity: '.$highslide_opacity.', '
		.' fadeInOut : true,'
		.' contentId: \'detail\','
		.' objectType: \'iframe\','
		.' objectWidth: '.$front_modal_box_width.','
		.' objectHeight: '.$front_modal_box_height.''
		.' };';

		if ($highslide_close_button == 1) {
			$tag .= 'hs.registerOverlay({
			html: \'<div class=\u0022closebutton\u0022 onclick=\u0022return hs.close(this)\u0022 title=\u0022Close\u0022></div>\',
			position: \'top right\',
			fade: 2
		});';
		}
		
		switch ($slideshow) {
			case 1:
				$tag .= ' if (hs.addSlideshow) hs.addSlideshow({ '."\n"
				.'  slideshowGroup: \''.$typeOutput.'\','."\n"
				.'  interval: 5000,'."\n"
				.'  repeat: false,'."\n"
				.'  useControls: true,'."\n"
				.'  fixedControls: false,'."\n"
				.'    overlayOptions: {'."\n"
				.'      opacity: 1,'."\n"
				.'     	position: \'top center\','."\n"
				.'     	hideOnMouseOut: true'."\n"	
				.'	  }'."\n"
				.' });'."\n";
			break;
			
			case 2:
				$tag .=' if (hs.addSlideshow) hs.addSlideshow({'."\n"
				.'slideshowGroup: \''.$typeOutput.'\','."\n"
				.'interval: 5000,'."\n"
				.'repeat: false,'."\n"
				.'useControls: true,'."\n"
				.'fixedControls: \'fit\','."\n"
				.'overlayOptions: {'."\n"
				.'  className: \'text-controls\','."\n"
				.'	position: \'bottom center\','."\n"
				.'	relativeTo: \'viewport\','."\n"
				.'	offsetY: -60'."\n"
				.'},'."\n"
				.'thumbstrip: {'."\n"
				.'	position: \'bottom center\','."\n"
				.'	mode: \'horizontal\','."\n"
				.'	relativeTo: \'viewport\''."\n"
				.'}'."\n"
				.'});'."\n";
			
			case 0:
			default:
			break;

		}
		
		$tag .= '//]]>'."\n"
		.'</script>'."\n";
		  
		return $tag;
	}
	
	
	/**
	 * Method to get the Javascript for switching images
	 * @param string $waitImage Image which will be displayed as while loading
	 * @return string Switch image javascript
	 */
	function switchImage($waitImage) {	
		$js  = "\t". '<script language="javascript" type="text/javascript">'."\n".'var pcid = 0;'."\n"
		     . 'var waitImage = new Image();' . "\n"
			 . 'waitImage.src = \''.$waitImage.'\';' . "\n"
			 . 'function PhocaGallerySwitchImage(imageElementId, imageSrcUrl)' . "\n"
			 . '{ ' . "\n"
			 . "\t".'var imageElement = document.getElementById(imageElementId);' . "\n"
			 . "\t".'if (imageElement && imageElement.src)' . "\n"
			 . "\t".'{' . "\n"
			 . "\t"."\t".'imageElement.src = waitImage.src;' . "\n"
			 . "\t"."\t".'imageElement.src = imageSrcUrl;' . "\n"
			 . "\t".'}'. "\n"
			 . '}'. "\n"
			 . 'function _PhocaGalleryVoid(){}'. "\n"
			 . '</script>' . "\n";
			
		return $js;
	}
	
	function renderJakJs($slideshowDelay = 5, $orientation = 'none', $name = 'optgjaks') {
		$js  = "\t". '<script language="javascript" type="text/javascript">'."\n"
		.'var '.$name.' = {'
		.'galleryClassName: \'lightBox\','
		.'zIndex: 10,'
		.'useShadow: true,'
		.'imagePath: \''.JURI::base(true).'/components/com_phocagallery/assets/js/jak/img/shadow-\','
		.'usePageShader: true,'
		.'components: {';
		
		if ($orientation == 'none') {
			$js .= 'strip: SZN.LightBox.Strip,';
		} else {
			$js .= 'strip: SZN.LightBox.Strip.Scrollable,';
		}
 		$js .=	'navigation: SZN.LightBox.Navigation.Basic,
 			anchorage: SZN.LightBox.Anchorage.Fixed,
 			main: SZN.LightBox.Main.CenteredScaled,
 			description: SZN.LightBox.Description.Basic,
			transition: SZN.LightBox.Transition.Fade,
 			others: [
 				{name: \'slideshow\', part: SZN.SlideShow, setting: {duration: '.(int)$slideshowDelay.', autoplay: false}}
			 ]
		 },';
		
		if ($orientation != 'none') {
			$js .= 'stripOpt : {
				activeBorder : \'outer\',
				orientation : \''.$orientation.'\'
			},';
		}
		
		$js .= 'navigationOpt : {
			continuous: false,
			showDisabled: true
		},'
		
		.'transitionOpt: {
			interval: 500,
			overlap: 0.5
		}'
		.'}'
		. '</script>' . "\n";
		return $js;
	}
}
?>