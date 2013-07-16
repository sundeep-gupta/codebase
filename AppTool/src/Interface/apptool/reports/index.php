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

    // Set default includes
    include("../config.inc.php");
    include("modules/config.php");
    include("modules/reports.php");


    // Fetch all results generated
    $results = $myReports->getResults();
    
    // Define the following page attributes
    $STYLESHEET = array("reports.css", "menus.css");
    $JAVASCRIPT = "menus.js";
    $ONLOAD = "onLoad=\"xcSet('x', 'xc');\"";
    $PAGE_TITLE = "[AppTool] - Performance Results";
    
    
    include("../includes/templates/header.php");

?>
        <div id="resultsList">
            <ul id="x">
<?
    // Make sure we returned some results
    if (empty($results)) {
?>
                <li style="font-weight: bold; padding-top: 50px; padding-bottom: 50px;">There were no results that were returned.</li>
<?
    }
    else {
        foreach($results as $key => $item) {
            if (is_array($item)) {
                // Main Results Folder
                $icon = "<a href=\"results.php?timestamp=" . $key . "&type=all\"><img src=\"../includes/images/folder.gif\" alt=\"Results Folder\" width=\"40\" height=\"40\" /></a>";
                $label = "<a href=\"results.php?timestamp=" . $key . "&type=all\">$key - Results</a>";
?>
                <li>
                    <table>
                    <tr>
                        <td class="leftCol"><?= $icon ?></td>
                        <td class="rightColItem"><span style="margin-left: 25px;"><?= $label ?></span></td>
                    </tr>
                    </table>
                    <!-- BEGIN: next menu -->
<?
            }
            else {
                // Main Results File(s)
                $icon = "<a href=\"results.php?timestamp=" . $key . "&type=database&file=" . $item . "\"><img src=\"../includes/images/database.gif\" alt=\"Results File\" width=\"40\" height=\"40\" /></a>";
                $label = "<a href=\"results.php?timestamp=" . $key . "&type=database&file=" . $item . "\">" . $item . "</a>";
?>
                <li>
                    <table>
                    <tr>
                        <td class="leftCol"><?= $icon ?></td>
                        <td class="rightColItem"><span style="margin-left: 25px;"><?= $label ?></span></td>
                    </tr>
                    </table>
                </li>
<?
            }

            if (is_array($item)) {
?>
                    <ul id="<?= $key ?>" title="Results">
<?
                foreach($item as $subkey => $subitem) {
                    if (is_array($subitem)) {
                        // Sub-Folder
                        $subicon = "<a href=\"results.php?timestamp=". $key ."&machine=" . $subkey . "&type=all\"><img src=\"../includes/images/network_local.gif\" alt=\"Machine Folder\" width=\"40\" height=\"40\" /></a>";
                        $sublabel = "<a href=\"results.php?timestamp=". $key ."&machine=" . $subkey . "&type=all\">" . $subkey . "</a>";
?>
                        <li>
                            <table>
                            <tr>
                                <td class="leftCol"><?= $subicon ?></td>
                                <td class="rightColSubItem"><span style="margin-left: 50px"><?= $sublabel ?></span></td>
                            </tr>
                            </table>
                            <!-- BEGIN: last menu -->
<?
                    }
                    else {
                        // Sub-File(s)
                        $subicon = "<a href=\"results.php?timestamp=". $key ."&type=". substr($subitem, 0, -4) ."\"><img src=\"../includes/images/file.gif\" alt=\"Results File\" width=\"40\" height=\"40\" /></a>";
                        $sublabel = "<a href=\"results.php?timestamp=" . $key . "&type=" . substr($subitem, 0, -4) . "\">" . $subitem . "</a>";
?>
                        <li>
                            <table>
                            <tr>
                                <td class="leftCol"><?= $subicon ?></td>
                                <td class="rightColSubItem"><span style="margin-left: 50px"><?= $sublabel ?></span></td>
                            </tr>
                            </table>
                        </li>
<?
                    }

                    // Metric-File(s)
                    $subitem_count = 0;
                    if (is_array($subitem)) {
?>
                            <ul id="<?= $key . "_" . preg_replace("/\./", "_", $subkey) ?>" title="Machine">
<?
                        foreach($subitem as $bottom_key => $bottom_item) {
                            $bottomicon = "<a href=\"results.php?timestamp=". $key ."&machine=" . $subkey . "&type=". substr($bottom_item, 0, -4) ."\"><img src=\"../includes/images/file.gif\" alt=\"Results File\" width=\"40\" height=\"40\" /></a>";
                            $bottomlabel = "<a href=\"results.php?timestamp=". $key ."&machine=" . $subkey . "&type=". substr($bottom_item, 0, -4) ."\">" . $bottom_item . "</a>";
?>
                                <li>
                                    <table>
                                    <tr>
                                        <td class="leftCol"><?= $bottomicon ?></td>
                                        <td class="rightColBottomItem"><span style="margin-left: 75px;"><?= $bottomlabel ?></span></td>
                                    </tr>
                                    </table>
                                </li>
<?
                        }
?>
                            </ul>
                            <!-- END: last menu -->
                        </li>
<?
                    }
                }
?>
                    </ul>
                    <!-- END: next menu -->
                </li>
<?
            }
        }
    }
?>
            </ul>
        </div>
<?

    include("../includes/templates/footer.php");

?>