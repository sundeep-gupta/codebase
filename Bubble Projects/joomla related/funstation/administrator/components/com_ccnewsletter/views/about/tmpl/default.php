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
?>
<fieldset class="adminform">
	<legend><?php echo JText::_( 'CC_ABOUT_CCNEWSLETTER' ); ?></legend>
	<table class="admintable" cellspacing="1" width="100%">
	<tbody>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
			<?php echo JText::_( 'CC_ABOUT_TEXT' ); ?>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	</tbody>
	</table>
</fieldset>
<form action="index.php" method="post" name="adminForm" id="adminForm">
<input type="hidden" name="option" value="com_ccNewsletter" />
<input type="hidden" name="task" value="" />
<input type="hidden" name="c" value="about" />
</form>
<p class="copyright" align="center">
<font color="#178FC0">ccNewsletter</font>, Joomla! component by <a href="http://www.extensions.chillcreations.com" target="_blank">Chill Creations</a>  Copyright <?php echo date("Y") ?>
</p>
