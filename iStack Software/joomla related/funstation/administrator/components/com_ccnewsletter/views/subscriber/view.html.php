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
class ccNewsletterViewsubscriber extends JView
{
	function display($tpl = null)
	{
		// get the subscriber we are giong to view
		$subscriberRecord =& $this->get('Data');
		$isNew= ($subscriberRecord->id < 1);

		$text = $isNew ? JText::_( 'CC_NEW' ) : JText::_( 'CC_EDIT' );
		JToolBarHelper::title(   JText::_( 'CC_SUBSCRIBER_VIEW' ).': <small><small>[ ' . $text.' ]</small></small>','ccnewsletter.png' );
		JToolBarHelper::save();
		if ($isNew)  {
			JToolBarHelper::cancel();
		} else {
			JToolBarHelper::cancel( 'cancel', 'Close' );
		}
		$this->_addCss();
		$this->assignRef('subscriberRecord',		$subscriberRecord);
		parent::display($tpl);
	}
	function _addCss()
	{
	    $document =& JFactory::getDocument();
	    $document->addStyleSheet('components/com_ccnewsletter/assets/ccnewsleter.css');
	}
}
