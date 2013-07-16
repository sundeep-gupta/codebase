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


    // Define the following page attributes
    $STYLESHEET = "monitor.css";
    $PAGE_TITLE = "[AppTool] - Performance Monitors";

    include("../includes/templates/header.php");

?>
        <div id="monitorForm">
            <form name="monitor" action="monitor.php?monitor=start" method="POST">            
                <table id="metricTable">
                <tr>
                    <th class="header" colspan="6">Metric Collection:</th>
                </tr>
                <tr>
                    <td class="field"><input name="metrics" type="checkbox" value="proc_stats" /></td>
                    <td class="label">Processor Statistics</td>
                    <td class="field"><input name="metrics" type="checkbox" value="page_swap_stats" /></td>
                    <td class="label">Page/Swap Statistics</td>
                    <td class="field"><input name="metrics" type="checkbox" value="disk_usage" /></td>
                    <td class="label">Disk Usage</td>
                </tr>
                <tr>
                    <td class="field"><input name="metrics" type="checkbox" value="memory_stats" /></td>
                    <td class="label">Memory Statistics</td>
                    <td class="field"><input name="metrics" type="checkbox" value="socket_stats" /></td>
                    <td class="label">Socket Statistics</td>
                    <td class="field"><input name="metrics" type="checkbox" value="load_avg" /></td>
                    <td class="label">Load Average</td>
                </tr>
                <tr>
                    <td class="field"><input name="metrics" type="checkbox" value="network_stats" /></td>
                    <td class="label">Network Statistics</td>
                    <td class="field"><input name="metrics" type="checkbox" value="disk_stats" /></td>
                    <td class="label">Disk Statistics</td>
                    <td class="field"><input name="metrics" type="checkbox" value="file_stats" /></td>
                    <td class="label">File Statistics</td>
                </tr>
                <tr>
                    <td class="field"><input name="metrics" type="checkbox" value="processes" /></td>
                    <td class="label">Processes</td>
                    <td class="field"><input name="metrics" type="checkbox" value="database_stats" /></td>
                    <td class="label">Database Statistics</td>
                    <td class="field"></td>
                    <td class="label"></td>
                </tr>
                <tr>
                    <td colspan="6" style="text-align: left; padding-left: 40px; padding-top: 20px;">
                        <span style="font-weight: bold; font-size: 11px;">0</span> out of <span style="font-weight: bold; font-size: 11px;">0</span> client/server machine(s) were found.
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="text-align: left; padding-left: 40px; padding-top: 10px;">
                        <span style="font-weight: bold; font-size: 11px;">0</span> processes were found.
                    </td>
                </tr>
                </table>
                
                <div style="padding-top: 50px;"><input id="monitorButton" name="submitForm" type="submit" value="Start Monitor" /></div>
            </form>
        </div>
<?

    include("../includes/templates/footer.php");

?>