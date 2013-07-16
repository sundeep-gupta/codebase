<?php
/*
MediQnA v1.1
Question and answer system for medical websites
Original code (c) Famous Websites 2008
Latest Update: 09-December-2008
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );
jimport('joomla.application.component.controller');
//====----
$task 		= JRequest::getCmd('task');
$action		= JRequest::getCmd('act');

//$id used for the question set number
$id			= JRequest::getCmd('id');
$qid		= JRequest::getCmd('qid');
$pwr		= JRequest::getCmd('pwr');
$PwrOpt		= JRequest::getCmd('PwrOpt');
$RemQOpt	= JRequest::getCmd('RemQOpt');
$RemQSet	= JRequest::getCmd('RemQSet');
$MyIconsPath = JURI::base()."components".DS."com_mediqna".DS."graphics".DS;
//====----
if($action == "newset"){
	if($task == "MediQnAAddSet"){
		include(JPATH_COMPONENT.DS.'models'.DS.'AddQSet.php');
	}else{
		include(JPATH_COMPONENT.DS.'AddNewQSet.php');
	}
}else{
	if($task){
		CheckInboundNum($id);
		if($task == "AddQPrep"){
			//Show the new question form
			CheckInboundNum($id);
			include(JPATH_COMPONENT.DS.'AddQPrep.php');
		}else if($task == "AddQProc" || $task == "UDQProc" || $task == "SwitchQ"){	
			//Add the new question to the DB
			//Remove question from DB
			//Update a question on the DB
			CheckInboundNum($id);
			include(JPATH_COMPONENT.DS.'models'.DS.'Question_proc.php');
			
		}else if($task == "EditQPrep"){
			CheckInboundNum($qid);
			include(JPATH_COMPONENT.DS.'EditQPrep.php');
			
		}else if($task == "ViewQList"){
			OPQList($id,$MyIconsPath);
			
		}else if($task == "EditQSetPrep"){
			include(JPATH_COMPONENT.DS.'EditQSetPrep.php');
			
		}else if($task == "EditQSetProc"){
			include(JPATH_COMPONENT.DS.'models'.DS.'EditQSetProc.php');	
		}
	}else{
		//Just list the sets
		include(JPATH_COMPONENT.DS.'DisplayQSetsList.php');
	}
}
//====----
function CheckInboundNum($ParsedIDVar){
	if(empty($ParsedIDVar) || !is_numeric($ParsedIDVar) || $ParsedIDVar < 1){
		Dropout("Medi-QnA Error: 801, Sorry, I need a record number to edit!","index.php?option=com_mediqna");
	}
}
//CheckVars just looks for tampering
function TamperCheck($ThisVar){
	$Msg = "ok";
	if(preg_match("/delete.*FROM|insert.*INTO|update.*WHERE|@|¬|\{|\}|\[|\]|\|/",$ThisVar)){
		$Msg = "Medi-QnA Error: 901, You entered some characters that are not allowd!<br>Please enter only Alpha or Numeric keyboard characters.";
	}
	return $Msg;
}

//====----
//Show question list, maybe?
function OPQList($id,$MyIconsPath){
	$dbh =& JFactory::getDBO();
	//Get the set name...
	$sql = "SELECT SetName FROM qna_QuestionSets WHERE RecID = '".$id."'";
	$dbh->setQuery($sql);
	$SetName = $dbh->loadObjectList();

	$sql = "SELECT * FROM qna_Questions WHERE AssignedSet = '".$id."' ORDER BY RecID DESC";
	$dbh->setQuery($sql);
	
	if (!$result = $dbh->query()) {
			Dropout($dbh->stderr(),"index.php");
	}else{
		$rows = $dbh->loadObjectList();
	
		if(empty($rows[0]) ){
			//There's no list to show, just take the 
			//user to the add a question form
			include(JPATH_COMPONENT.DS.'AddQPrep.php');
		}else{
			include(JPATH_COMPONENT.DS.'DisplayQList.php');
		}
	}
}

function Dropout($Msg,$LoCal){
	$controller = new JController();
	$controller->setRedirect($LoCal,$Msg,"error");
	$controller->redirect();
	exit(0);
}
?>