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

class ccNewsletterViewnewsletter extends JView
{
	function display($tpl = null)
	{
		// retrieve newsletter to view
		$newsletterRecord=& $this->get('Data');
		$isNew = ($newsletterRecord->id < 1);

		$text = $isNew ? JText::_( 'CC_NEW' ) : JText::_( 'CC_EDIT' );
		if($isNew)
		{
			JToolBarHelper::title(  JText::_( 'CC_NEWSLETTER_TITLE' ).': <small><small>[ ' . $text.' ]</small></small>',  'ccnewsletter.png'  );
		}
		else
		{
			JToolBarHelper::title(  $newsletterRecord->name.': <small><small>[ ' . $text.' ]</small></small>' , 'ccnewsletter.png' );
		}
		JToolBarHelper::save();
		JToolBarHelper::apply();

		if ($isNew)  {
			JToolBarHelper::cancel();
		} else {
			// for existing items the button is renamed `close`
			JToolBarHelper::cancel( 'cancel', 'Close' );
		}
		$this->_addCss();
		$this->assignRef('newsletterRecord',$newsletterRecord);
		parent::display($tpl);
	}

	function _addCss()
	{
	    $document =& JFactory::getDocument();
	    $document->addStyleSheet('components/com_ccnewsletter/assets/ccnewsleter.css');
	}
}
