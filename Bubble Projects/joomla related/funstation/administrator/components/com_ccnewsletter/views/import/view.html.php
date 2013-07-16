<?php
/**
* @package ccNewsletter
* @version 1.0.7
* @author  Chill Creations <info@chillcreations.com>
* @link    http://www.chillcreations.com
* @copyright Copyright (C) 2008 - 2010 Chill Creations-All rights reserved
* @license GNU/GPL, see LICENSE.php for full license.
* See COPYRIGHT.php for more copyright notices and details.

This file is part of ccNewsletter.
This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
**/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');
jimport( 'joomla.application.component.view' );
class ccNewsletterViewImport extends JView
{
	function display($tpl = null)
	{
		JToolBarHelper::title( JText::_( 'CC_NEWSLETTER_TITLE') . ' - ' . JText::_( 'CC_IMPORT'), 'ccnewsletter.png');
		JToolBarHelper::preferences('com_ccnewsletter', '500');
		$this->_addCss();
		$acknowledgementrow=& $this->get('Data');
		$database =& JFactory::getDBO();
		$query = "SELECT count(*) FROM #__components WHERE name ='Communicator'";
		$database->setquery($query);
		$communicator = $database->loadResult();
		$query = "SELECT count(*) FROM #__components WHERE name ='Acajoom'";
		$database->setquery($query);
		$acajoom = $database->loadResult();
		$query = "SELECT count(*) FROM #__components WHERE name ='YaNC'";
		$database->setquery($query);
		$yanc = $database->loadResult();
		$query = "SELECT count(*) FROM #__components WHERE name ='Letterman'";
		$database->setquery($query);
		$letterman = $database->loadResult();
		$query = "SELECT count(*) FROM #__components WHERE name ='Vemod News Mailer'";
		$database->setquery($query);
		$vmod = $database->loadResult();
		$totalcomponent = $communicator+$acajoom+$yanc+$letterman+$vmod;
		$this->assignRef('communicator',		$communicator);
		$this->assignRef('acajoom',		$acajoom);
		$this->assignRef('yanc',		$yanc);
		$this->assignRef('letterman',		$letterman);
		$this->assignRef('vmod',		$vmod);
		$this->assignRef('totalcomponent',		$totalcomponent);
		parent::display($tpl);
	}
	function _addCss()
	{
	    $document =& JFactory::getDocument();
	    $document->addStyleSheet('components/com_ccnewsletter/assets/ccnewsleter.css');
	}

}
