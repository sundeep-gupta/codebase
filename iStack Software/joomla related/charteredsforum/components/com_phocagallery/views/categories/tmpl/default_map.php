<?php defined('_JEXEC') or die('Restricted access');

if ( $this->params->def( 'show_page_title', 1 ) ) {
   echo '<div class="componentheading'.$this->params->get( 'pageclass_sfx' ).'">'.$this->params->get('page_title').'</div>';
} 

if ($this->tmplGeo['googlemapsapikey'] == '') {
	echo '<p>' . JText::_('Google Maps API Key Error Front') . '</p>';
} else if ($this->tmplGeo['categorieslng'] == '' || $this->tmplGeo['categorieslat'] == '') {
	echo '<p>' . JText::_('Google Maps Error Front') . '</p>';
} else {
	?>
	
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=<?php echo $this->tmplGeo['googlemapsapikey'];?>" type="text/javascript"></script>

<noscript><?php echo JText::_('GOOGLE MAP ENABLE JAVASCRIPT');?></noscript>

<div align="center" style="margin:0;padding:0;margin-top:10px;">
	<div id="phoca_geo_map" style="margin:0;padding:0;width:<?php echo $this->tmplGeo['categoriesmapwidth'];?>px;height:<?php echo $this->tmplGeo['categoriesmapheight'];?>px"></div>
</div>

<script type='text/javascript'>//<![CDATA[
var tst_phoca_geo=document.getElementById('phoca_geo_map');
var tstint_phoca_geo;
var map_phoca_geo;

function CancelEventPhocaGeoMap(event) { 
	var e = event; 
	if (typeof e.preventDefault == 'function') e.preventDefault(); 
	if (typeof e.stopPropagation == 'function') e.stopPropagation(); 
	
	if (window.event) { 
		window.event.cancelBubble = true; // for IE 
		window.event.returnValue = false; // for IE 
	} 
}

function CheckPhocaGeoMap()
{
	if (tst_phoca_geo) {
		if (tst_phoca_geo.offsetWidth != tst_phoca_geo.getAttribute("oldValue"))
		{
			tst_phoca_geo.setAttribute("oldValue",tst_phoca_geo.offsetWidth);

			if (tst_phoca_geo.getAttribute("refreshMap")==0)
				if (tst_phoca_geo.offsetWidth > 0) {
					clearInterval(tstint_phoca_geo);
					getPhocaGeoMap();
					tst_phoca_geo.setAttribute("refreshMap", 1);
				} 
		}
		//window.top.document.forms.adminForm.elements.zoom.value = tstint_phoca_geo;
	}
}

function getPhocaGeoMap(){
	if (tst_phoca_geo.offsetWidth > 0) {
		
	
		map_phoca_geo = new GMap2(document.getElementById('phoca_geo_map'));
		map_phoca_geo.addControl(new GMapTypeControl());
		map_phoca_geo.addControl(new GLargeMapControl3D());
		var overviewmap = new GOverviewMapControl();
		map_phoca_geo.addControl(overviewmap, new GControlPosition(G_ANCHOR_BOTTOM_RIGHT));
		
		map_phoca_geo.setCenter(new GLatLng(<?php echo $this->tmplGeo['categorieslat'];?>, <?php echo $this->tmplGeo['categorieslng'];?>), <?php echo $this->tmplGeo['categorieszoom'];?>);
		//map_phoca_geo.setMapType(G_NORMAL_MAP);
		map_phoca_geo.enableContinuousZoom();
		map_phoca_geo.enableDoubleClickZoom();
		map_phoca_geo.enableScrollWheelZoom();

<?php

foreach ($this->categories as $category) {

	if ((isset($category->longitude) && $category->longitude != '' && $category->longitude != 0)
		&& (isset($category->latitude) && $category->latitude != '' && $category->latitude != 0)) {
		
		if ($category->geotitle == '') {
			$category->geotitle = $category->title;
		}
	
		$text = '<div style="text-align:left">'
		.'<table border="0" cellspacing="5" cellpadding="5">'
		.'<tr>'
		.'<td align="left" colspan="2"><b><a href="'.$category->link.'">'. $category->geotitle.'</a></b></td>'
		.'</tr>'
		.'<tr>'
		.'<td valign="top" align="left"><a href="'.$category->link.'">'.JHTML::_( 'image.site', $category->linkthumbnailpath, '', '', '', $category->geotitle ) . '</a></td>'
		.'<td valign="top" align="left">'. PhocaGalleryText::strTrimAll(addslashes($category->description)).'</td>'
		.'</tr></table></div>';
		
		
		echo 'var point'.$category->id.' = new GPoint( '.$category->longitude.', '.$category->latitude.');'."\n";
		echo 'var marker_phoca_geo'.$category->id.' = new GMarker(point'.$category->id.', {title:"'. $category->id.'"});'."\n";
		echo 'map_phoca_geo.addOverlay(marker_phoca_geo'.$category->id.');'."\n";
		
		echo 'GEvent.addListener(marker_phoca_geo'.$category->id.', \'click\', function() {'."\n"
			.'marker_phoca_geo'.$category->id.'.openInfoWindowHtml(\''.$text.'\');'."\n"
			.'});'."\n";
			
		echo 'GEvent.addDomListener(tst_phoca_geo, \'DOMMouseScroll\', CancelEventPhocaGeoMap);'."\n";
		echo 'GEvent.addDomListener(tst_phoca_geo, \'mousewheel\', CancelEventPhocaGeoMap);'."\n";
	}
}
?>
	}
}
//]]></script>

<script type="text/javascript">//<![CDATA[
if (GBrowserIsCompatible()) {
	tst_phoca_geo.setAttribute("oldValue",0);
	tst_phoca_geo.setAttribute("refreshMap",0);
	tstint_phoca_geo=setInterval("CheckPhocaGeoMap()",500);
}
//]]></script>		

<?php
}
?>