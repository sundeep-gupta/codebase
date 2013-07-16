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
    if (!isset($_GET['timestamp']) || empty($_GET['timestamp'])) {
        echo "ERROR: Image not generated!";
        exit;
    }
    
    // Define the following
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
    $datapoints = $myReports->file2array($results_file);
    array_shift($datapoints);
    
    // We'll be outputting a GIF
    header("Content-type: image/gif");

    // Dynamically create our chart
    $chart =& new PHPlot();
    $chart->SetDataType("linear-linear");
    $data = array();
    foreach($datapoints as $record_set) {
        $row = explode(",", $record_set);
        $elapsed_time = $row[0];
        $metric = $row[$_GET['metric'] + 1];
        array_push($data, array("", $elapsed_time, $metric));
    }
    $chart->SetDataValues($data);
    $title = "Report for " . $_GET['timestamp'];
    $chart->SetTitle($title);
    
    //Define the X axis
    $chart->SetXLabel("Elapsed Time (secs.)");
//    $graph->SetHorizTickIncrement("5");
//    $chart->SetXGridLabelType("plain");
    
    //Define the Y axis
    $chart->setYLabel($metric_type);
//    $graph->SetVertTickIncrement("500");
//    $graph->SetPrecisionY("0");
//    $chart->SetYGridLabelType("right");
    
    // Draw our graph
    $chart->DrawGraph();


?>
