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

    
    // Fetch our results information
    if (isset($_GET['timestamp']) && $_GET['timestamp'] != "") {
        $timestamp = $_GET['timestamp'];
        if (isset($_GET['type']) && $_GET['type'] == "all") {
            // Fetch only machine-specific results
            if (isset($_GET['machine']) && $_GET['machine'] != "all") {
                $results = $myReports->getResults($timestamp . "/" . $_GET['machine']);
                $icon = "network_local.gif";
                $title = $timestamp . " - " . $_GET['machine'];
            }
            // Fetch all results generated
            else {
                $results = $myReports->getResults($timestamp);
                $icon = "folder.gif";
                $title = $timestamp;
            }
        }
        else {
            if (isset($_GET['machine']) && $_GET['machine'] != "all") {
                $title = $timestamp . " - " . $_GET['machine'] . " - " . ucfirst($_GET['type']);
            }
            else {
                $title = $timestamp . " - " . ucfirst($_GET['type']);
            }
            $icon = "file.gif";
            
        }
    }
    else {
        $timestamp = "";
        $icon = "folder.gif";
        $title = "Unknown Timestamp";
    }
    
    // Define the following page attributes
    $STYLESHEET = array("reports.css", "menus.css");
    $JAVASCRIPT = "menus.js";
    $ONLOAD = "onLoad=\"xcSet('x', 'xc');\"";
    $PAGE_TITLE = "[AppTool] - Performance Results";
    
    
    include("../includes/templates/header.php");

?>
        <div id="results">
            <div id="resultsHeader">
                <table cellspacing="0" cellpadding="0">
                <tr>
                    <td class="leftCol"><img src="../includes/images/<?= $icon ?>" alt="" width="50" height="50" /></td>
                    <td class="rightCol"><?= $title ?></td>
                </tr>
                </table>
            </div>
            <div id="resultsInfo">
<?
    if (isset($_GET['type']) && $_GET['type'] == "all") {
        if (empty($results)) {
?>
                <div id="resultsList">
                    <p style="font-weight: bold; font-size: 14px;">Folder Empty</p>
                </div>
<?
        }
        else {
?>
                <div id="resultsList">
                    <ul id="x">
<?
            foreach($results as $subkey => $subitem) {
                if (is_array($subitem)) {
                    // Machine-Folder(s)
                    $subicon = "<a href=\"results.php?timestamp=" . $_GET['timestamp'] . "&machine=" . $subkey . "&type=all\"><img src=\"../includes/images/network_local.gif\" alt=\"Machine Folder\" width=\"40\" height=\"40\" /></a>";
                    $sublabel = "<a href=\"results.php?timestamp=" . $_GET['timestamp'] . "&machine=" . $subkey . "&type=all\">" . $subkey;
                }
                else {
                    // Results-File(s)
                    if (isset($_GET['machine'])) {
                        $subicon = "<a href=\"results.php?timestamp=" . $_GET['timestamp'] . "&machine=" . $_GET['machine'] . "&type=" . substr($subitem, 0, -4) . "\"><img src=\"../includes/images/file.gif\" alt=\"Results File\" width=\"40\" height=\"40\" /></a>";
                        $sublabel = "<a href=\"results.php?timestamp=" . $_GET['timestamp'] . "&machine=" . $_GET['machine'] . "&type=" . substr($subitem, 0, -4) . "\">" . $subitem . "</a>";
                    }
                    else {
                        $subicon = "<a href=\"results.php?timestamp=" . $_GET['timestamp'] . "&type=" . substr($subitem, 0, -4) . "\"><img src=\"../includes/images/file.gif\" alt=\"Results File\" width=\"40\" height=\"40\" /></a>";
                        $sublabel = "<a href=\"results.php?timestamp=" . $_GET['timestamp'] . "&type=" . substr($subitem, 0, -4) . "\">" . $subitem . "</a>";
                    }
                }
?>
                        <li>
                            <table cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="leftCol"><?= $subicon ?></td>
                                <td class="rightColSubItem"><span style="margin-left: 30px;"><?= $sublabel ?></span></td>
                            </tr>
                            </table>
                            <!-- BEGIN: next menu -->
<?
                if (is_array($subitem)) {
?>
                            <ul id="<?= $_GET['timestamp'] . "_" . preg_replace("/\./", "_", $subkey) ?>" title="Machine">
<?
                    foreach ($subitem as $machinekey => $machineitem) {
                        $machineicon = "<a href=\"results.php?timestamp=" . $_GET['timestamp'] . "&machine=" . $subkey . "&type=" . substr($machineitem, 0, -4) . "\"><img src=\"../includes/images/file.gif\" alt=\"Results File\" width=\"40\" height=\"40\" /></a>";
                        $machinelabel = "<a href=\"results.php?timestamp=" . $_GET['timestamp'] . "&machine=" . $subkey . "&type=" . substr($machineitem, 0, -4) . "\">" . $machineitem . "</a>";
?>
                                <li>
                                    <table cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td class="leftCol"><?= $machineicon ?></td>
                                        <td class="rightColSubItem"><span style="margin-left: 60px;"><?= $machinelabel ?></span></td>
                                    </tr>
                                    </table>
                                </li>
<?
                    }
?>
                            </ul>
                            <!-- END: next menu -->
                        </li>
<?
                }
            }
?>
                    </ul>
                </div>
<?
        }
    }
    else {
        // Fetch only machine-specific results
        if (isset($_GET['machine']) && $_GET['machine'] != "all") {
            $results_file = $myConfig->RESULTS_PATH . $_GET['timestamp'] . "/" . $_GET['machine'] . "/" . $_GET['type'] . ".csv";
        }
        // Else, if file is present, fetch file results
        else if (isset($_GET['file']) && $_GET['file'] != "") {
            $results_file = $myConfig->RESULTS_PATH . $_GET['file'];
        }
        // Else, fetch all other results
        else {
            $results_file = $myConfig->RESULTS_PATH . $_GET['timestamp'] . "/" . $_GET['type'] . ".csv";
        }
        
        $metrics = $myReports->getMetricFields($results_file);
?>
                <div id="resultsDetails">
                    <table cellspacing="1" cellpadding="1">
                    <tr>
                        <td class="leftCol">Test Executed On:</td>
                        <td class="rightCol"><?= $myReports->fetchDate($_GET['timestamp']); ?></td>
                    </tr>
                    <tr>
                        <td class="leftCol">Metrics:</td>
                        <td class="rightCol">
                            <ul>
<?
        if (isset($metrics)) {
            $metric_count = 0;
            foreach($metrics as $metric_type) {
                if (isset($_GET['machine']) && $_GET['machine'] != "all") {
                    $bottomicon = "";
                    $bottomlabel = "<a href=\"chart.php?timestamp=" . $_GET['timestamp'] . "&machine=" . $_GET['machine'] . "&type=" . $_GET['type'] . "&metric=" . $metric_count . "\">" . ucfirst($metric_type) . "</a>";
                }
                else if (isset($_GET['file']) && $_GET['file'] != "") {
                    $bottomicon = "";
                    $bottomlabel = "<a href=\"chart.php?timestamp=" . $_GET['timestamp'] . "&type=" . $_GET['type'] . "&file=" . $_GET['file'] . "&metric=" . $metric_count . "\">" . ucfirst($metric_type) . "</a>";
                }
                else {
                    $bottomicon = "";
                    $bottomlabel = "<a href=\"chart.php?timestamp=" . $_GET['timestamp'] . "&type=" . $_GET['type'] . "&metric=" . $metric_count . "\">" . ucfirst($metric_type) . "</a>";
                }
?>
                                <li>
                                    <table>
                                    <tr>
                                        <td><img src="../includes/images/agt_business.gif" alt="" /></td>
                                        <td><?= $bottomlabel ?></td>
                                    </tr>
                                    </table>
                                </li>
<?
                $metric_count++;
            }
        }
        else {
?>
                                <li>No Metrics Were Found</li>
<?
        }
?>
                            </ul>
                        </td>
                    </tr>
                    </table>
                </div>
<?
    }
?>
            </div>
        </div>
<?

    include("../includes/templates/footer.php");

?>