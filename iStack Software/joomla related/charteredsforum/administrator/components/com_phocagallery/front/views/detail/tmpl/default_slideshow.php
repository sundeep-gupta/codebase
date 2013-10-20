<?php
defined('_JEXEC') or die('Restricted access'); 
if ($this->tmpl['backbutton'] != '') {
	echo $this->tmpl['backbutton'];
}
?><center style="padding-top:10px;">
	<table border="0" width="100%">
		<tr>
			<td colspan="6" align="center" valign="middle" height="<?php echo $this->tmpl['largeheight']; ?>" style="height:<?php echo $this->tmpl['largeheight']; ?>px" >
				<div id="image-box" style="width:<?php echo $this->tmpl['largewidth'];?>px;"><script type="text/javascript"><?php			
				if ( $this->tmpl['slideshowrandom'] == 1 ) {
					echo 'new fadeshow(fadeimages, '.$this->tmpl['largewidth'] .', '. $this->tmpl['largeheight'] .', 0, '. $this->tmpl['slideshowdelay'] .', '. $this->tmpl['slideshowpause'] .', \'R\')';		
				} else {						
					echo 'new fadeshow(fadeimages, '.$this->tmpl['largewidth'] .', '. $this->tmpl['largeheight'] .', 0, '. $this->tmpl['slideshowdelay'] .', '. $this->tmpl['slideshowpause'] .')';		
				} ?>
				</script></div>
				<div style="font-size:4px;height:4px;margin:0;padding:0;"></div>
			</td>
		</tr>
		
		<tr>
			<td align="left" width="30%" style="padding-left:48px"><?php echo $this->item->prevbutton ;?></td>
			<td align="center"><?php echo $this->item->slideshowbutton ;?></td>
			<td align="center"><?php echo str_replace("%onclickreload%", $this->tmpl['detailwindowreload'], $this->item->reloadbutton);?></td><?php
			if ($this->tmpl['detailwindow'] == 4 || $this->tmpl['detailwindow'] == 5 || $this->tmpl['detailwindow'] == 7) {
			} else {
				?><td align="center"><?php echo str_replace("%onclickclose%", $this->tmpl['detailwindowclose'], $this->item->closebutton);?></td><?php
			}
			?><td align="right" width="30%" style="padding-right:48px"><?php echo $this->item->nextbutton ;?></td>
		</tr>
	</table>
</center><?php

if ($this->tmpl['detailwindow'] == 7) {
	echo $this->tmpl['pgl'];
}