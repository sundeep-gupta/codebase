<?php
defined('_JEXEC') OR defined('_VALID_MOS') OR die('...Direct Access to this location is not allowed...');
/**
* @copyright Copyright (C) 2009 Joobi Limited All rights reserved.
* @license This file is released under the GPL license (http://www.gnu.org/licenses )
* @link http://www.ijoobi.com
*/

 function lists( $action, $task, $listId, $listType ) {

	if ( ACA_CMSTYPE ) {	// joomla 15
		$database =& JFactory::getDBO();
		$my	=& JFactory::getUser();
	} else {									//joomla 1x
	    global $my, $database;
	}//endif

	$message ='' ;
	$xf = new xonfig();
	$erro = new xerr( __FILE__ , __FUNCTION__ );
	$erro->show();

	$showLists = true;
	switch ($task) {

		case ('new') :
		case ('add') :
			if ($listType<1) $listType=1;
			$filename = ACA_JPATH_ROOT. '/components/com_acajoom/templates/default/default.html';
			$handle = fopen($filename, "rb");
			$template = fread($handle, filesize($filename));
			fclose($handle);

			$template = str_replace('src="', 'src="'.ACA_JPATH_LIVE.'/', $template);
			$subscriber = subscribers::getSubscriberInfoFromUserId($my->id);
			$showLists = false;
			$newList->id = '';
			$newList->html = 1;
			$newList->new_letter = 1;
			$newList->list_name = '';
			$newList->list_desc = '';
			$newList->sendername = $subscriber->name;
			$newList->senderemail = $subscriber->email;
			$newList->bounceadres = $subscriber->email;
			$newList->layout = $template;
			$newList->template = 0;
			$newList->hidden = 1;
			$newList->auto_add = 0;
			$newList->list_type = $listType;
			$newList->delay_min = 1;
			$newList->delay_max = 7;
			$newList->user_choose = 0;
			$newList->cat_id = '0:0';
			$newList->follow_up ='';
			$newList->notify_id =0;
			$newList->owner = $my->id;
			$newList->acc_level = 25;
			$newList->acc_id = 29;
			$newList->published = 0;
			$newList->start_date = date( 'Y-m-d',  time() );
			$newList->next_date = time();
			$newList->subscribemessage = _ACA_DEFAULT_SUBSCRIBE_MESS;
			$newList->unsubscribemessage =  _ACA_DEFAULT_UNSUBSCRIBE_MESS;
			$newList->unsubscribesend = 1;
			$newList->footer = 1;
		    $forms['main'] = " <form action='index2.php' method='post' name='adminForm'> \n " ;
			$show = lisType::showType($newList->list_type , 'editlist');
         	backHTML::_header( _ACA_NEW.' '._ACA_LIST , $GLOBALS[ACA.'listlogo0'] , $message , $task, $action  );
			backHTML::formStart('listedit', $newList->html, '' );
       		listsHTML::editList($newList, $forms, $show);
			$go[] = acajoom::makeObj('act', $action);
			$go[] = acajoom::makeObj('listid', $newList->id);
			backHTML::formEnd($go);
			break;

		case ('doNew') :
			if ( ACA_CMSTYPE ) {	// joomla 15
				$listname = JRequest::getVar('list_name', '');
				$listType = intval(JRequest::getVar('list_type', 0));
			} else {									//joomla 1x
				$listname = mosGetParam($_REQUEST, 'list_name', '');
				$listType = intval(mosGetParam($_REQUEST, 'list_type', 0));
			}//endif

			$now = acajoom::getNow();
   			$query = "SELECT `id` FROM `#__acajoom_lists` WHERE `list_name`= '".addslashes($listname)."' ";
	     	$database->setQuery($query);
			$lId = $database->loadResult();
   			$erro->err = $database->getErrorMsg();
   			$erro->E(__LINE__ ,  '1091' , $database);
			if ($lId>0) {
				echo "<script> alert(' This list already exist, please choose another name. '); window.history.go(-1);</script>\n";
				return false;
			} else {
				$query = "INSERT INTO `#__acajoom_lists` (`list_name`,`createdate`) VALUES ( '".addslashes($listname)."'  , '$now' )" ;
				$database->setQuery($query);
				$database->query();
				$erro->err = $database->getErrorMsg();
			}
			if ($erro->E(__LINE__ ,  '1001' , $database)) {

	   			//$query = "SELECT * FROM `#__acajoom_lists` WHERE `list_name`= '$listname' ";
	   			$query = "SELECT * FROM `#__acajoom_lists` WHERE `list_name`= '".addslashes($listname)."' ";
		     	$database->setQuery($query);

					if ( ACA_CMSTYPE ) {	// joomla 15
						$mynewlist = $database->loadObject();
					} else {									//joomla 1x
						$database->loadObject($mynewlist);
					}//endif

				$mynewlist->list_name = stripslashes($mynewlist->list_name);
				$mynewlist->list_desc = stripslashes($mynewlist->list_desc);
				$mynewlist->layout = stripslashes($mynewlist->layout);
				$mynewlist->subscribemessage = stripslashes($mynewlist->subscribemessage);
				$mynewlist->unsubscribemessage = stripslashes($mynewlist->unsubscribemessage);

	   			$erro->err = $database->getErrorMsg();
				$erro->E(__LINE__ ,  '1005' );
		     	$listId = $mynewlist->id;
		     	$message = acajoom::printYN( lists::updateListFromEdit($listId, '', true) ,  _ACA_LIST_ADDED , _ACA_ERROR );
				$xf->plus('totallist0', 1);
				$xf->plus('act_totallist0', 1);
				$xf->plus('totallist'. $listType , 1);
				$xf->plus('act_totallist'. $listType , 1);
			}
			break;

		case ('edit') :

			if ($listId == 0) {
				echo "<script> alert('".addslashes(_ACA_SELECT_LIST)."'); window.history.go(-1);</script>\n";
				return false;
			} else {
				$showLists = false;

				$query = 'SELECT * FROM `#__acajoom_lists` WHERE `id` = ' . intval($listId);
				$database->setQuery($query);
				if ( ACA_CMSTYPE ) {	// joomla 15
					$listEdit = $database->loadObject();
				} else {									//joomla 1x
					$database->loadObject( $listEdit );
				}//endif

				$erro->err = $database->getErrorMsg();
				if (!$erro->E(__LINE__ ,  '1002' )) {
					return false;
				} else {
					$listEdit->list_name = stripslashes($listEdit->list_name);
					$listEdit->list_desc = stripslashes($listEdit->list_desc);
					$listEdit->layout = stripslashes($listEdit->layout);
					$listEdit->subscribemessage = stripslashes($listEdit->subscribemessage);
					$listEdit->unsubscribemessage = stripslashes($listEdit->unsubscribemessage);

	         		$listEdit->new_letter = 0;
				    $forms['main'] = " <form action='index2.php' method='post' name='adminForm'> \n " ;
					$show = lisType::showType($listEdit->list_type , 'editlist');
		         	backHTML::_header( _ACA_EDIT_A. @constant( $GLOBALS[ACA.'listname'.$listEdit->list_type] ).' '._ACA_LIST , $GLOBALS[ACA.'listlogo0'] , $message , $task, $action );
					backHTML::formStart('listedit', $listEdit->html, '' );
		       		listsHTML::editList($listEdit, $forms, $show);
					$go[] = acajoom::makeObj('act', $action);
					$go[] = acajoom::makeObj('listid', $listEdit->id);
					backHTML::formEnd($go);
				}
			}
			break;

		case ('update') :
		     $message = acajoom::printYN( lists::updateListFromEdit($listId, '', false) ,  _ACA_LIST_UPDATED , _ACA_ERROR );
			break;

		case ('delete') :
           $message = acajoom::printYN( lists::deleteList($listId) ,  _ACA_LIST. _ACA_SUCCESS_DELETED , _ACA_ERROR );
			break;
	   	case ('copy') :
	         $message = acajoom::printYN( lists::copyList($listId) ,  _ACA_LIST_COPY , _ACA_ERROR );
			 break;
	   	case ('publish') :
	      $message = acajoom::printYN( lists::updateListFromList($listId, true, false) ,  _ACA_PUBLISHED , _ACA_ERROR );
			break;
	   	case ('unpublish') :
			$message = acajoom::printYN( lists::updateListFromList($listId, false, false) ,  _ACA_UNPUBLISHED , _ACA_ERROR );
			break;
		case ('forms') :
		case ('make') :
			if (class_exists('createForm')) {
				createForm::taskOptions($task);
				$showLists = false;
			} else {
				$showLists = true;
			}
			break;
	   	case ('cpanel') :
			backHTML::controlPanel();
			return true;
			break;
	}

	if ($showLists) {
   		backHTML::_header( _ACA_MENU_LIST , $GLOBALS[ACA.'listlogo0'] , $message , $task, $action );
   		$show = lisType::showType(0 , 'showListsBack');
		$forms['main'] = " <form action='index2.php' method='post' name='adminForm'> \n" ;
		backHTML::formStart('show_mailing' , ''  ,'' );
		$listing = lists::getLists(0, 0, 1, '', false, false, false);
		if ($show['list_type']) $show['list_type'] = lisType::checkOthers();
		listsHTML::showListingLists( $listing, $action , 'edit' , $forms, $show);
		$go[] = acajoom::makeObj('act', $action);
		backHTML::formEnd($go);
		return true;
	}
 }

