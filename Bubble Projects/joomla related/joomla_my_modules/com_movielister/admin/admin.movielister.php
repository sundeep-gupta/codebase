<?php
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted Access');

// Make sure the user is authorized to view this page
/* $user = & JFactory::getUser();
if (!$user->authorize( 'com_mvoielister', 'manage' )) {
	$mainframe->redirect( 'index.php', JText::_('ALERTNOTAUTH') );
}

*/

$controllerName = JRequest::getCmd( 'c', 'cinema' );

if($controllerName == 'cinema') {
	JSubMenuHelper::addEntry(JText::_('Cinemas'), 'index.php?option=com_movielister&view=cinema',true);
	JSubMenuHelper::addEntry(JText::_('Movies'), 'index.php?option=com_movielister&c=movie&view=movie' );
	JSubMenuHelper::addEntry(JText::_('Play'), 'index.php?option=com_movielister&c=play&view=play');
} elseif($controllerName == 'movie' ){
	JSubMenuHelper::addEntry(JText::_('Cinemas'), 'index.php?option=com_movielister&view=cinema' );
	JSubMenuHelper::addEntry(JText::_('Movies'), 'index.php?option=com_movielister&c=movie&view=movie',true);
	JSubMenuHelper::addEntry(JText::_('Play'), 'index.php?option=com_movielister&c=play&view=play');
} else{
	JSubMenuHelper::addEntry(JText::_('Cinemas'), 'index.php?option=com_movielister&view=cinema' );
	JSubMenuHelper::addEntry(JText::_('Movies'), 'index.php?option=com_movielister&c=movie&view=movie');
	JSubMenuHelper::addEntry(JText::_('Play'), 'index.php?option=com_movielister&c=play&view=play', true);
}
if($controllerName != 'movie' or $controllerName != 'play') {
  $controllerName = 'cinema';
}

#$controllerName = 'cinema';
require_once( JPATH_COMPONENT.DS.'controllers'.DS.$controllerName.'.php' );
$controllerName = 'Cinema';
$controllerName = 'MovieListerController'.$controllerName;

// Create the controller
$controller = new $controllerName();

// Perform the Request task
$controller->execute( JRequest::getCmd('task','display') );

// Redirect if set by the controller
$controller->redirect();

?>
