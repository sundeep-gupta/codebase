<?php 
/*
MediQnA v1.1
Question and answer system for medical websites
Original code (c) Famous Websites 2008
Latest Update: 13-December-2008

InitSetSesh.php initialise a new question set session.
Looks for the latest set to be added and uses it as
the current set.
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );

class InitSetSesh{
	var $FoundSetID;
	var $FoundSetName;
	var $FoundSetDesc;
	var $FoundQsIds = array();
	var $SetLen = 0;
	
	function InitSetSesh($sid,$dbh,$mainframe){
		$NavButs 	= array();
		if(empty($sid)){
			//We need to look at the DB for the latest set that's 
			//been added which is set to 'on' and has at least two
			//questions that are also set to 'on'.
			$dbh->setQuery("SELECT RecID,SetName,SetDesc FROM qna_QuestionSets WHERE Status LIKE 'on' ORDER BY RecID DESC");
			$QSets = $dbh->loadObjectList();
			
			//Because we need to know what question number comes next
			//we have to be able to look ahead (witout bothering the DB too much)so
			//we're storing a list of the numbers in an array and walking the array
			//and looking ahead one node.
			foreach($QSets as $r=>$s){
				$dbh->setQuery("SELECT RecID FROM qna_Questions WHERE AssignedSet = '".$s->RecID."' AND Status LIKE 'on' ORDER BY RecID");
				$ThisQ = $dbh->loadObjectList();
				if(empty($this->FoundSetID)){
					if($ThisQ[1]){
						//This set meets our criteria
						//Add a finish flag to the array
						array_push($this->FoundQsIds,"start");
						
						foreach($ThisQ as $a=>$b){
							array_push($this->FoundQsIds,$b->RecID);
							$this->SetLen++;
						}
						
						$this->FoundSetID 	= $s->RecID;
						$this->FoundSetName = $s->SetName;
						$this->FoundSetDesc = $s->SetDesc;
					}
				}
			}			
		}else{
			//Must be a number...
			if(!is_numeric($sid)){
				//Stop it dead...
				AllStop();
			}
		
			//The user has requested a specific set
			//Note, looking at status too as safety check
			$dbh->setQuery("SELECT SetName,SetDesc FROM qna_QuestionSets WHERE RecID LIKE '".$sid."' AND Status LIKE 'on'");
			$QSet = $dbh->loadObjectList();
			
			if($QSet[0]->SetName){
				$this->FoundSetID 	= $sid;
				$this->FoundSetName = $QSet[0]->SetName;
				$this->FoundSetDesc = $QSet[0]->SetDesc;		
			}else{
				//Stop it dead...
				AllStop();
			}
			//Now get this sets questions
			
			$dbh->setQuery("SELECT RecID FROM qna_Questions WHERE AssignedSet = '".$sid."' AND Status LIKE 'on' ORDER BY RecID");
			$ThisQ = $dbh->loadObjectList();
			array_push($this->FoundQsIds,"start");
			foreach($ThisQ as $a=>$b){
				array_push($this->FoundQsIds,$b->RecID);
				$this->SetLen++;
			}
		}
		//====-----
		//Add a finish flag to the array
		//This isn't used in this versin but may
		//be handy later, to direct to another process
		array_push($this->FoundQsIds,"end");

		//Store everything in the cookies
		$mainframe->setUserState("mediqna.AllQNums",$this->FoundQsIds);
		//====----
		$mainframe->setUserState("mediqna.CurSetID",$this->FoundSetID);
		$mainframe->setUserState("mediqna.CurSetName",$this->FoundSetName);
		$mainframe->setUserState("mediqna.CurSetDesc",$this->FoundSetDesc);
	}
}

//AllStop is a safty valve
function AllStop(){
	print "Error: Something went wrong!";
	exit(0);
}
?>