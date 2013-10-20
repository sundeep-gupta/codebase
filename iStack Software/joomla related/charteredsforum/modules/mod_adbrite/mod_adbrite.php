<?php
/**
* @version 1.1 $ for Joomla! 1.5
* @copyright (C) 2008 Joomlaspan
* @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
* @Author name Joomlaspan 
* @Author website  http://www.joomlaspan.com/
*/

// no direct access
defined( '_JEXEC' ) or die( 'Restricted access' );

// Include the syndicate functions only once
require_once( dirname(__FILE__).DS.'helper.php' );

$adcss = $params->get('js_ad_css');
$adtype = $params->get('js_adtype');

$b_adbrite_sid = $params->get( 'b_sid' );
$b_adbrite_zsid = $params->get( 'b_zsid' );
$b_title_color = $params->get( 'b_title_color' );
$b_text_color = $params->get( 'b_text_color' );
$b_url_color = $params->get( 'b_url_color' );
$b_bg_color = $params->get( 'b_bg_color' );
$b_border_color = $params->get( 'b_border_color' );

$t_adbrite_sid = $params->get( 't_sid' );
$t_headline_weight = $params->get( 't_headline_weight' );
$t_headline_size = $params->get( 't_headline_size' );
$t_headline_face = $params->get( 't_headline_face' );
$t_headline_decoration = $params->get( 't_headline_decoration' );
$t_headline_color = $params->get( 't_headline_color' );
$t_textweight = $params->get( 't_textweight' );
$t_text_size = $params->get( 't_text_size' );
$t_text_face = $params->get( 't_text_face' );
$t_text_decoration = $params->get( 't_text_decoration' );
$t_text_color = $params->get( 't_text_color' );

$adbrite_link = $params->get( 'js_adbrite_link' );
$adbrite_target = $params->get( 'js_adbrite_target' );
$adbrite_link_css = $params->get('js_adbrite_link_css');
$adbrite_link_text = $params->get('js_adbrite_link_text');

$js_attribute = $params->get('js_attribute');

require( JModuleHelper::getLayoutPath( 'mod_adbrite' ) );
