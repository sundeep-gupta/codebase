<?php
    #
    # Check if the user has given the wishes
    #
    # Write to the celeb file and then proceed with displaying
    # the wishes.
    
    include("~library/xml2html.php");
    $article_id = "~data/ebook.xml";
    if( ! file_exists($article_id)) {
        echo "Article does not exist<br/>";
    } else {
        $generate_text = read_article($article_id);
        echo $generate_text;
    }
?>
<!--
<center><img src='images/Under_Construction.jpg'></img></center>
-->