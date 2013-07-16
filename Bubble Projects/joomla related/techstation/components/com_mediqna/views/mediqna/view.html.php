<?php
/*
MediQnA v1.1
Question and answer system for medical websites
Original code (c) Famous Websites 2008, Use under GPL
Latest Update: 09-12-2008
*/

// no direct access
defined('_JEXEC') or die('Restricted access');
jimport( 'joomla.application.component.view');

class MediQnAViewMediQnA extends JView{

	function display($tpl = null){
		global $mainframe;
		$dbh =& JFactory::getDBO();
		
		$task 	= JRequest::getCmd('task');
		$sid	= JRequest::getCmd('sid');
		//====----
		//Are we on our way or is this the start of a new set?
		$CurSetProg = $mainframe->getUserState("mediqna.CurSetProg");
		
		if(empty($CurSetProg)){
			//This is a new set, initialise the set session
			$CurSetProg = 1;
			$mainframe->setUserState("mediqna.CurSetProg",$CurSetProg);
			
			require_once(JPATH_COMPONENT.DS.'models'.DS.'InitSetSesh.php');
			$CurSet = new InitSetSesh($sid,$dbh,$mainframe);
		}
			
		$MyQuestions = $mainframe->getUserState("mediqna.AllQNums");
		$TotalQs 	= count($MyQuestions)-2;
		
		if($task == "Next"){
			//User has clicked the next question button
			//Now wind the progress on by one count and set the cookie
			//If it's the last question stop counting progress
			
			if($CurSetProg < $TotalQs){
				$CurSetProg++;
			}else{
				//User has clicked next on the last number
				//re-set the set to Q1.
				$CurSetProg = 1;	
			}
				$mainframe->setUserState("mediqna.CurSetProg",$CurSetProg);
		}else if($task == "Prev"){
			//User wants to rewind...
			$CurSetProg--;
			$mainframe->setUserState("mediqna.CurSetProg",$CurSetProg);
			
		}
		//There's no final else 'cause we're not 
		//moving questions, just showing the answer
		
		//Configure progress and build the Nav Buts.
		//We only need to pass the $mainframe since
		//everything else comes from the cookies

		$this->NavButs 	= ConfProgress($mainframe,$task,$CurSetProg,$TotalQs);
		//====----
		$this->FoundSetID 	= $mainframe->getUserState("mediqna.CurSetID");
		$this->FoundSetName = $mainframe->getUserState("mediqna.CurSetName");
		$this->FoundSetDesc = $mainframe->getUserState("mediqna.CurSetDesc");

		require_once(JPATH_COMPONENT.DS.'models'.DS.'GetThisQ.php');
		//Load up the current question
		$CurQ = new GetThisQ($dbh,$MyQuestions[$CurSetProg]);
		$this->OPQ = $CurQ->Question;
		//====----
		$this->ProgressMsg = "Question ".$CurSetProg." of ".$TotalQs;
		
		if($task == "Answer"){
			//Show the answer
			$this->OPA = $CurQ->Answer;
		}
		
		//What if there are no questions yet published?
		if($TotalQs == -1){
			$this->setLayout( 'noqs' );	
		}
		parent::display($tpl);
	}
}//End Class

function ConfProgress($mainframe,$task,$CurSetProg,$TotalQs){
	//Sets up th nav bar for forward, current and next inks
	//makes sure the progress count is forwarded
	$HTMLFrags 				= array();
	$HTMLFrags['PrevHints'] = "Previous";
	$HTMLFrags['PrevLink'] 	= "index.php?option=com_mediqna&task=Prev";
	$HTMLFrags['NextHints'] = "Next";
	$HTMLFrags['NextLink'] 	= "index.php?option=com_mediqna&task=Next";
	$HTMLFrags['CurHints'] 	= "Show Answer?";
	$HTMLFrags['CurLink'] 	= "index.php?option=com_mediqna&task=Answer";
	//====----
	$CurSetQRecIDs 	= $mainframe->getUserState("mediqna.AllQNums");
	$MyIconsPath = JURI::base()."components".DS."com_mediqna".DS."graphics".DS;
	
	//Where are we withing the set progress?
	if($CurSetProg == 1){
		//At the start
		$HTMLFrags['PrevLink'] 	= "#";
	}else if($task == "Answer"){
		$HTMLFrags['CurLink'] 	= "#";
	}
	//====----
	$MyNav = "<!--Start Question Nav-->
	<a href='".$HTMLFrags['PrevLink']."' target='_self'>
	<img src='".$MyIconsPath."Previous.jpg' title='".$HTMLFrags['PrevHints']."' alt='".$HTMLFrags['PrevHints']."' width='56' height='46' border='0' />
	</a>
	
	<a href='".$HTMLFrags['CurLink']."' target='_self'>
	<img src='".$MyIconsPath."ShowAnswer.jpg' title='".$HTMLFrags['CurHints']."' alt='".$HTMLFrags['CurHints']."' width='88' height='46' border='0' />
	</a>
	
	<a href='".$HTMLFrags['NextLink']."' target='_self'>
	<img src='".$MyIconsPath."Next.jpg' title='".$HTMLFrags['NextHints']."' alt='".$HTMLFrags['NextHints']."' width='56' height='46' border='0' />
	</a>
	<!--End Question Nav-->";
	
	return $MyNav;
}
?>