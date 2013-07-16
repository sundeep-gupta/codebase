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
    include("phplot/phplot.php");
    
    
    // Fetch our results information
    if (isset($_GET['timestamp']) && $_GET['timestamp'] != "") {
        if (isset($_GET['machine']) && $_GET['machine'] != "all") {
            $results_file = $myConfig->RESULTS_PATH . $_GET['timestamp'] . "/" . $_GET['machine'] . "/" . $_GET['type'] . ".csv";
        }
        else if (isset($_GET['file']) && $_GET['file'] != "") {
            $results_file = $myConfig->RESULTS_PATH . $_GET['file'];
        }
        else {
            $results_file = $myConfig->RESULTS_PATH . $_GET['timestamp'] . "/" . $_GET['type'] . ".csv";
        }
        
        $metric_type = $myReports->getMetricFieldName($results_file,$_GET['metric']);
        
        if (isset($_GET['machine']) && $_GET['machine'] != "all") {
            $title = $_GET['timestamp'] . " - " . $_GET['machine'] . " - " . ucfirst($_GET['type']) . " - " . ucfirst($metric_type);
        }
        else {
            $title = $_GET['timestamp'] . " - " . ucfirst($_GET['type']) . " - " . ucfirst($metric_type);
        }
    }
    else {
        $title = "Error: Missing query fields.";
    }
    
    // Define the following page attributes
    $STYLESHEET = "reports.css";
    $PAGE_TITLE = "[AppTool] - Report";

    include("../includes/templates/header.php");

?>
        <div id="chart">
            <div id="chartHeader">
                <table cellspacing="0" cellpadding="0">
                <tr>
                    <td class="leftCol"><img src="../includes/images/file.gif" alt="Results" width="50" height="50" /></td>
                    <td class="rightCol"><?= $title ?></td>
                </tr>
                </table>
            </div>
            <div id="chartInfo">
<?

    if (isset($_GET['machine']) && $_GET['machine'] != "all") {
        $query_string = "timestamp=" . $_GET['timestamp'] . "&machine=" . $_GET['machine'] . "&type=" . $_GET['type'] . "&metric=" . $_GET['metric'];
    }
    else if (isset($_GET['file']) && $_GET['file'] != "") {
        $query_string = "timestamp=" . $_GET['timestamp'] . "&type=" . $_GET['type'] . "&file=" . $_GET['file'] . "&metric=" . $_GET['metric'];
    }
    else {
        $query_string = "timestamp=" . $_GET['timestamp'] . "&type=" . $_GET['type'] . "&metric=" . $_GET['metric'];
    }
?>
                <iframe id="performance" height="450" width="650" src="graph.php?<?= $query_string ?>"></iframe>
            </div>
        </div>
<?

    include("../includes/templates/footer.php");

?>
