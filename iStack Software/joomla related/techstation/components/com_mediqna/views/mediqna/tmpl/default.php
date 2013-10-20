<?php // no direct access
defined('_JEXEC') or die('Restricted access'); ?>
<h3><?php print $this->FoundSetName; ?></h3>
<?php print "Description: ".$this->FoundSetDesc."<br><hr><h4>".$this->ProgressMsg."</h4>"; ?>
<?php 
	//Print the question
	print $this->OPQ; 

	//If it exists, print the answer
	if($this->OPA){
		print "<hr><h4>Answer...</h4>".$this->OPA;	
	}
?>
<br />
<br />
<?php echo $this->NavButs; ?>
<br />
<br />
Click <a href="index.php?option=com_mediqna&view=listing">here</a> to view other sets!