<?php 
/*
MediQnA v1.1 : AddQSet.php
Adds a question set

Original code (c) Famous Websites 2008
Latest Update: 10-December-2008
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );
//====----
//Make sure the fields are okay
if(empty($_POST['SetName']) || empty($_POST['SetDesc'])){
	Dropout("Medi-QnA Error: 201, Please enter some text in the Name and Description fields","index.php?option=com_mediqna&act=newset");
}else{
	if(($Msg = TamperCheck($_POST['SetName'])) != "ok" || ($Msg = TamperCheck($_POST['SetDesc'])) != "ok"){
		Dropout($Msg,"index.php?option=com_mediqna");
	}
}
//====----
$dbh =& JFactory::getDBO();	
$sql = "INSERT INTO qna_QuestionSets (SetName,SetDesc,Status,DateAdded)VALUES('".$_POST['SetName']."','".$_POST['SetDesc']."','off','".date("d-m-Y")."')";
$dbh->setQuery($sql);
$dbh->query();
//====----
//Send user back to the display list
include(JPATH_COMPONENT.DS.'DisplayQSetsList.php')
?>