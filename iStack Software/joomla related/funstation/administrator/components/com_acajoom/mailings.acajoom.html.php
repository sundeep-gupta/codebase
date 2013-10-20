<?php
defined('_JEXEC') OR defined('_VALID_MOS') OR die('...Direct Access to this location is not allowed...');
/**
* @copyright Copyright (C) 2009 Joobi Limited All rights reserved.
* @license This file is released under the GPL license (http://www.gnu.org/licenses )
* @link http://www.ijoobi.com
*/
class mailingsHTML {

	function previewMailingHTML($mailingId, $listId, $listType){
?>
<script language="javascript" type="text/javascript">
<!--
	function submitbutton(pressbutton) {
		var form = document.adminForm;
		if (pressbutton == 'cancel') {
			submitform( pressbutton );
			return;
		}
		submitform( pressbutton );
	}
//-->
</script>
<span class="sectionname"><?php echo _ACA_PREVIEW_EMAIL_TEST; ?>:</span><br />
<br />
<form action="index2.php" method="POST" name="adminForm">
	<input type="hidden" name="option" value="com_acajoom" />
	<input type="hidden" name="listype" value="<?php echo $listType; ?>" />
	<input type="hidden" name="act" value="mailing" />
	<input type="hidden" name="task" value="" />
    <input type="hidden" name="boxchecked" value="0" />
	<input type="hidden" name="mailingid" value="<?php echo $mailingId; ?>" />
	<input type="hidden" name="listid" value="<?php echo $listId; ?>" />
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="contentpane">
		<tr>
			<td align="left"><?php echo _ACA_INPUT_NAME; ?></td>
			<td align="left"><input type="text" name="name" size=50 class="inputbox" value="<?php
			if ( ACA_CMSTYPE ) {	// joomla 15
			$my	=& JFactory::getUser();
			}else{
				global $my;
			}
			echo trim($my->name);
			?>"/></td>
		</tr>
		<tr>
			<td align="left"><?php echo _ACA_INPUT_EMAIL; ?></td>
			<td align="left"><input type="text" name="emailaddress" class="inputbox" size=50 value="<?php
			echo trim($my->email);
			?>"/></td>
		</tr>
		<tr>
			<td align="left" colspan="2"><?php echo _ACA_SEND_IN_HTML; ?>
			<input type="checkbox" value="1" name="html" class="inputbox" checked="checked" /></td>
    	</tr>
	</table>
</form>
<br />
<?php
	 }


	 function showMailingList($mailings, &$lists, $start, $limit, $total, $emailsearch, $listId, $listType, $forms, $show, $action) {
		global $Itemid;

		if ( ACA_CMSTYPE ) {	// joomla 15
			$my	=& JFactory::getUser();
		} else {									//joomla 1x
		    global $my;
		}//endif

		$item = ( !empty($Itemid)) ? '&Itemid=' . $Itemid : '';

		if ($show['dropdown']) {
		 	echo $forms['select'];
		 	 ?>
			<input type="hidden" name="option" value="com_acajoom" />
	    	<input type="hidden" name="boxchecked" value="0" />
			<input type="hidden" name="act" value="<?php echo $action; ?>" />
			<input type="hidden" name="task" value="show" />
			<input type="hidden" name="limit" value="<?php echo $limit; ?>" />
			<table style="text-align: left; width: 100%;" border="0" cellpadding="2" cellspacing="0"><tbody><tr>
		 <td style="text-align: left; padding-left: 20px;"><span class="sectionname">
		 <?php echo $lists['title'];?>
		 </td>
		 <td style="text-align: right;">
		 <?php echo _ACA_SEL_LIST.' : '. $lists['droplist']."  ";?>
		  <?php echo _ACA_FILTER; ?> :
		<input type="text" name="emailsearch" value="<?php echo $emailsearch; ?>" class="inputbox" onChange="document.AcajoomFilterForm.submit();" />
		</td></tr></tbody></table>
		</form>
		<?php
		}
	 echo $forms['main']; ?>

	<table width="100%" cellpadding="4" cellspacing="0" border="0" align="center" class="adminlist">
		<th width="40" height="20" align="center" class="title"><center>#</center></th>
		 <?php if ($show['select']) { ?>
		<th width="32"  align="center" class="title">&nbsp;</th>
		 <?php } if ($show['status']) { ?>
		<th  width="40" class="title" align="center"><center><?php echo _ACA_PUBLISHED; ?></center></th>
		 <?php } if ($show['delay']) { ?>
		<th width="80"  class="title" align="center"><center><?php echo _ACA_LIST_DELAY; ?></center></th>
		 <?php } if ($show['sentdate']) { ?>
		<th width="140"  class="title"><?php echo _ACA_LIST_DATE; ?></th>
		 <?php } if ($show['issue']) { ?>
		<th width="60"  class="title"><?php echo _ACA_LIST_ISSUE; ?></th>
		<?php } ?>
		<th class="title" align="left"><?php echo _ACA_LIST_SUB; ?></th>
		 <?php if ($show['status']) { ?>
		<th  width="40" class="title" align="center"><center><?php echo _ACA_VISIBLE; ?></center></th>
		 <?php } if ($show['id']) { ?>
		<th width="40" class="title"><center>id #</center></th>
		<?php } ?>
	</tr>
	<?php

		 if (!empty($mailings)) {

			 $i = 0;
			 foreach ($mailings as $mailing) {
	?>
	<tr>
		<td  height="20" align="center"><center><?php echo $i + 1 + $start; ?></center></td>
		 <?php if ($show['select'])  { ?>
		<td  align="center"><input type="radio" id="cb<?php echo $i;?>" name="mailingid" value="<?php echo $mailing->id; ?>" onclick="isChecked(this.checked);" /></td>
		 <?php
		 }
		 if ($show['status']) {


				 switch ($mailing->published) {
				 	case '1':
						 $img = 'publish_g.png';
				 		break;
				 	case '2':
						 $img = 'publish_y.png';
				 		break;
				 	default:
						 $img = 'publish_r.png';
				 		break;
				 }
		?>
		<td  align="center"><center><img src="<?php echo ACA_JPATH_LIVE; ?>/administrator/images/<?php echo $img; ?>" width="12" height="12" border="0" alt="" /></center></td>
		 <?php } if ($show['delay']) {
		 $delay = $mailing->delay / 1440;
		  ?>
		<td  align="center"><?php echo $delay; ?></td>
		 <?php } if ($show['sentdate']) { ?>
		<td ><?php echo $mailing->send_date; ?></td>
		 <?php } if ($show['issue']) { ?>
		<td  align="center"><center><?php echo $mailing->issue_nb; ?></center></td>
		<?php }
		if (!isset($mailing->list_id) or $mailing->list_id < 1) {$mailing->list_id = 0;}

		$backendLink = ($show['index'] == 'index') ? false : true;
		if ((!$show['admin']) OR ( $mailing->published == 1 AND ($mailing->list_type == 1 or $mailing->list_type == 7 or $mailing->list_type == 2))) {

			$link = '.php?option=com_acajoom&act=' . $action . '&task=view&listid='.$mailing->list_id.'&mailingid=' .$mailing->id . $item ;
			compa::completeLink($link,$backendLink);

		} else {
			$link = '.php?option=com_acajoom&act=' . $action . '&task=edit&mailingid=' .$mailing->id . '&listid=' . $mailing->list_id . '&listype=' .$mailing->list_type . $item;
			compa::completeLink($link,$backendLink);
		}


		?>
		<td align="left"><a href="<?php echo $link;  ?>" >
		<?php echo $mailing->subject; ?></a></td>
		 <?php if ($show['status']) {

			 if ($mailing->visible == 1) {

				 $img = 'tick.png';
			 } else {

				 $img = 'publish_x.png';
			 }
		?>
		<td align="center"><center><img src="<?php echo ACA_JPATH_LIVE; ?>/administrator/images/<?php echo $img; ?>" width="12" height="12" border="0" alt="" /></center></td>
		 <?php } if ($show['id']) { ?>
		<td align="center"><center><?php echo $mailing->id; ?></center></td>
		<?php } ?>
	</tr>
	<?php
			$i++;
			 }
		 }
	?>
	</table>
    <input type="hidden" name="act" value="<?php echo $action; ?>" />
    <input type="hidden" name="listid" value="<?php echo $listId; ?>" />
    <input type="hidden" name="listype" value="<?php echo $listType; ?>" />
	<?php
	 }


	 function editMailing($mailingEdit, $new, $listId, $forms, $show) {
		$lists = array();

		$folders 	= array();
		if ( ACA_CMSTYPE ) {
			$my	=& JFactory::getUser();
			$folders[] 	= JHTML::_('select.option', '/' );
			$lists['published'] = JHTML::_('select.booleanlist', 'published', 'class="inputbox"', $mailingEdit->published );
			$lists['visible'] = JHTML::_('select.booleanlist', 'visible', 'class="inputbox"', $mailingEdit->visible );
		} else {
		    global $my;
			$folders[] 	= mosHTML::makeOption( '/' );
			$lists['published'] = mosHTML::yesnoRadioList( 'published', 'class="inputbox"', $mailingEdit->published );
			$lists['visible'] = mosHTML::yesnoRadioList( 'visible', 'class="inputbox"', $mailingEdit->visible );
		}//endif

		$images = $mailingEdit->images;
		if (!isset($mailingEdit->list_id)) $mailingEdit->list_id = $listId;

		$pathA 		= ACA_JPATH_ROOT_NO_ADMIN .'/images/stories';
		$pathL 		= ACA_JPATH_LIVE .'/images/stories';
		$images 	= array();


		if( ACA_CMSTYPE ){

			mailingsHTML::ReadImages( $pathA, '/', $folders, $images );

			if ( !isset($images['/'] ) ) {
				$images['/'][] = JHTML::_('select.option',  '' );
			}
			$javascript	= "onchange=\"previewImage( 'imagefiles', 'view_imagefiles', '$pathL/' )\"";
			$lists['imagefiles']	= JHTML::_('select.genericlist',   $images['/'], 'imagefiles', 'class="inputbox" size="10" multiple="multiple" '. $javascript , 'value', 'text', null );

			$javascript 	= "onchange=\"changeDynaList( 'imagefiles', folderimages, document.adminForm.folders.options[document.adminForm.folders.selectedIndex].value, 0, 0);  previewImage( 'imagefiles', 'view_imagefiles', '$pathL/' );\"";
			$lists['folders'] 	= JHTML::_('select.genericlist',   $folders, 'folders', 'class="inputbox" size="1" '. $javascript, 'value', 'text', '/' );

			$images2 = array();
			foreach( $mailingEdit->images as $file ) {
				$temp = explode( '|', $file );
				if( strrchr($temp[0], '/') ) {
					$filename = substr( strrchr($temp[0], '/' ), 1 );
				} else {
					$filename = $temp[0];
				}
				$images2[] = JHTML::_('select.option',  $file, $filename );
			}
			//$javascript	= "onchange=\"previewImage( 'imagelist', 'view_imagelist', '$path/' ); showImageProps( '$path/' ); \" onfocus=\"previewImage( 'imagelist', 'view_imagelist', '$path/' )\"";
			$javascript	= "onchange=\"previewImage( 'imagelist', 'view_imagelist', '$pathL/' ); showImageProps( '$pathL/' ); \"";
			$lists['imagelist'] 	= JHTML::_('select.genericlist',   $images2, 'imagelist', 'class="inputbox" size="10" '. $javascript, 'value', 'text' );

		  	$lists['_align'] 			= JHTML::_('list.positions', '_align' );
			$lists['_caption_align'] 	= JHTML::_('list.positions', '_caption_align' );

		} else {
			mosAdminMenus::ReadImages( $pathA, '/', $folders, $images );

		  	$lists['folders'] 			= mosAdminMenus::GetImageFolders( $folders, $pathL );
		  	$lists['imagefiles']		= mosAdminMenus::GetImages( $images, $pathL );
		  	$lists['imagelist'] 		= mosAdminMenus::GetSavedImages( $mailingEdit , $pathL );

		  	$lists['_align'] 			= mosAdminMenus::Positions( '_align' );
			$lists['_caption_align'] 	= mosAdminMenus::Positions( '_caption_align' );
		}//endif


		if ( ACA_CMSTYPE ) {	// joomla 15
			$pos[] = JHTML::_('select.option', 'bottom', _CMN_BOTTOM );
			$pos[] = JHTML::_('select.option', 'top', _CMN_TOP );
			$lists['_caption_position'] = JHTML::_('select.genericlist', $pos, '_caption_position', 'class="inputbox" size="1"', 'value', 'text' );
		} else {									//joomla 1x
			$pos[] = mosHTML::makeOption( 'bottom', _CMN_BOTTOM );
			$pos[] = mosHTML::makeOption( 'top', _CMN_TOP );
			$lists['_caption_position'] = mosHTML::selectList( $pos, '_caption_position', 'class="inputbox" size="1"', 'value', 'text' );
		}//endif

		backHTML::formStart('edit_mailing', $mailingEdit->html, $images);
		echo $forms['main'];
		if ( $new AND $mailingEdit->list_type==7 ) {
			$mailingEdit->issue_nb=0;
		}

		mailingsHTML::layout($mailingEdit, $lists, $show);
		?>
		<input type="hidden" name="images" value="" />
		<input type="hidden" name="html" value="<?php echo $mailingEdit->html; ?>" />
		<input type="hidden" name="new_list" value="<?php echo $new; ?>" />
		<input type="hidden" name="listid" value="<?php echo $listId; ?>" />
		<input type="hidden" name="listype" value="<?php echo $mailingEdit->list_type; ?>" />
		<input type="hidden" name="mailingid" value="<?php echo $mailingEdit->id; ?>" />
		<input type="hidden" name="issue_nb" value="<?php echo $mailingEdit->issue_nb; ?>" />
	    <input type="hidden" name="userid" value="<?php echo $my->id; ?>" />
		<?php
	 }


	function subject($mailingEdit, $lists, $show) {

?>
	<fieldset class="acajoomcss">
	<legend><?php echo _ACA_LIST_T_GENERAL; ?></legend>
	<table class="acajoomtable" cellspacing="1">
		<tbody>
		<tr>
			<td width="110px" class="key">
				<span class="editlinktip">
				<?php
					$tip = _ACA_INFO_LIST_SUBJET ;
					$title = _ACA_SUBJECT;
					echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
				?>
				</span>
			</td>
			<td>
			<?php
			 	$text = str_replace('"', '&quot;' , $mailingEdit->subject);
			 	if (function_exists('htmlspecialchars_decode')) {
			 		$text = htmlspecialchars_decode( $text , ENT_NOQUOTES);
			 	} elseif (function_exists('html_entity_decode')) {
			 		$text = html_entity_decode( $text , ENT_NOQUOTES);
			 	}
				echo ' <input type="text" name="subject" class="inputbox" size="50" maxlength="64" value="' .  $text  .'" />' ;
			 ?>
			</td>
		</tr>
	<?php if ($show['issuenb']) {?>
		<tr>
			<td class="key">
				<span class="editlinktip">
				<?php
					$tip = _ACA_ISSUE_NB_TIPS ;
					$title = @constant( $GLOBALS[ACA.'listname'.$mailingEdit->list_type] ). ' #' ;
					echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
				?>
				</span>
			</td>
			<td>
			<?php	echo $mailingEdit->issue_nb; ?>
			</td>
		</tr>
	<?php } else {
		echo '	<input type="hidden" name="issue_nb" value="'.$mailingEdit->issue_nb.'" />';
	} ?>
	<?php if ($show['delay']) {?>
			<tr>
				<td class="key">
					<span class="editlinktip">
					<?php
						$tip = _ACA_INFO_LIST_DELAY ;
						$title = _ACA_AUTO_DELAY;
						echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
					?>
					</span>
				</td>
				<td>
				<?php
				$delay = $mailingEdit->delay / 1440;
				?>
					<input type="text" name="delay" class="inputbox" size="5" maxlength="10" value="<?php echo $delay; ?>" />
				</td>
			</tr>
	<?php } ?>
	<?php if (($show['pub_date']) AND ($GLOBALS[ACA.'listype2']=='1') AND class_exists('auto')) { ?>
		<tr>
			<td class="key">
				<span class="editlinktip">
				<?php
					$tip = _ACA_INFO_LIST_DATE ;
					$title = _ACA_LIST_DATE;
					$tip .= '<br/>(Actual server time is '. acajoom::getNow() .' )';
					echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
				?>
				</span>
			</td>
			<td>
				<input type="text" name="senddate" class="inputbox" size="25" maxlength="25" value="<?php echo $mailingEdit->send_date; ?>" />
			</td>
		</tr>
	<?php } ?>
			<tr>
				<td class="key">
					<span class="editlinktip">
					<?php
						$tip = '';
						$title = _ACA_LIST_NAME;
						echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
					?>
					</span>
				</td>
				<td>
				<?php
				$name =  lists::getLists($mailingEdit->list_id , 0, null, '', false, false, true);
				echo $name[0]->list_name;
				?>
				</td>
			</tr>
		</tbody>
	</table>
	</fieldset>
	<?php

	 }



	function description($mailingEdit, $lists, $show) {

	?>
	<?php if ($show['published'] OR $show['hide']) {?>
	<fieldset class="acajoomcss">
	<legend><?php echo _ACA_STATUS; ?></legend>
	<table class="acajoomtable" cellspacing="1">
		<tbody>
	<?php if ($show['published']) {?>
		<tr>
			<td width="185" class="key">
				<span class="editlinktip">
				<?php
					$tip = _ACA_INFO_LIST_PUB ;
					$title = _ACA_PUBLISHED;
					echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
				?>
				</span>
			</td>
			<td><?php echo $lists['published']; ?></td>
		</tr>
	<?php } ?>
	<?php if ($show['hide']) {?>
		<tr>
			<td width="185" class="key">
				<span class="editlinktip">
				<?php
					$tip = _ACA_INFO_MAILING_VISIBLE;
					$title = _ACA_VISIBLE_FRONT;
					echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
				?>
				</span>
			</td>
			<td><?php echo $lists['visible']; ?></td>
		</tr>
	<?php } ?>
		</tbody>
	</table>
	</fieldset>
	<?php } ?>

	<?php if ($show['sender_info']) {?>
	<fieldset class="acajoomcss">
	<legend><?php echo _ACA_LIST_T_SENDER; ?></legend>
	<table class="acajoomtable" cellspacing="1">
		<tbody>
		<tr>
			<td width="185" class="key">
				<span class="editlinktip">
				<?php
					$tip = _ACA_INFO_LIST_SENDER_NAME ;
					$title = _ACA_SENDER_NAME;
					echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
				?>
				</span>
			</td>
			<td>
			<?php
				$text = str_replace('"', '&quot;' , $mailingEdit->fromname);
			 	if (function_exists('htmlspecialchars_decode')) {
			 		$text = htmlspecialchars_decode( $text , ENT_NOQUOTES);
			 	} elseif (function_exists('html_entity_decode')) {
			 		$text = html_entity_decode( $text , ENT_NOQUOTES);
			 	}
				echo '<input type="text" name="fromname" class="inputbox" size="20" maxlength="64" value="' . $text  .'" />';
				?>
			</td>
		</tr>
		<tr>
			<td width="185" class="key">
				<span class="editlinktip">
				<?php
					$tip = _ACA_INFO_LIST_SENDER_EMAIL ;
					$title = _ACA_SENDER_EMAIL;
					echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
				?>
				</span>
			</td>
			<td>
				<input type="text" name="fromemail" class="inputbox" size="20" maxlength="64" value="<?php echo $mailingEdit->fromemail; ?>" />
			</td>
		</tr>
		<tr>
			<td width="185" class="key">
				<span class="editlinktip">
				<?php
					$tip = _ACA_INFO_LIST_SENDER_BOUNCED ;
					$title = _ACA_SENDER_BOUNCE;
					echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
				?>
				</span>
			</td>
			<td>
				<input type="text" name="frombounce" class="inputbox" size="20" maxlength="64" value="<?php echo $mailingEdit->frombounce; ?>" />
			</td>
		</tr>
		<tr>
			<td width="185" class="key">
				<span class="editlinktip">
				<?php
					$tip = _ACA_INFO_LIST_ACA_OWNER ;
					$title = _ACA_OWNER;
					echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
				?>
				</span>
			</td>
			<td>
				<?php echo $mailingEdit->author_id; ?>
			</td>
		</tr>
		</tbody>
	</table>
	</fieldset>
	<?php
	 }

	}


	function layout($mailingEdit, $lists, $show) {

		if (ACA_CMSTYPE) $editor =& JFactory::getEditor();
		if(!empty($_SESSION['skip_subscribers'.$mailingEdit->id])){
			echo 'If you click on the Send button, the process will skip the first '.$_SESSION['skip_subscribers'.$mailingEdit->id].' subscribers';
		}
	?>
	<fieldset class="acajoomcss">
	<legend><?php echo @constant( $GLOBALS[ACA.'listname'.$mailingEdit->list_type] ).' '. _ACA_CONTENT ; ?></legend>
	<table class="acajoomtable" cellspacing="1" width="99%">
		<tbody>
		<tr>
			<td valign="top">
		<?php
		mailingsHTML::subject($mailingEdit, $lists, $show);
		 if ($show['htmlcontent']) {
			 if ($mailingEdit->html !=0) {
				if (ACA_CMSTYPE) {
					echo $editor->display( 'content',  $mailingEdit->htmlcontent , '100%', '400', '80', '30' ) ;
				} else {
					editorArea( 'editor2',  $mailingEdit->htmlcontent , 'content', '100%;', '400', '80', '30' ) ;
				}
			 } else {
				 echo '<textarea name="content" rows="20" cols="75">' . $mailingEdit->htmlcontent . '</textarea>';
			 }
		}
		 ?>
			</td>
			<td valign="top" width="450px">
			<?php
			if ( ACA_CMSTYPE ) {
				 $config_tabs = new mosTabs15(0);
			} else {
				 $config_tabs = new mosTabs(0);
			}//endif

			$config_tabs->startPane('acaMailingOptions');

			$config_tabs->startTab(_ACA_LIST_T_GENERAL, 'acaMailingOptions.general');
			mailingsHTML::description($mailingEdit, $lists, $show);
			$config_tabs->endTab();

			$config_tabs->startTab(_ACA_LIST_OPT_TAG, 'acaMailingOptions.options');
			echo '<div style"width:280px;"><span class="editlinktip">';
			$tip = _ACA_INFO_MAILING_CONTENT;
			$title = _ACA_CONTENT;
			echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
			echo '</span><br /><strong>'._ACA_USABLE_TAGS.'</strong><br />';

			echo _ACA_NAMEREP.'<br />'. _ACA_FIRST_NAME_REP;
			if ( $mailingEdit->list_type==7 ) {
				echo '<br />'._ACA_TAGS_AUTONEWS;
			}
			if ( class_exists('auto') ) {
				echo '<br />'._ACA_TAGS_ISSUE_NB. '<br />';
				echo '<br />'._ACA_TAGS_DATE. '<br />';
			}
			if ( class_exists('aca_tags') ) {
				echo '<br />'._ACA_TAGS_CB. '<br />';
			}



			echo '</div>';


			$config_tabs->endTab();
				if (!ACA_CMSTYPE){
					$config_tabs->startTab(_ACA_LIST_OPT_IMG, 'acaMailingOptions.joom15');
					mailingsHTML::images($lists);
					$config_tabs->endTab();
				}

			 if ($show['sitecontent']) {
				$config_tabs->startTab(_ACA_LIST_OPT_CTT, 'acaMailingOptions.content');

				echo  _ACA_CONTENT_ITEM_SELECT_T;
				//echo _ACA_INSERT_CONTENT.'<br />';

				if (ACA_CMSTYPE) {
					global $mainframe;
					JPluginHelper::importPlugin( 'acajoom' );
					$bot_results = $mainframe->triggerEvent( 'acajoombot_editabs' );
				} else {
					global $_MAMBOTS;
					 $_MAMBOTS->loadBotGroup('acajoom');
					 $bot_results = $_MAMBOTS->trigger('acajoombot_editabs');
				}

				 if (!empty($bot_results)) {
					 foreach($bot_results as $bot_result) {
						 echo $bot_result[1];
					 }
				 }
				$config_tabs->endTab();
			}

			if ($GLOBALS[ACA.'show_jcalpro'] and class_exists('pro')) {
				$config_tabs->startTab(_ACA_SHOW_JCALPRO, 'acaMailingOptions.jcalpro');
				mailingsHTML::jcalpro();
				$config_tabs->endTab();
			}

			if ($show['attachement']) {
				$config_tabs->startTab(_ACA_ATTACHMENTS, 'acaMailingOptions.attachement');
				mailingsHTML::attachement($mailingEdit, $lists, $show);
				$config_tabs->endTab();
			}

			$config_tabs->endPane();
			?>
			</td>
		</tr>


	<?php if (($show['textcontent']) AND ($mailingEdit->html)) {?>
		<tr>
			<td>
				<textarea name="alt_content" rows="20" cols="70" style="width: 100%; height: 400px;"><?php echo $mailingEdit->textonly ; ?></textarea>
			</td>
			<td class="key" style="vertical-align: top;">
				<span class="editlinktip">
				<?php
					$tip = _ACA_INFO_MAILING_NOHTML;
					$title = _ACA_NONHTML;
					echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
				?>
				</span><br />
				<strong><?php echo _ACA_USABLE_TAGS; ?></strong><br />
				<?php
				echo _ACA_NAMEREP.'<br />'. _ACA_FIRST_NAME_REP;

				if ( $mailingEdit->list_type==7 ) {
					echo '<br />'._ACA_TAGS_AUTONEWS;
				}

				 ?>

			</td>
		</tr>
	<?php } ?>
		</tbody>
	</table>
	</fieldset>
	<?php
	}



	function attachement($mailingEdit, $lists, $show) {
		foreach($mailingEdit->attachments as $attach => $k){
			$mailingEdit->attachments[$attach] = basename($k);
		}

		if ( ACA_CMSTYPE ) {	// joomla 15
			$path = ACA_JPATH_ROOT_NO_ADMIN . $GLOBALS[ACA.'upload_url'];

			$arr = array(null);
			// Get the files and folders
			jimport('joomla.filesystem.folder');
			$files2		= JFolder::files($path, '.', true, true);
			$folders	= JFolder::folders($path, '.', true, true);
			// Merge files and folders into one array
			$files = array_merge($files2, $folders);
			// Sort them all
			asort($files);

		} else {									//joomla 1x
			$files = mosReadDirectory(ACA_JPATH_ROOT_NO_ADMIN . $GLOBALS[ACA.'upload_url'] , '\.', true, true);
		}//endif

		echo '<select name="attachments[]" multiple="multiple" style="width: 100%;" size="10">';
		if(sizeof($files) > 0) {
			 foreach ($files as $file) {
				 $file = basename($file);
				 if(in_array($file, $mailingEdit->attachments)) {
					 echo '<option selected="selected">' . $file . '</option>' . "\n";
				 } else {
					 echo '<option>' . $file . '</option>' . "\n";
				 }
			 }
		}
		echo '</select>';


?>
<script src="<?php echo ACA_JPATH_LIVE; ?>/administrator/components/com_acajoom/classes/multifile.js"></script>

<input id="my_file_element" type="file" name="file_1" >
</input>

<br /><b><?php echo _ACA_FILES ; ?>:</b>

<div id="files_list"></div>
<script>

	var multi_selector = new MultiSelector( document.getElementById( 'files_list' ), 10 );
	multi_selector.addElement( document.getElementById( 'my_file_element' ) );
</script>

<?php

	}


	 function images($lists) {

		if(ACA_CMSTYPE){
			return '';
		}
	?>
				<table class="adminform" width="100%">
				<tr>
					<th colspan="2">
						MOSImage Control
					</th>
				</tr>
				<tr>
					<td colspan="2">
						<table width="100%">
						<tr>
							<td width="48%" valign="top">
								<div align="center">
									Gallery Images:
									<br />
									<?php echo $lists['imagefiles'];?>
								</div>
							</td>
							<td width="2%">
								<input class="button" type="button" value=">>" onclick="addSelectedToList(selectFormFB(),'imagefiles','imagelist')" title="Add" />
								<br />
								<input class="button" type="button" value="<<" onclick="delSelectedFromList(selectFormFB(),'imagelist')" title="Remove" />
							</td>
							<td width="48%">
								<div align="center">
									Content Images:
									<br />
									<?php echo $lists['imagelist'];?>
									<br />
									<input class="button" type="button" value="Up" onclick="moveInList(selectFormFB(),'imagelist',selectFB('imagelist.selectedIndex'),-1)" />
									<input class="button" type="button" value="Down" onclick="moveInList(selectFormFB(),'imagelist',selectFB('imagelist.selectedIndex'),+1)" />
								</div>
							</td>
						</tr>
						</table>
						Sub-folder: <?php echo $lists['folders'];?>
					</td>
				</tr>
				<tr valign="top">
					<td>
						<div align="center">
							Sample Image:<br />
							<img name="view_imagefiles" src="../images/M_images/blank.png" alt="Sample Image" width="100" />
						</div>
					</td>
					<td valign="top">
						<div align="center">
							Active Image:<br />
							<img name="view_imagelist" src="../images/M_images/blank.png" alt="Active Image" width="100" />
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						Edit the image selected:
						<table>
						<tr>
							<td align="right">
							Source:
							</td>
							<td>
							<input class="text_area" type="text" name= "_source" value="" />
							</td>
						</tr>
						<tr>
							<td align="right">
							Image Align:
							</td>
							<td>
							<?php echo $lists['_align']; ?>
							</td>
						</tr>
						<tr>
							<td align="right">
							Alt Text:
							</td>
							<td>
							<input class="text_area" type="text" name="_alt" value="" />
							</td>
						</tr>
						<tr>
							<td align="right">
							Border:
							</td>
							<td>
							<input class="text_area" type="text" name="_border" value="" size="3" maxlength="1" />
							</td>
						</tr>
						<tr>
							<td align="right">
							Caption:
							</td>
							<td>
							<input class="text_area" type="text" name="_caption" value="" size="30" />
							</td>
						</tr>
						<tr>
							<td align="right">
							Caption Position:
							</td>
							<td>
							<?php echo $lists['_caption_position']; ?>
							</td>
						</tr>
						<tr>
							<td align="right">
							Caption Align:
							</td>
							<td>
							<?php echo $lists['_caption_align']; ?>
							</td>
						</tr>
						<tr>
							<td align="right">
							Caption Width:
							</td>
							<td>
							<input class="text_area" type="text" name="_width" value="" size="5" maxlength="5" />
							</td>
						</tr>
						<tr>
							<td colspan="2">
							<input class="button" type="button" value="Apply" onclick="applyImageProps()" />
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
	<?php
	}


	 function viewMailing($mailing, $forms) {

	echo $forms['main'];
	?>
	<table width="100%" cellpadding="4" cellspacing="0" border="0" align="left" class="adminlist">
		<tr>
			<th width="100px" align="left">
				<strong><?php echo _ACA_SUBJECT; ?>:</strong>
			</th>
			<th align="left">
				<?php echo $mailing->subject; ?>
			</th>
		</tr>
		<tr>
			<th align="left">
				<strong><?php echo _ACA_LIST_DATE; ?>:</strong>
			</th>
			<th align="left">
				<?php echo $mailing->send_date; ?>
			</th>
		</tr>
		<tr>
			<th align="left">
				<strong><?php echo _ACA_LIST_ISSUE; ?>:</strong>
			</th>
			<th  align="left">
				<?php echo $mailing->issue_nb; ?>
			</th>
		</tr>

		<tr>
			<th width="100%" align="left" colspan="2">
				<strong><?php echo _ACA_CONTENT; ?>:</strong>
			</th>
		</tr>
		<tr>
			<td  align="left" colspan="2">
				<?php echo $mailing->htmlcontent; ?>
			</td>
		</tr>

		<?php if(!empty($mailing->attachments)) { ?>
		<tr>
			<th align="left" valign="top">
				<strong><?php echo _ACA_ATTACHED_FILES; ?>:</strong>
			</th>
			<td align="left">
				<?php
				foreach ($mailing->attachments as $file) {
					echo '<a href="'.ACA_JPATH_LIVE.$GLOBALS[ACA.'upload_url'].DS.basename($file).'" target="_blank">'.basename($file).'</a><br />';
				}
				?>
			</td>
		</tr>
		<?php } ?>
	</table>
	<?php

	}

	function jcalpro(){
		if ( ACA_CMSTYPE ) {
			$database =& JFactory::getDBO();
		} else {
			global $database ;
		}//endif


		$tip =  _ACA_JCALTAGS_DESC_TIPS;
		$title =  _ACA_JCALTAGS_DESC ;
		$desc = "<span class=\"editlinktip\">" . compa::toolTip( $tip, '', 280, 'tooltip.png', $title, '', 0 ) . "</span>";
		$tip =  _ACA_JCALTAGS_START_TIPS;
		$title =  _ACA_JCALTAGS_START ;
		$start = "<span class=\"editlinktip\">" . compa::toolTip( $tip, '', 280, 'tooltip.png', $title, '', 0 ) . "</span>";
		$tip =  _ACA_JCALTAGS_READMORE_TIPS;
		$title =  _ACA_JCALTAGS_READMORE ;
		$read = "<span class=\"editlinktip\">" . compa::toolTip( $tip, '', 280, 'tooltip.png', $title, '', 0 ) . "</span>";

		 $query = "SELECT `cat_id`,`cat_name` FROM #__jcalpro_categories";
		 $database->setQuery($query);
		 $jcalcats = $database->loadObjectList();

		$events = array();
		$year = intval(date('Y'));
		 if(!empty($jcalcats)){
		 	foreach($jcalcats as $jcalcat){
				 $query = "SELECT `extid`, `title` ,`start_date` FROM #__jcalpro_events where `cat` = ".$jcalcat->cat_id." AND (`start_date` >= '".$year."' OR `end_date` >= '".$year."' ) ORDER BY `start_date` DESC";
				 $database->setQuery($query);
				 $events[$jcalcat->cat_id] = $database->loadObjectList();
			}
		 }

?>
<script type="text/javascript">
<!--

var events = new Array;

<?php
if(!empty($events)){
	$i = 0;
	foreach($events as $cat => $eventcat){
		if(!empty($eventcat)){
			foreach ($eventcat as $event){
				echo 'events['.$i.'] = new Array(\''.$cat.'\',\''.$event->extid.'\',\''.addslashes($event->title).' ('.$event->start_date.')\');'."\n";
				$i++;
			}
		}
	}
}
?>
var formname = 'adminForm';
if(!document.adminForm){
	formname = 'mosForm';
}

function updatejCalCat(){

	var catid = eval('document.'+formname+'.jcal_cat.value');
	var list = eval( 'document.'+formname+'.jcal_event');

	var i = 0;
	// empty the list
	for (i in list.options.length) {
		list.options[i] = null;
	}
	i = 0;
	for (a in events) {
		if (events[a][0] == catid) {
			opt = new Option();
			opt.value = events[a][1];
			opt.text = events[a][2];
			list.options[i++] = opt;
		}
	}
	list.length = i;

}

function updatejCaltag(){
	var eventid = eval('document.'+formname+'.jcal_event.value');
	var start = eval('document.'+formname+'.jcal_start');
	var desc = eval('document.'+formname+'.jcal_desc');
	var read = eval('document.'+formname+'.jcal_read');
	var tag = eval('document.'+formname+'.jcal_tag');

	for (i=0;i<start.length;i++) {
        if (start[i].checked) {
             var start_value = start[i].value;
        }
    }
	for (i=0;i<desc.length;i++) {
        if (desc[i].checked) {
             var desc_value = desc[i].value;
        }
    }
	for (i=0;i<read.length;i++) {
        if (read[i].checked) {
             var read_value = read[i].value;
        }
    }

	tag.value = "{jcalevent:" + eventid + "|" + start_value + "|" + desc_value + "|" + read_value + "}";
}
//-->
</script>

		<table class="acajoomcss_bots" width="100%">
			<tr>
				<td style="vertical-align: top;" colspan="2">
				<?php
					$tip = _ACA_JCALTAGS_TITLE_TIPS;
					$title = _ACA_JCALTAGS_TITLE;
					echo compa::toolTip( $tip, '', 280, 'tooltip.png',  $title, '', 0 );
				?>
					<input class="inputbox" type="text" onfocus="this.select();" size="20" name="jcal_tag"/>
				</td>
			</tr>
			<tr>
				<td>
					<?php echo $start ?>
				</td>
				<td>
	                <input type="radio" name="jcal_start" value="0" onclick="updatejCaltag();" />
	                <img src="<?php echo ACA_JPATH_LIVE; ?>/administrator/images/publish_x.png" width="12" height="12" border="0" alt="No" />
	                <input type="radio" name="jcal_start" value="1" checked="checked" onclick="updatejCaltag();" />
	                <img src="<?php echo ACA_JPATH_LIVE; ?>/administrator/images/tick.png" width="12" height="12" border="0" alt="Yes" />
	             </td>
			</tr>
			<tr>
				<td>
					<?php echo $desc ?>
				</td>
				<td>
					<input type="radio" name="jcal_desc" value="0"  onclick="updatejCaltag();" />
	                <img src="<?php echo ACA_JPATH_LIVE; ?>/administrator/images/publish_x.png" width="12" height="12" border="0" alt="No" />
	                <input type="radio" name="jcal_desc" value="1"  checked="checked" onclick="updatejCaltag();" />
	                <img src="<?php echo ACA_JPATH_LIVE; ?>/administrator/images/tick.png" width="12" height="12" border="0" alt="Yes" />
				</td>
			</tr>
			<tr>
				<td>
					<?php echo $read ?>
				</td>
				<td>
					<input type="radio" name="jcal_read" value="0" onclick="updatejCaltag();" />
	                <img src="<?php echo ACA_JPATH_LIVE; ?>/administrator/images/publish_x.png" width="12" height="12" border="0" alt="No" />
	                <input type="radio" name="jcal_read" value="1" checked="checked" onclick="updatejCaltag();" />
	                <img src="<?php echo ACA_JPATH_LIVE; ?>/administrator/images/tick.png" width="12" height="12" border="0" alt="Yes" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
<?php
	 	echo '<select class="inputbox" onchange="updatejCalCat();" size="1" name="jcal_cat">';
		 if(!empty($jcalcats)){
		 	foreach($jcalcats as $jcalcat){
				echo '<option value="'.$jcalcat->cat_id.'">'.$jcalcat->cat_name.'</option>';
		 	}
		 }

		echo '</select>';
?>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<select name="jcal_event" class="inputbox" size="30" onchange="updatejCaltag();">
					<?php
					if(!empty($jcalcats)){
						 if(!empty($events[$jcalcats[0]->cat_id])) {
							 foreach ($events[$jcalcats[0]->cat_id] AS $event) {
								 echo '<option value="' . $event->extid . '">' . $event->title.' ('.$event->start_date.') </option>' . "\n";
							 }
						 }
 					}
					?>
					</select>
				</td>
			</tr>
		</table>
<?php
	}



	function ReadImages( $imagePath, $folderPath, &$folders, &$images )
	{

		jimport( 'joomla.filesystem.folder' );
		$imgFiles = JFolder::files( $imagePath );

		if ( !empty($imgFiles) ) {
			foreach ($imgFiles as $file)
			{
				$ff_ 	= $folderPath.DS.$file;
				$ff 	= $folderPath.DS.$file;
				$i_f 	= $imagePath .'/'. $file;

				if ( is_dir( $i_f ) && $file <> 'CVS' && $file <> '.svn') {
					$folders[] = JHTML::_('select.option',  $ff_ );
					mailingsHTML::ReadImages( $i_f, $ff_, $folders, $images );
				} else if ( eregi( "bmp|gif|jpg|png", $file ) && is_file( $i_f ) ) {
					// leading / we don't need
					$imageFile = substr( $ff, 1 );
					$images[$folderPath][] = JHTML::_('select.option',  $imageFile, $file );
				}
			}
		}//endif

	}



 }
