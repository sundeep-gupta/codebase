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
    include("modules/validator.php");


    // Define the following page attributes
    $STYLESHEET = "forms.css";
    $PAGE_TITLE = "[AppTool] - Tool Configuration";

    include("../includes/templates/header.php");

?>
        <div id="standardForm">
            <form name="config" action="index.php?edit_ini=true" method="POST">
                <div id="formMsg">
<?

    // Fetch our configuration INI parameters and values
    $config_ini = $myReports->getConfigInfo();

    // If there was a POST, perform the following
    if (isset($_GET['edit_ini']) && $_GET['edit_ini'] != "") {
        // Perform form validation
        $myForm->isEmpty("db_driver", "Please select a database driver.");
        $myForm->isEmpty("db_server", "Please enter in the IP address of the database server to connect to.");
        $myForm->isEmpty("db_name", "Please enter in a database name to connect to.");
        $myForm->isEmpty("db_user", "Please enter in the database user to connect with.");
        $myForm->isEmpty("db_password", "Please enter in the password of the database user.");
        $myForm->isEmpty("interval", "Please enter in a valid interval time in seconds.");
        $myForm->isEmpty("test_time_length", "Please enter in a valid test time length in seconds.");
        
        if ($myForm->isError()) {
            echo $myForm->displayErrorList();
        }
        else {
            // Update our values
            $config_ini['DATABASE']['DB_DRIVER']      = $_POST['db_driver'];
            $config_ini['DATABASE']['DB_SERVER']      = $_POST['db_server'];
            $config_ini['DATABASE']['DB_NAME']        = $_POST['db_name'];
            $config_ini['DATABASE']['DB_USER']        = $_POST['db_user'];
            $config_ini['DATABASE']['DB_PASSWORD']    = $_POST['db_password'];
            $config_ini['GLOBAL']['INTERVAL']         = $_POST['interval'];
            $config_ini['GLOBAL']['TEST_TIME_LENGTH'] = $_POST['test_time_length'];
            
            // Since there are no errors, edit our configuration INI file
            $retval = $myReports->write_ini_file($config_ini);
            if (isset($retval) && $retval == true) {
                echo "The configuration INI file was successfully edited.";
            }
            else {
                echo "The edit of the configuration INI file failed. Please contact your system administrator for more details.";
            }
        }
    }
    
?>
                </div>

                <table id="globalForm" cellspacing="1" cellpadding="1">
                <tr>
                    <th class="header" colspan="2">Global</th>
                </tr>
                <tr>
                    <td class="leftCol">Interval Time (secs.):</td>
                    <td class="rightCol">
                        <input name="interval" type="text" size="20" maxlength="30" value="<?= (isset($config_ini['GLOBAL']['INTERVAL']) && $config_ini['GLOBAL']['INTERVAL'] != "") ? $config_ini['GLOBAL']['INTERVAL'] : "" ?>" />
                    </td>
                </tr>
                <tr>
                    <td class="leftCol">Test Time Length (secs.):</td>
                    <td class="rightCol">
                        <input name="test_time_length" type="text" size="20" maxlength="30" value="<?= (isset($config_ini['GLOBAL']['TEST_TIME_LENGTH']) && $config_ini['GLOBAL']['TEST_TIME_LENGTH'] != "") ? $config_ini['GLOBAL']['TEST_TIME_LENGTH'] : "" ?>" />
                    </td>
                </tr>
                </table>
                
                <table id="configForm" cellspacing="1" cellpadding="1">
                <tr>
                    <th class="header" colspan="2">Database</th>
                </tr>
                <tr>
                    <td class="leftCol">Database Driver:</td>
                    <td class="rightCol">
                        <select name="db_driver">
                            <option value="">-- Select --</option>
                            <option value="db2"<?= (preg_match("/db2/i", $config_ini['DATABASE']['DB_DRIVER'])) ? " SELECTED" : "" ?>>DB2</option>
                            <option value="mysqli"<?= (preg_match("/mysql/i", $config_ini['DATABASE']['DB_DRIVER'])) ? " SELECTED" : "" ?>>MySQL</option>
                            <option value="oracle"<?= (preg_match("/oracle/i", $config_ini['DATABASE']['DB_DRIVER'])) ? " SELECTED" : "" ?>>Oracle</option>
                            <option value="postgres"<?= (preg_match("/postgres/i", $config_ini['DATABASE']['DB_DRIVER'])) ? " SELECTED" : "" ?>>PostgreSQL</option>
                            <option value="mssql"<?= (preg_match("/mssql/i", $config_ini['DATABASE']['DB_DRIVER'])) ? " SELECTED" : "" ?>>SQL Server</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="leftCol">Database Server:</td>
                    <td class="rightCol">
                        <input name="db_server" type="text" size="20" maxlength="30" value="<?= (isset($config_ini['DATABASE']['DB_SERVER']) && $config_ini['DATABASE']['DB_SERVER'] != "") ? $config_ini['DATABASE']['DB_SERVER'] : "" ?>" />
                    </td>
                </tr>
                <tr>
                    <td class="leftCol">Database Name:</td>
                    <td class="rightCol">
                        <input name="db_name" type="text" size="20" maxlength="30" value="<?= (isset($config_ini['DATABASE']['DB_NAME']) && $config_ini['DATABASE']['DB_NAME'] != "") ? $config_ini['DATABASE']['DB_NAME'] : "" ?>" />
                    </td>
                </tr>
                <tr>
                    <td class="leftCol">Database User:</td>
                    <td class="rightCol">
                        <input name="db_user" type="text" size="20" maxlength="30" value="<?= (isset($config_ini['DATABASE']['DB_USER']) && $config_ini['DATABASE']['DB_USER'] != "") ? $config_ini['DATABASE']['DB_USER'] : "" ?>" />
                    </td>
                </tr>
                <tr>
                    <td class="leftCol">Database Password:</td>
                    <td class="rightCol">
                        <input name="db_password" type="text" size="20" maxlength="30" value="<?= (isset($config_ini['DATABASE']['DB_PASSWORD']) && $config_ini['DATABASE']['DB_PASSWORD'] != "") ? $config_ini['DATABASE']['DB_PASSWORD'] : "" ?>" />
                    </td>
                </tr>
                </table>
                
                <div style="padding-top: 25px; padding-bottom: 20px;"><input name="submitForm" type="submit" value="Submit" /></div>
            </form>
            
            <div style="padding-top: 5px; padding-bottom: 5px;"><hr style="width: 600px;" /></div>
            
            <form name="machines" action="machines.php" method="POST">
                <table class="defaultForm" cellspacing="1" cellpadding="1">
                <tr>
                    <th class="header" colspan="2">Machines</th>
                </tr>
                <tr>
                    <td class="leftCol">Clients/Servers:</td>
                    <td class="rightCol"><input name="submitForm" type="submit" value="Setup Machines" /></td>
                </tr>
                </table>
            </form>
            
            <form name="processes" action="processes.php" method="POST">
                <table class="defaultForm" cellspacing="1" cellpadding="1">
                <tr>
                    <th class="header" colspan="2">Processes</th>
                </tr>
                <tr>
                    <td class="leftCol">Process List:</td>
                    <td class="rightCol"><input name="submitForm" type="submit" value="Setup Process List" /></td>
                </tr>
                </table>
            </form>
        </div>
<?

    include("../includes/templates/footer.php");

?>