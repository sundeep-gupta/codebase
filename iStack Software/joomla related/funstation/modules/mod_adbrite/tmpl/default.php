<?php // no direct access
/**
* @version 1.0 $ for Joomla! 1.5
* @copyright (C) 2008 Joomlaspan
* @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
* @Author name Joomlaspan 
* @Author website  http://www.joomlaspan.com/
*/

defined( '_JEXEC' ) or die( 'Restricted access' ); ?>

<?php
if ($adcss) 
	{ 
	echo "<div style=\"" . $adcss . "\">\r\n"; 
	}
	if ($adtype == 1) {
		echo "<!-- AdBrite Module from Joomlaspan :: http://www.joomlaspan.com -->\r\n"
		. "<script type=\"text/javascript\">\r\n"
		. 	"var AdBrite_Title_Color = '" . $b_title_color  . "';\r\n"
		.	"var AdBrite_Text_Color = '" . $b_text_color . "';\r\n"
		.	"var AdBrite_Background_Color = '" . $b_bg_color . "';\r\n"
		.	"var AdBrite_Border_Color = '" . $b_border_color . "';\r\n"
		.	"var AdBrite_URL_Color = '" . $b_url_color . "';\r\n"
		. "</script>\r\n"
		. "<script src=\"http://ads.adbrite.com/mb/text_group.php?sid=" . $b_adbrite_sid . "&zs=" . $b_adbrite_zsid . "\" type=\"text/javascript\"></script>\r\n";
		if ($adbrite_link) 
			{ 
			echo "<div><a target=\"" . $adbrite_target . "\" href=\"http://www.adbrite.com/mb/commerce/purchase_form.php?opid=" . $b_adbrite_sid . "&afsid=1\" style=\"" . $adbrite_link_css  . "\">" . $adbrite_link_text  . "</a></div>\r\n";
			}
	} else {
		echo "<!-- AdBrite Module from Joomlaspan :: http://www.joomlaspan.com -->\r\n"
		. "<style type=\"text/css\">\r\n"
		. ".adHeadline {font: " . $t_headline_weight . " " . $t_headline_size . "pt " . $t_headline_face . "; text-decoration: " . $t_headline_decoration . "; color: #" . $t_headline_color . ";}\r\n"
		. ".adText {font: " . $t_text_weight . " " . $t_text_size . "pt " . $t_text_face . "; text-decoration: " . $t_text_decoration . "; color: #" . $t_text_color . ";}\r\n"
		. "</style>\r\n"
		. "<script type=\"text/javascript\" src=\"http://ads.adbrite.com/mb/text_group.php?sid=" . $t_adbrite_sid . "&br=1\">\r\n"
		. "</script>\r\n";
		if ($adbrite_link) 
			{ 
			echo "<div><a target=\"" . $adbrite_target . "\" href=\"http://www.adbrite.com/mb/commerce/purchase_form.php?opid=" . $t_adbrite_sid . "&afsid=1\" style=\"" . $adbrite_link_css  . "\">" . $adbrite_link_text  . "</a></div>\r\n";
			}
	}
if ($js_attribute) { echo '<a href="http://www.joomlaspan.com" target="_top"><img src="http://www.joomlaspan.com/images/pixel.png" alt="" title="Joomla Extensions, Components, Modules" border="0"></a>';}	
if ($adcss) 
	{ 
	echo '</div>'; 
	}
?>