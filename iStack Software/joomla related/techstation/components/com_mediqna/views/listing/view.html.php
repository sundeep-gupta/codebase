<?php
/*
MediQnA v1.1
Question and answer system for medical websites
Original code (c) Famous Websites 2008
Latest Update: 09-12-2008
*/

// no direct access
defined('_JEXEC') or die('Restricted access');
jimport( 'joomla.application.component.view');

class MediQnAViewListing extends JView{
	var $MyFoundSets = array();
	//Get the list of availabel question sets
	function display($tpl = null){
		global $mainframe;
		//Make sure the cookies that run the
		//progress sequence are removed in case
		//this user has already viewed a set
		$mainframe->setUserState("mediqna.CurSetProg",'');
		$mainframe->setUserState("mediqna.AllQNums",'');
		$mainframe->setUserState("mediqna.CurSetID",'');
		$mainframe->setUserState("mediqna.CurSetName",'');
		$mainframe->setUserState("mediqna.CurSetDesc",'');
		//====----
		$dbh =& JFactory::getDBO();
		
		$dbh->setQuery("SELECT RecID,SetName,SetDesc FROM qna_QuestionSets WHERE Status LIKE 'on' ORDER BY RecID DESC");
		$QSets = $dbh->loadObjectList();
		
		foreach($QSets as $r=>$s){
			$dbh->setQuery("SELECT count(RecID) as NumQs FROM qna_Questions WHERE AssignedSet = '".$s->RecID."' AND Status LIKE 'on'");
			$ThisQ = $dbh->loadObjectList();
			
			if($ThisQ[0]->NumQs > 1){
				//This set meets our criteria, add it to the list
				foreach($ThisQ as $a=>$b){
					array_push($this->MyFoundSets,array('RecID'=>$s->RecID,'SetName'=>$s->SetName,'SetDesc'=>$s->SetDesc,'SetNumQs'=>$ThisQ[0]->NumQs));
				}
			}
		}
		parent::display($tpl);
	}
}
?>