<?php  
    $grt_dir  = "/srv/www/htdocs/~data/celebrate";
    $greeting = $_GET['id'];
    $grt_file = "$grt_dir/$greeting.txt";
echo $grt_file;
if (file_exists($grt_file)) {
    $fh            = fopen($grt_file,"r");
    $generate_text = '';
    while (!feof($fh)) {
        $generate_text .= fread($fh,1024);
    }
    fclose($fh);

} else {
    $f_name = $_POST['f_name'];
    $f_mail = $_POST['f_mail'];
    $t_name = $_POST['t_name'];
    $t_mail = $_POST['t_mail'];
    
    $subject = "Bubble Greetings from $f_name";
    $message = $_POST['message'];
    $headers = "From: $f_mail";
    $headers = $headers."\r\n Content-Type: text/html;"."\r\n" ;

    if ($t_mail and  $message and $message != '') {
        #
        # Store the message into a file
        #
	$filename = time();
        $filename = "$grt_dir/$filename.txt";
	echo "Creating $filename";
        if (!($fh = fopen($filename,"w"))) {
	    echo "Cannot open file";
	} elseif (!(fwrite($fh, $message))){
	    echo "Cannot write to file";
	}else {
	    echo "File Succesfully Created";
	}
        fclose($fh);
	if (file_exists($filename)) {
	    echo "File $filename created";
	}
        $rc = mail($to,$subject,$message,$headers);
        if ($rc == 1) {
            echo "<table width = '100%'><tr><td align='center'>";
            echo '<font color="green"> <b>';
            echo 'Your wishes has been sent succesfully.';
            echo '</b></font>';
            echo "</td></tr></table>";
        } else {
            echo "<table width = '100%'><tr><td align='center'>";
            echo '<font color="red"> <b>';
            echo 'Oops!!! Error sending mail. Please try again.';
            echo '</b></font>';
            echo "</td></tr></table>";
        }
    }

    include("~library/xml2html.php");
    $celebrate_form = "~data/celebrate.xml";
   
    if( ! file_exists($celebrate_form)) {
        $generate_text = "Form does not exist<br/>";
    } else {
        $generate_text = read_article($celebrate_form);
    }
}
?>
<table>
<tr>
<td valign='center' align='center'> 
<img src="images/celebrate/newyear_1.jpg"/>
</td>
</tr>
<tr>
<td>
        <?php echo $generate_text ?>
</td>
</tr>

</table>
