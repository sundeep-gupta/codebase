<?php 
/*
MediQnA v1.1 : Question_proc.php
Adds a question to a set
Updates a question with edits
Removes a question from a set

Original code (c) Famous Websites 2008
Latest Update: 10-December-2008
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );
//====----
//Make sure the fields are okay
//RecID's are checked by the admin.mediqna.php
if($task == "AddQProc" || $task == "UDQProc"){
	$ThisRedir = "EditQPrep";
	if($task == "AddQProc"){
		$ThisRedir = "AddQPrep";
	}
	if(empty($_POST['Question']) || empty($_POST['Answer']) || empty($_POST['QAlias'])){
		Dropout("Medi-QnA Error: 003, Please enter some text in the Title, Question and Answer fields","index.php?option=com_mediqna");
	}else{
		if(($Msg = TamperCheck($_POST['Answer'])) != "ok" || ($Msg = TamperCheck($_POST['Question'])) != "ok" || ($Msg = TamperCheck($_POST['QAlias'])) != "ok"){
			Dropout($Msg,"index.php?option=com_mediqna");
		}
	}
}
//====----
$SQL;

if($task == "AddQProc"){
	$SQL = "INSERT INTO qna_Questions (Status,DateAdded,Question,Answer,AssignedSet,QAlias)VALUES('on','".date("d-m-Y")."','".$_POST['Question']."','".$_POST['Answer']."','".$id."','".$_POST['QAlias']."')";
}else if($task == "UDQProc"){
	CheckInboundNum($qid);
	if(!preg_match("/yes|no/",$RemQOpt)){
		Dropout("Medi-QnA Error: 001, Had to stop!","index.php?option=com_mediqna");
	}
	//====----
	if($RemQOpt == "yes"){
		$SQL = "DELETE FROM qna_Questions WHERE RecID = ".$qid;
	}else{
		$SQL = "UPDATE qna_Questions SET Question = '".$_POST['Question']."',Answer = '".$_POST['Answer']."',QAlias = '".$_POST['QAlias']."',Status = '".$_POST['Status']."' WHERE RecID = ".$qid;
	}
}else if($task == "SwitchQ"){
	//$pwr is the quick on-off setting
	if(!preg_match("/u|d/",$pwr)){
		Dropout("Medi-QnA Error: 002, Had to stop!","index.php?option=com_mediqna");
	}
	//====----
	if($pwr == "u"){
		$SQL = "UPDATE qna_Questions SET Status = 'on' WHERE RecID = ".$qid;
	}else if($pwr == "d"){
		$SQL = "UPDATE qna_Questions SET Status = 'off' WHERE RecID = ".$qid;
	}
}

$dbh =& JFactory::getDBO();	
$dbh->setQuery($SQL);
$dbh->query();
//====----
//If the quesetion was deleted or its status set to off
//we need to make sure the question set has at least two
//questions available for publication, if NOT we should
//set the set status to off

$SQL = "SELECT count(RecID) as Foundlings FROM qna_Questions WHERE AssignedSet LIKE '".$id."' AND Status LIKE 'on'";
$dbh->setQuery($SQL);
$Rtn = $dbh->loadObjectList();

if($Rtn[0]->Foundlings < 2){
	$SQL = "UPDATE qna_QuestionSets SET Status ='off' WHERE RecID = ".$id;
	$dbh->setQuery($SQL);
	$dbh->query();
}

//Where next
include(JPATH_COMPONENT.DS.'DisplayQSetsList.php');
?>