<?php

######################################################################################
#
# Copyright:     AppLabs Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: $
# Last Modified: $Date: $
# Modified By:   $Author: $
# Source:        $Source: $
#
######################################################################################

    ##
    ## HTML display functions
    ##
    
    function display_stylesheet_items($items, $BASEURL) {

        $html = "";

        if (sizeof($items) > 1) {
            for ($i=0; $i < sizeof($items); $i++) {
	        $link = $BASEURL."includes/css/".$items[$i];
                $html .= "\t@import url($link);\n";
            }
        }
        else {
            $link = $BASEURL."includes/css/".$items;
            $html = "\t@import url($link);\n";
        }

        return $html;
    }

    function display_javascript_items($items, $BASEURL) {

        $html = "";

        if (sizeof($items) > 1) {
            for ($i=0; $i < sizeof($items); $i++) {
                $link = $BASEURL."includes/js/".$items[$i];
                $html .= "    <script src=\"".$link."\" type=\"text/javascript\"></script>\n";
            }
        }
        else {
            $link = $BASEURL."includes/js/".$items;
            $html .= "    <script src=\"".$link."\" type=\"text/javascript\"></script>\n";
        }

        return $html;
    }
    
    ##
    ###########################################################


?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/2000/REC-xhtml1-20000126/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><?= (isset($PAGE_TITLE) && $PAGE_TITLE != "") ? $PAGE_TITLE : "AppTool"; ?></title>
    <style type="text/css">
        @import url(<?= $myConfig->BASEURL ?>includes/css/layout.css);
<?= (isset($STYLESHEET) && $STYLESHEET != "") ? display_stylesheet_items($STYLESHEET, $myConfig->BASEURL) : ""; ?>
    </style>
    <script src="<?= $myConfig->BASEURL ?>includes/js/main.js" type="text/javascript"></script>
<?= (isset($JAVASCRIPT) && $JAVASCRIPT != "") ? display_javascript_items($JAVASCRIPT, $myConfig->BASEURL) : ""; ?>
</head>

<body<?= (isset($ONLOAD) && $ONLOAD != "") ? " " . $ONLOAD : ""; ?>>
<div id="pageWrapper">
    <div id="pageHeader">
        <div id="headerImage"><img src="<?= $myConfig->BASEURL ?>includes/images/header_bg.gif" alt="AppLabs Header Image" /></div>
        <div id="headerBorder">
            <table>
            <tr>
                <td style="width: 400px; text-align: left; margin-left: 10px;">www.applabs.com</td>
                <td style="width: 400px; text-align: right; margin-right: 10px;"><script type="text/javascript">showLongDate();</script></td>
            </tr>
            </table>
        </div>
        <div id="headerMenu">
            <table cellspacing="0" cellpadding="0">
            <tr>
                <td style=""><a href="<?= $myConfig->BASEURL ?>">Home</a></td>
                <td style=""><a href="<?= $myConfig->BASEURL ?>monitor/">Monitor</a></td>
                <td style=""><a href="<?= $myConfig->BASEURL ?>tools/">Tools</a></td>
                <td style=""><a href="<?= $myConfig->BASEURL ?>reports/">Reports</a></td>
                <td style=""><a href="<?= $myConfig->BASEURL ?>config/">Config</a></td>
            </tr>
            </table>
        </div>
    </div>
    
    <div id="pageBody">
