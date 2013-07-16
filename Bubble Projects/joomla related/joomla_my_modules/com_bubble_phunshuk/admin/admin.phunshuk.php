	<?php
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted Access');

// Make sure the user is authorized to view this page
/* $user = & JFactory::getUser();
if (!$user->authorize( 'com_mvoielister', 'manage' )) {
	$mainframe->redirect( 'index.php', JText::_('ALERTNOTAUTH') );
}

*/

$controllerName = JRequest::getCmd( 'c', 'food' );

if($controllerName == 'food') {
	JSubMenuHelper::addEntry(JText::_('Food'), 'index.php?option=com_phunshuk&view=food',true);
	JSubMenuHelper::addEntry(JText::_('User'), 'index.php?option=com_phunshuk&c=user&view=user' );
	JSubMenuHelper::addEntry(JText::_('Subscription'), 'index.php?option=com_phunshuk&c=subscription&view=subscription');
} elseif($controllerName == 'user' ){
	JSubMenuHelper::addEntry(JText::_('Food'), 'index.php?option=com_phunshuk&view=food' );
	JSubMenuHelper::addEntry(JText::_('User'), 'index.php?option=com_phunshuk&c=user&view=user',true);
	JSubMenuHelper::addEntry(JText::_('Subscription'), 'index.php?option=com_phunshuk&c=subscription&view=subscription');
} else{
	JSubMenuHelper::addEntry(JText::_('Food'), 'index.php?option=com_phunshuk&view=food' );
	JSubMenuHelper::addEntry(JText::_('User'), 'index.php?option=com_phunshuk&c=user&view=user');
	JSubMenuHelper::addEntry(JText::_('Subscription'), 'index.php?option=com_phunshuk&c=subscription&view=subscription', true);
}
if($controllerName != 'user' or $controllerName != 'subscription') {
  $controllerName = 'food';
}

#$controllerName = 'food';
require_once( JPATH_COMPONENT.DS.'controllers'.DS.$controllerName.'.php' );
$controllerName = 'Food';
$controllerName = 'PhunshukController'.$controllerName;

// Create the controller
$controller = new $controllerName();

// Perform the Request tasl
$controller->execute( JRequest::getCmd('task','display') );

// Redirect if set by the controller
$controller->redirect();

?>
