<?php
   
    include("~library/xml2html.php");
    $article_id = "~data/contact.xml";
    if( ! file_exists($article_id)) {
        echo "Article does not exist<br/>";
    } else {
        $generate_text = read_article($article_id);
        echo $generate_text;
    }
?>
