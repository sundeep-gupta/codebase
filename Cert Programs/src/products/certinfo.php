<?
	include_once("session.php");
	include_once("../cert_functions.php");
	
	$companyID = $_GET["cid"];
	
	$titleString = "Product Select";
	$activetab = "products";
	
	if ($_POST['poster'] == 1) {
		$_SESSION["pid"] = $_POST["pid"];
		$_SESSION["tid"] = $_POST["TechnicalID"];
		$_SESSION["tfid"] = $_POST["timeframe"];
		$_SESSION["comment"] = $_POST["comment"];
		$_SESSION["paymentMethod"] = $_POST["paymentMethod"];
		$_SESSION["mta"] = $_POST["mta"];
		$_SESSION["cid"] = $companyID;
		
		header("Location: certlist.php");
		exit;
	}

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>KeyLabs Certification System</title>
 
  <link rel="stylesheet" href="../../graphics/main.css" type="text/css">
  <link rel="stylesheet" href="../../graphics/menuExpandable3.css" type="text/css">
  <script src="../graphics/menuExpandable3.js"></script>
  <!-- this needs to be the last css loaded -->
  <!--[if IE 6]>
  <link rel="stylesheet" href="graphics/ie6.css" type="text/css">
  <![endif]-->
  <!-- this needs to be the last css loaded -->
<script language="javascript">
var arrow_up = new Image();
  arrow_up.src = '../graphics/arrow-up.gif';
var arrow_down = new Image();
  arrow_down.src = '../graphics/arrow-down.gif';  

function show_div(div_id) {
	// show the requested div
	document.getElementById(div_id).style.display = 'block';
} 

function hide_div(div_id) {
	document.getElementById(div_id).style.display = 'none';
}

function div_toggle(div_id) {
	if (document.getElementById(div_id).style.display == 'none') {
		document.getElementById(div_id).style.display = 'block';
		document["Arrow"+div_id].src = arrow_up.src;
	}
	else {
		document.getElementById(div_id).style.display = 'none';		
		document["Arrow"+div_id].src = arrow_down.src;
	}
}

</script>
<script type="text/javascript">
	function changeContact(type) {
        var contact;

        url = "../changeContact.php";
        //find the correct item's id field and get the value from it
        if (type=='submission') {
            contact = document.getElementById('SubmissionID').value;
            url = url + "?type=submission&companyID=$companyID?>&id=" + contact;
        } else {
            contact = document.getElementById('TechnicalID').value;
			url = url + "?type=technical&companyID=<?=$companyID?>&id=" + contact;
        }
        contact = window.open(url, "contactWindow", "dependent,hotkeys=no,menubar=no,personalbar=no,scrollbars=yes,status=no,titlebar=no,toolbar=no,height=480,width=640");
        //contact = window.open(url, "contactWindow", "hotkeys=no,menubar=yes,personalbar=no,scrollbars=yes,status=yes,titlebar=no,toolbar=no");
    }

	function MTA(p) {
        var contact;

        url = "mta.php?p="+p;
        //find the correct item's id field and get the value from it
        mta = window.open(url, "MTAwindow", "dependent,hotkeys=no,menubar=no,personalbar=no,scrollbars=yes,status=no,titlebar=no,toolbar=no,height=480,width=640");
        //contact = window.open(url, "contactWindow", "hotkeys=no,menubar=yes,personalbar=no,scrollbars=yes,status=yes,titlebar=no,toolbar=no");
    }
</script>  
</head>
<body>
  <div id=leftfullheight>&nbsp;</div>
  <div id=top>
    <div id=header>
      <? include("header.php"); ?>
    </div>
  </div>
  <div id=middle style="width:100%">
    <div id=middle2>
      <div id=left>
        <? include("productmenu.php"); ?>
      <ul>
        <li>Choose a technical contact from your company.</li>
        <li>Enter comments as necessary with special instructions like standard testing, remote testing, on-site testing, indicate whether you are sending an engineer to KeyLabs, etc.</li>
      </ul>
      </div>
	  
      <div id=right>
		<!-- content should be in <p> tags to prevent the ie 3 pixel bug described on http://www.positioniseverything.net/explorer/threepxtest.html -->
		<? include("productfunctions.php"); ?>
        <br>
		
	  		<form action="" method="post" name="form1">
			<div align="center">
			
			<?php //GenerateCertList(); ?>
			
			
			<div align="center">
				<div class="greyboxheader" align=left>
					<b>Testing Details </b>
				</div>		
			
		      <div class="greybox">
			  

			  
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td colspan="2"><div align="left"><strong>Technical Contact
                      <input type=hidden id=TechnicalID name=TechnicalID value=<?=$cert[0]["techID"]?>>
                  </strong></div></td>
                  <td width="75%"><div align="center"> </div></td>
                </tr>
			    <tr>
                  <td align="center" colspan="3"><br><div class="whitebox" align=left>To help us better serve you, who will be the technical contact for your product?</div><br></td>
                </tr>				
                <tr>
                  <td width="5%">&nbsp;</td>
                  <td width="20%"><div align="right">Technical Contact Name:</div></td>
                  <td><p class=<?=($cert[0]["techName"]=="")?"rotextnone":"rotext"?> id="Technical Name">
						<?=($cert[0]["techName"]=="")? "None" : $cert[0]["techName"]?></p>
                  </td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td><div align="right">Technical Contact Email:</div></td>
                  <td><p class=<?=($cert[0]["techEmail"]=="")?"rotextnone":"rotext"?> id="Technical Email">
						<?=($cert[0]["techEmail"]=="")? "None" : $cert[0]["techEmail"]?></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td><div align="right">Technical Contact Phone:</div></td>
                  <td><p class=<?=($cert[0]["techPhone"]=="")?"rotextnone":"rotext"?> id="Technical Phone">
						<?=($cert[0]["techPhone"]=="")? "None" : $cert[0]["techPhone"]?></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td><a href="#" onclick="changeContact('technical')">Select Contact</a></td>
                </tr>
              </table>

              <p>&nbsp;</p>
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td colspan="2"><div align="left"><strong>Payment Method</strong></div></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><br><div class="whitebox" align=left>How would you like to pay for testing?</div><br></td>
                </tr>
                <tr>
                  <td width="25%">&nbsp;&nbsp; <div align="right">Payment Method: </div></td>
                  <td width="75%">
                    <select name="paymentMethod" style="width: 323px">
						        <?
        							$payment = GetPayments();
        							$paymentcnt = count($payment);
        						    for($x=0;$x<$paymentcnt;$x++)
        						        printf("<option value=%d%s>%s</option>",
        						                $payment[$x]["id"],
        						                ($payment[$x]["method"] == $cert[0]["method"]) ? " selected" : "",
        						                $payment[$x]["method"]);
        						?>
        						</select>
                  </td>
                </tr>
                <tr>
                  <td colspan="2">&nbsp;</td>
                </tr>
              </table>

              <p>&nbsp;</p>
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td colspan="2"><div align="left"><strong>Testing MTA</strong></div></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><br><div class="whitebox" align=left>You must agree to the KeyLabs Master Test Agreement (MTA) before testing can proceed.<br><br>If you get pushed back to this page when you click "Next" make sure that the "I agree" checkbox below is checked.</div><br></td>
                </tr>
                <tr>
                  <td width="25%">&nbsp;&nbsp; <div align="right"><a href="" onclick="MTA('7')">KeyLabs Master Test Agreement</a></div></td>
                  <td width="75%"><input type=checkbox name="mta" value="" size=75>I agree.</td>
                </tr>
                <tr>
                  <td colspan="2">&nbsp;</td>
                </tr>
              </table>

              <p>&nbsp;</p>
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td colspan="2"><div align="left"><strong>Testing Timeframe </strong></div></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><br><div class="whitebox" align=left>To help us better serve you, in what timeframe would you like to see this start testing?</div><br></td>
                </tr>
                <tr>
                  <td width="25%">&nbsp;&nbsp; <div align="right">Testing Timeframe: </div></td>
                  <td width="75%"><?php Timeframe("timeframe"); ?></td>
                </tr>
                <tr>
                  <td colspan="2">&nbsp;</td>
                </tr>
              </table>

              <p>&nbsp;</p>
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td colspan="2"><div align="left"><strong>Comments, instructions, etc</strong></div></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><br><div class="whitebox" align=left>Let us know any special instructions you have.</div><br></td>
                </tr>
                <tr>
                  <td width="25%">&nbsp;&nbsp; <div align="right">Instructions: </div></td>
                  <td width="75%"><input type=text name="comment" value="" size=75></td>
                </tr>
                <tr>
                  <td colspan="2">&nbsp;</td>
                </tr>
              </table>

			  </div>
		  </div>

		<div class="greyboxheader" align=right><span class="greyboxfooter">
		  <input name="pid" type="hidden" id="pid" value="<?=$_GET["pid"]; ?>">
		  <input name="poster" type="hidden" value="1">
		</span>
		<table width=100% cellspacing=0 cellpadding=0>
		  <tr>
		    <td align=right>
			     <input name="submit" type="submit" value="Next ->">
			 </td>
		  </tr>
		</table>
			   
		</div>

				</form>		
		  </div>
	
	  </div>
    </div>
  </div>
</body>
</html>
