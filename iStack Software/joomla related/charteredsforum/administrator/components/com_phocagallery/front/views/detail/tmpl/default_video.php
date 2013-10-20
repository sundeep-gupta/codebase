<?php
defined('_JEXEC') or die('Restricted access');
if ($this->tmpl['backbutton'] != '') {
	echo $this->tmpl['backbutton'];
}
?><table border="0" style="width:<?php echo $this->tmpl['windowwidth'];?>px;height:<?php echo $this->tmpl['windowheight'];?>px;">
	<tr>
		<td colspan="5" style="text-align:center;vertical-align:middle" align="center" valign="middle">
			<?php echo $this->item->videocode; ?>
		</td>
	</tr><?php
		
	if ($this->tmpl['displaydescriptiondetail'] == 1) {
		?>
		<tr>
			<td colspan="6" align="left" valign="top" height="<?php echo $this->tmpl['descriptiondetailheight']; ?>">
			<div style="font-size:<?php echo $this->tmpl['fontsizedesc']; ?>px;height:<?php echo $this->tmpl['descriptiondetailheight']; ?>px;padding:0 20px 0 20px;color:<?php echo $this->tmpl['fontcolordesc']; ?>"><?php echo $this->item->description ?></div>
			</td>
		</tr><?php
	}
	
	if ($this->tmpl['detailbuttons'] == 1) {
		?>
		<tr>
			<td align="left" width="30%" style="padding-left:48px"><?php echo $this->item->prevbutton ;?></td>
			<td><?php /*echo $this->item->slideshowbutton */;?></td>
			<td><?php echo str_replace("%onclickreload%", $this->tmpl['detailwindowreload'], $this->item->reloadbutton);?></td>
			<?php 
			if ($this->tmpl['detailwindow'] == 4 || $this->tmpl['detailwindow'] == 5 || $this->tmpl['detailwindow'] == 7) {
			} else {
				?><td><?php echo str_replace("%onclickclose%", $this->tmpl['detailwindowclose'], $this->item->closebutton);?></td><?php
			}
			?><td align="right" width="30%" style="padding-right:48px"><?php echo $this->item->nextbutton ;?></td>
		</tr>
		<?php
	}
	?></table><?php
	
echo $this->loadTemplate('rating');
if ($this->tmpl['detailwindow'] == 7) {
	echo $this->tmpl['pgl'];
}