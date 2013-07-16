<?php
    $subject = $_POST['subject'];
    $message = $_POST['message'];
    $to      = "queries@bubble.co.in";
    $from    = $_POST['from'];
    $headers = "From: $from" . "\r\n" ;
    if ($to && $subject && $message && $subject != '' && $message != '') {
        $rc = mail($to,$subject,$message,$headers);
        if ($rc == 1) {
            echo "<table width = '100%'><tr><td align='center'>";
            echo '<font color="green"> <b>';
            echo 'Your mail has been sent succesfully.';
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
    $article_id = "~data/contact.xml";
    if( ! file_exists($article_id)) {
        echo "Article does not exist<br/>";
    } else {
        $generate_text = read_article($article_id);
        echo $generate_text;
    }
?>