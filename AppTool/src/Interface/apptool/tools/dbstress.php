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

#
# NOTE:  On Windows machines you need to give the Internet Guest Account (a.k.a. IUSR_MachineName or simply IUSR) read and execute 
#        permission to the command shell program, cmd.exe. Typically, permission to this file is explicitly 
#        denied as a security measure.
#
#

    // Session variables required for monitoring
    session_start();
    ini_set('max_execution_time','0');   // TODO: setup AJAX to eliminate timeouts

    include("../config.inc.php");
    include("modules/config.php");
    include("modules/logger.php");
    include("modules/reports.php");
    include("modules/validator.php");
    include("modules/stress.php");
    include("adodb/adodb.inc.php");
    
    
    // Define the following page attributes
    $STYLESHEET = array("forms.css", "progressbar.css");
    $PAGE_TITLE = "[AppTool] - Database Stress Test";

    include("../includes/templates/header.php");

?>
        <div id="standardForm">
<?

    if (isset($_GET['stress']) && $_GET['stress'] == "start") {
        if (empty($_POST['select_threads']) && empty($_POST['insert_threads']) && empty($_POST['update_threads'])) {
?>
            <span style="font-weight: bold;">All your thread values are empty. Please select a thread value and try again.</span>
<?
        }
        else {
?>
            <div id="status1" class="statusbox" style="z-index:1; top: 90px;">
                <p style="font-size: 14px; font-weight: bold; padding-top: 10px;">Database Stress Test</p>
                <p style="padding-top: 25px;">Performing stress test for <span style="font-weight: bold;"><?= $myConfig->DB_DRIVER ?>.<?= $myConfig->DB_NAME ?></span> on <span style="font-weight: bold;"><?= $myConfig->DB_SERVER ?></span></p>
                <div style="padding-top: 20px;">
                    <form name="clockform">
                        <table cellspacing="1" cellpadding="1">
                        <tr>
                            <td style="font-weight: bold;">Elapsed Time (secs):</td>
                            <td><input name="clocktimer" type="text" size="10" readonly="readonly" /><script type="text/javascript">startclock();</script></td>
                            <td style="padding-left: 15px;"><button>Stop Stress Test</button></td>
                        </tr>
                        </table>
                    </form>
                        
                    <form name="statusform">
                        <div style="padding-top: 10px;">&nbsp;</div>
                        
                        <table cellspacing="1" cellpadding="1">
                        <tr>
                            <td style="font-weight: bold; width: 230px; text-align: left; padding-left: 15px;">Query Time - Selects (secs):</td>
                            <td><input name="select_query_time" type="text" size="10" readonly="readonly" /></td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold; width: 230px; text-align: left; padding-left: 15px;">Query Time - Inserts (secs):</td>
                            <td><input name="insert_query_time" type="text" size="10" readonly="readonly" /></td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold; width: 230px; text-align: left; padding-left: 15px;">Query Time - Updates (secs):</td>
                            <td><input name="update_query_time" type="text" size="10" readonly="readonly" /></td>
                        </tr>
                        </table>
                    </form>
                </div>
            </div>
            
            <div class="mailbar">
                <div class="baritems"> 
<?
            // Before we begin, let's create our results directory.
            $startTime = time();
            $resultsDir = $myReports->createResultsDir($startTime);

            // Start our stress tests
            // NOTE: The stress test Perl scripts should start, run in the background and stop automatically based upon
            //       the TEST_TIME_LENGTH value in the configuration INI file
            if (isset($_POST['select_threads']) && $_POST['select_threads'] > 0) {
                $sql_file = $stressTest->fetchSqlFile("select");
                $attrs = "--t=" . $_POST['select_threads'] . " --f=" . $sql_file;
                $stressTest->callTool($myConfig->TOOL_PATH, "dbstress.pl", $attrs);
            }
            if (isset($_POST['insert_threads']) && $_POST['insert_threads'] > 0) {
                $sql_file = $stressTest->fetchSqlFile("insert");
                $attrs = "--t=" . $_POST['insert_threads'] . " --f=" . $sql_file;
                $stressTest->callTool($myConfig->TOOL_PATH, "dbstress.pl", $attrs);
            }
            if (isset($_POST['update_threads']) && $_POST['update_threads'] > 0) {
                $sql_file = $stressTest->fetchSqlFile("update");
                $attrs = "--t=" . $_POST['update_threads'] . " --f=" . $sql_file;
                $stressTest->callTool($myConfig->TOOL_PATH, "dbstress.pl", $attrs);
            }
            if (isset($_POST['delete_threads']) && $_POST['delete_threads'] > 0) {
                $sql_file = $stressTest->fetchSqlFile("delete");
                $attrs = "--t=" . $_POST['delete_threads'] . " --f=" . $sql_file;
                $stressTest->callTool($myConfig->TOOL_PATH, "dbstress.pl", $attrs);
            }
            
            // Define the following variables
            $elapsedTime       = 1;
            $currentTime       = 0;
            $lastTimeValue     = 0;
            $elapsed           = 0;
            $intervalElapsed   = 0;
            
            $loop              = "true";
            $select_query_time = "N/A";
            $insert_query_time = "N/A";
            $update_query_time = "N/A";
            
            // Send message to log file
            $myLogger->logEvent("[" . $startTime . "]: DB-Stress is starting.");
            $myLogger->logEvent("[" . $startTime . "]: Connecting to [" . $myConfig->DB_DRIVER . "." . $myConfig->DB_NAME . "] on " . $myConfig->DB_SERVER);
            
            // Flush all buffers
            ob_end_flush();
            flush();
            
            // Total loops required. This is used to calculate how many percentages to advance per loop,
            // So it needs to be known before looping and progressbar starts
            $loopsize = $myConfig->TEST_TIME_LENGTH;
            
            // Calculate how many percents to advance per loop
            $percent_per_loop = 100 / $loopsize;
            
            // Preset variable to remember the percentage of the previous loop
            $percent_last = 0;
            
            // BEGIN:
            while ($elapsedTime <= $myConfig->TEST_TIME_LENGTH) {
                
                // Here is the actual command(s) to execute during each loop. Our page
                // Uses the sleep(1) function to show a delay.
                sleep(1);
                
                // Here are the commands to calculate the advance in percentages and print out the necessary progress
                // By flushing out images and an optional div showing the percentage in numbers
                $percent_now = round($elapsedTime * $percent_per_loop);
                if ($percent_now != $percent_last) {
?>
                    <span class="percentbox" style="z-index: <?php echo $percent_now; ?>; top: 350px;"><?php echo $percent_now; ?> %</span>
<?
        	   		$difference = $percent_now - $percent_last;
                    for($j=1;$j<=$difference;$j++) {
?>
                    <img src="<?= $myConfig->BASEURL ?>includes/images/progressbar-single.gif" border="0" />
<?
                    }
                    $percent_last = $percent_now;
                }
                
                // Finally, flush the output of this loop, advancing the progressbar as needed
                flush();
                
                // Find out out time values
                $currentTime = time();
                if ($elapsedTime == 1) {
                    $elapsed = $currentTime - $startTime;
                }
                else {
                    $elapsed = $currentTime - $lastTimeValue;
                }
                $elapsedTime += $elapsed;
                $lastTimeValue = $currentTime;
                
                // Output our updated stats
                $intervalElapsed++;
                if ($intervalElapsed == $myConfig->{'INTERVAL'}) {
                    if ($_POST['select_threads'] > 0) {
                        $select_query_time = $stressTest->fetchQueryTime("select");
                    }
                    if ($_POST['insert_threads'] > 0) {
                        $insert_query_time = $stressTest->fetchQueryTime("insert");
                    }
                    if ($_POST['update_threads'] > 0) {
                        $update_query_time = $stressTest->fetchQueryTime("update");
                    }
                    $intervalElapsed = 0;
                }
?>
                    <script language="javascript" type="text/javascript">
                        function updateStats() {
                            document.statusform.select_query_time.value = "<?= $select_query_time ?>";
                            document.statusform.insert_query_time.value = "<?= $insert_query_time ?>";
                            document.statusform.update_query_time.value = "<?= $update_query_time ?>";
                        }
                        // Update our progress stats
                        updateStats();
                    </script>
<?
            }
?>
                </div>
            </div>
            
            <div style="padding-top: 230px;">&nbsp;</div>
<?
        }
    }
    else {

?>
            <form name="dbstressConfig" action="dbstress.php?stress=start" method="POST">
                <table class="defaultForm" cellspacing="1" cellpadding="1">
                <tr>
                    <th class="header" colspan="2">Database Stress Test Configuration</th>
                </tr>
                <tr>
                    <td class="leftCol">Select Threads:</td>
                    <td class="rightCol"><input name="select_threads" type="text" size="10" maxlength="3" value="0" /></td>
                </tr>
                <tr>
                    <td class="leftCol">Insert Threads:</td>
                    <td class="rightCol"><input name="insert_threads" type="text" size="10" maxlength="3" value="0" /></td>
                </tr>
                <tr>
                    <td class="leftCol">Update Threads:</td>
                    <td class="rightCol"><input name="update_threads" type="text" size="10" maxlength="3" value="0" /></td>
                </tr>
                </table>
                
                <div style="padding-top: 40px;"><input name="submitForm" type="submit" value="Start Stress Test" /></div>
            </form>
<?

    }

?>
        </div>
        
        <!-- NOTE: Since all of our code has executed, let's stop our javascript functions -->
        <script type="text/javascript">stopclock();</script>

    </div>
    
    <div id="pageFooter">
        <span id="copyright">Copyright &copy;<script language="javascript" type="text/javascript">showYear();</script> - AppLabs, Inc.</span>
    </div>
</div>

</body>
</html>
