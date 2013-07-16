<?php 
/*
MediQnA v1.1
Question and answer system for medical websites
Original code (c) Famous Websites 2008
Latest Update: 05-December-2008
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );

class GetThisQ{
	var $Question;
	var $Answer;
	
	function GetThisQ($DBHandle,$Qnum){
		$ThisQ = $DBHandle->setQuery("SELECT * FROM qna_Questions WHERE RecID = '".$Qnum."'");
		$ThisQ = $DBHandle->loadObjectList();
		$this->Question = $ThisQ[0]->Question;
		$this->Answer = $ThisQ[0]->Answer;
	}
}
?>