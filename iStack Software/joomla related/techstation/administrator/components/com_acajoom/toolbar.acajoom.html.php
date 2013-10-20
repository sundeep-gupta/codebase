<?php
defined('_JEXEC') OR defined('_VALID_MOS') OR die('...Direct Access to this location is not allowed...');
/**
* @copyright Copyright (C) 2009 Joobi Limited All rights reserved.
* @license This file is released under the GPL license (http://www.gnu.org/licenses )
* @link http://www.ijoobi.com
*/

if ( ACA_CMSTYPE ) {
	require_once( WPATH_ADMIN . 'toolbar.acajoom15.html.php' );
} else {
	require_once( WPATH_ADMIN . 'toolbar.acajoom10.html.php' );
}//endif

