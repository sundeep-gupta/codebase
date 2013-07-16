<?php
// ensure a valid entry point
defined('_JEXEC') or die('Restricted Access');

// import the JView class
jimport('joomla.application.component.view');
jimport('joomla.html.html');
/**
* List View
*/
class PhunshukViewSubscription extends JView {
   function __construct() {
    parent::__construct();
  }
  function display($tmpl  = null) {
#    $mgr =& $this->get('Manager');
    $subscription =& $this->get('subscription');

    $this->assignRef('subscription',$subscription);
    $this->_initToolbar();

    parent::display($tmpl);

  }
  function _initToolbar() {
		JToolBarHelper::trash();
		JToolBarHelper::editListX();
		JToolBarHelper::addNewX('newItem');
//		JToolBarHelper::help( 'screen.menus' );

		$document = & JFactory::getDocument();
		$document->setTitle(JText::_('View Menu Items'));

  }

	function Sun($tpl=null) {
		global $mainframe;

		$this->_layout = 'default';

		/*
		 * Set toolbar items for the page
		 */
		$menutype 	= $mainframe->getUserStateFromRequest( 'com_menus.menutype', 'menutype', 'mainmenu', 'string' );

		JToolBarHelper::title( JText::_( 'MENU ITEM MANAGER' ) .': <small><small>['.$menutype.']</small></small>', 'menu.png' );

		$bar =& JToolBar::getInstance('toolbar');
		$bar->appendButton( 'Link', 'menus', 'Menus', "index.php?option=com_menus" );

		JToolBarHelper::makeDefault( 'setdefault' );
		JToolBarHelper::publishList();
		JToolBarHelper::unpublishList();
		JToolBarHelper::customX( 'move', 'move.png', 'move_f2.png', 'Move', true );
		JToolBarHelper::customX( 'copy', 'copy.png', 'copy_f2.png', 'Copy', true );
		JToolBarHelper::trash();
		JToolBarHelper::editListX();
		JToolBarHelper::addNewX('newItem');
		JToolBarHelper::help( 'screen.menus' );

		$document = & JFactory::getDocument();
		$document->setTitle(JText::_('View Menu Items'));

		$limitstart = JRequest::getVar('limitstart', '0', '', 'int');
		$items		= &$this->get('Items');
		$pagination	= &$this->get('Pagination');
		$lists		= &$this->_getViewLists();
		$user		= &JFactory::getUser();

		// Ensure ampersands and double quotes are encoded in item titles
		foreach ($items as $i => $item) {
			$treename = $item->treename;
			$treename = JFilterOutput::ampReplace($treename);
			$treename = str_replace('"', '&quot;', $treename);
			$items[$i]->treename = $treename;
		}

		//Ordering allowed ?
		$ordering = ($lists['order'] == 'm.ordering');

		JHTML::_('behavior.tooltip');

		$this->assignRef('items', $items);
		$this->assignRef('pagination', $pagination);
		$this->assignRef('lists', $lists);
		$this->assignRef('user', $user);
		$this->assignRef('menutype', $menutype);
		$this->assignRef('ordering', $ordering);
		$this->assignRef('limitstart', $limitstart);

		parent::display($tpl);
	}


}?>
