<?php
/**
 * JoomSense module shows a Google Adsense ad.
 * @version 1.0.0
 * @copyright (C) 2009 PHP Architecture. All rights reserved
 * @license   GNU/GPL, see http://www.gnu.org/licenses/gpl-2.0.html 
 * @link http://www.phparch.cn
 **/

// No direct access
defined('_JEXEC') or die('Restricted access');

// Include the syndicate functions only once
//require_once (dirname(__FILE__).DS.'helper.php');

// Get a parameter from the module's configuration
$adClient = $params->get('client');
$adSlot   = $params->get('slot');
$adWidth  = $params->get('width');
$adHeight = $params->get('height');
$adAlign  = $params->get('textAlign');
   
// Include the template for display
require(JModuleHelper::getLayoutPath('mod_joomsense'));

