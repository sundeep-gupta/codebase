<table border="0" width="100%" id="table5" cellspacing="1" background="images/bkwhite.jpg">
<tr>
<td>
<?php
    include("~library/xml2html.php");
    $article_id = "~data/techspace/content/".$_GET['articleid'];
    if( ! file_exists($article_id)) {
        echo "Article does not exist<br/>";
    }
    else {
        $generate_text = read_article($article_id);
        echo $generate_text."<br/><br/><br/>";
        

    }
?>
<p style='color: #201515;'>
If you have any queries, you can either post them in
<b><a href='/cgi-bin/bubbleforum/YaBB.pl'>Bubble Forum</a></b> or <b><a href='mailto:queries@bubble.co.in'>mail</a></b> them across to us.
Your feedback would be greatly appreciated.<br/><br/>
Thank You <br/>
-- Bubble Team
<br/>
</p>
</table>


