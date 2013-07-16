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
    $STYLESHEET = "forms.css";
    $PAGE_TITLE = "[AppTool] - Tools";

    include("../includes/templates/header.php");

?>
        <div id="standardForm">
            <form name="networkDiscovery" action="discovery.php?discover=true" method="POST">
                <table class="defaultForm" cellspacing="1" cellpadding="1">
                <tr>
                    <th class="header" colspan="2">Tools</th>
                </tr>
                <tr>
                    <td class="leftCol">Network Discovery:</td>
                    <td class="rightCol"><input name="submitForm" type="submit" value="Network Discovery" /></td>
                </tr>
                </table>
            </form>
            
            <form name="databaseStress" action="dbstress.php" method="POST">
                <table class="defaultForm" cellspacing="1" cellpadding="1">
                <tr>
                    <td class="leftCol">Database Stress Test:</td>
                    <td class="rightCol"><input name="submitForm" type="submit" value="Stress Database" /></td>
                </tr>
                </table>
            </form>
        </div>
<?

    include("../includes/templates/footer.php");

?>
