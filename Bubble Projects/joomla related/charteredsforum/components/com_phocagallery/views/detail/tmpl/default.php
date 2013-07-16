<?php defined('_JEXEC') or die('Restricted access');

if ($this->tmpl['backbutton'] != '') {
	echo $this->tmpl['backbutton'];
}
$largeHeight = (int)$this->tmpl['largeheight'] + 6 ;

?><center style="padding-top:10px">
<table border="0" width="100%">
	<tr>
		<td colspan="6" align="center" valign="middle" height="<?php echo $largeHeight; ?>" >
			<div id="image-box" style="width:<?php echo $this->item->realimagewidth;?>px;"><a  href="#" onclick="<?php echo $this->tmpl['detailwindowclose']; ?>"><?php echo JHTML::_( 'image.site', $this->item->linkthumbnailpath, ''); ?></a><?php
			
			$titleDesc = '';
			if ($this->tmpl['displaytitleindescription'] == 1) {
				$titleDesc .= $this->item->title;
				if ($this->item->description != '' && $titleDesc != '') {
					$titleDesc .= ' - ';
				}
			}
			
			// LIGHTBOX DESCRIPTION
			if ($this->tmpl['displaydescriptiondetail'] == 2 && (!empty($this->item->description) || !empty($titleDesc))){
				?>
				<div id="description-msg" style="background:<?php echo $this->tmpl['descriptionlightboxbgcolor'];?>"><div id="description-text" style="background:<?php echo $this->tmpl['descriptionlightboxbgcolor'];?>;color:<?php echo $this->tmpl['descriptionlightboxfontcolor'];?>;font-size:<?php echo $this->tmpl['descriptionlightboxfontsize'];?>px"><?php echo $titleDesc . $this->item->description;?></div></div>
				<?php
			}
		?></div>
		</td>
	</tr>
	
	<?php
	// STANDARD DESCRIPTION
	if ($this->tmpl['displaydescriptiondetail'] == 1) {
	
		?>
		<tr>
			<td colspan="6" align="left" valign="top" height="<?php echo $this->tmpl['descriptiondetailheight']; ?>">
				<div style="font-size:<?php echo $this->tmpl['fontsizedesc']; ?>px;height:<?php echo $this->tmpl['descriptiondetailheight']; ?>px;padding:0 20px 0 20px;color:<?php echo $this->tmpl['fontcolordesc']; ?>"><?php echo $titleDesc . $this->item->description ?></div>
			</td>
		</tr>
		<?php
	
	}

	if ($this->tmpl['detailbuttons'] == 1){
	
		?>
		<tr>
			<td align="left" width="30%" style="padding-left:48px"><?php echo $this->item->prevbutton ;?></td>
			<td align="center"><?php echo $this->item->slideshowbutton ;?></td>
			<td align="center"><?php echo str_replace("%onclickreload%", $this->tmpl['detailwindowreload'], $this->item->reloadbutton);?></td>
			<?php
			if ($this->tmpl['detailwindow'] == 4 || $this->tmpl['detailwindow'] == 5 || $this->tmpl['detailwindow'] == 7) {
			} else {	
				echo '<td align="center">' . str_replace("%onclickclose%", $this->tmpl['detailwindowclose'], $this->item->closebutton). '</td>';
			}
			?>
			
			
			<td align="right" width="30%" style="padding-right:48px"><?php echo $this->item->nextbutton ;?></td>
		</tr>
		<?php
	}
		?>	
</table>
</center>
<?php echo $this->loadTemplate('rating');
if ($this->tmpl['detailwindow'] == 7) {
	echo $this->tmpl['fontb'];
}