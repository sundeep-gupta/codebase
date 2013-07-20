<?php
    $url = "http://www.cisco.com/pcgi-bin/ecoa/keylabstatus?projectid=$projectid&status=$poststatus";  # this is the real server
//    $url = "http://www.keylabs.com/CertPrograms/cisco2test.php?projectid=$projectid&status=$poststatus";  # test URL
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL,$url);
    curl_setopt($ch, CURLOPT_VERBOSE, 0);
    curl_setopt($ch, CURLOPT_POST, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
//    curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);
    $returned = curl_exec($ch);
    curl_close ($ch);
//Make log entry for Cisco Project ID
    if ($poststatus=="Y") {
      AddLog($newProductPriceList,"CISCO PROJECT ID: ".$projectid." Status: Y",3);
      AddLog(0,"CISCO PROJECT ID: ".$projectid." Status: Y",3);
    } else {
      AddLog(0,"CISCO PROJECT ID: ".$projectid." Status: N",3);
    }
//    echo $returned; exit;

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="HTML Tidy for Windows (vers 1st February 2003), see www.w3.org" name="generator">
    <link rel="stylesheet" href="../graphics/main.css" type="text/css"><!-- <div id=leftfullheight>&nbsp;</div> -->
    <? $titleString = "Status of Post from Cisco PRM"; ?>
    <title>
      <?=$titleString ?>
    </title>
  </head>
  <body>
    <div id="top">
      <div id="header">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="40">
          <tr style="height: 100%">
            <td width="40%" id="menuheaderleft">
              <center>
                <table>
                  <tr valign="middle" align="center">
                    <td>
                      <img src="../graphics/logo.gif" border="0"><br>
                      <b><?=$titleString?>
                      </b>
                    </td>
                  </tr>
                </table>
              </center>
            </td>
          </tr>
        </table>
      </div>
    </div>
    <div id="middlelogin">
      <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="80%" valign="top">
            <br>
            <center>
              <strong><?=$outputMessage?>
              </strong>
            </center>
          </td>
        </tr>
        <tr>
          <td>
              <center><br><br>
      <font face="Arial, Helvetica" size="1">c&nbsp;1996-2005&nbsp;<a href="http://www.keylabs.com">KeyLabs</a>&nbsp; All Rights Reserved.<br>
       385 South 520 West, Lindon, Utah, 84042<br>
       801.852.9500 -- 801.852.9501 (fax)<br></font>
    </center>
          </td>
        </tr>
      </table>
    </div>
  </body>
</html>