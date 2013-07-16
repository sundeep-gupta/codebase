<?php
// ensure a valid entry point
#defined('_JEXEC') or die('Restricted Access');

// import the JView class
jimport('joomla.application.component.view');
/**
* List View
*/

class PhunshukViewList extends JView {
  function __construct() {
    parent::__construct();
  }
  function display($tmpl  = null) {
  #  $user =& JFactory::getUser();
  #	echo "<p>Current logged in user is {$user->name}</p>"; 
  
  #	$user =& JFactory::getUser('sundeep.techie');
  #	echo "<p>and there is another user with name {$user->name}</p>"
    $model =& $this->getModel();
    $account = $model->getAccount();
    
    $food = $account->food;
    $balance = $account->balance;
    $this->assignRef('balance',$balance);
    $this->assignRef('food', $food);
    parent::display($tmpl);

  }

}?>