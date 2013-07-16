<?php 
/*
MediQnA v1.1 : EditQSetProc.php
Updates a question set

Original code (c) Famous Websites 2008
Latest Update: 10-December-2008
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );
$sql;
//====----
//If it's just a power switch (on/off) we should 
//handle that first

if($pwr){
	//Check it
	if($pwr == "u"){
		$sql = "UPDATE qna_QuestionSets SET Status='on' WHERE RecID = ".$id;
	}else if($pwr == "d"){
		$sql = "UPDATE qna_QuestionSets SET Status='off' WHERE RecID = ".$id;
	}else{
		Dropout("Medi-QnA Error: 101, Had to stop!","index.php?option=com_mediqna");
	}
}else{
	//Make sure the fields are okay
	if(!preg_match("/on|off/",$_POST['Status'])){
		Dropout("Had to stop!","index.php?option=com_mediqna&task=EditQSetPrep&id=".$id);
	}else if(empty($_POST['SetName']) || empty($_POST['SetDesc'])){
		Dropout("You need to enter something for the set name AND a description!","index.php?option=com_mediqna&task=EditQSetPrep&id=".$id);
	}else if(!preg_match("/yes|no/",$RemQSet)){
		Dropout("Had to stop!","index.php?option=com_mediqna&task=EditQSetPrep&id=".$id);
	}

	$sql = "UPDATE qna_QuestionSets SET SetName='".$_POST['SetName']."',SetDesc='".$_POST['SetDesc']."',Status='".$_POST['Status']."' WHERE RecID = ".$id;
}
//====----
$dbh =& JFactory::getDBO();	

if($RemQSet == "yes"){
	$sql = "DELETE FROM qna_Questions WHERE AssignedSet = ".$id;
	$dbh->setQuery($sql);
	$dbh->query();
	
	$sql = "DELETE FROM qna_QuestionSets WHERE RecID = ".$id;
}

$dbh->setQuery($sql);
$dbh->query();
//====----
//Send user back to the display list
include(JPATH_COMPONENT.DS.'DisplayQSetsList.php')
?>