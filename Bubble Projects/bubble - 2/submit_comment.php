<?php
	echo $_POST['Host'];
    $file = "articles/_private/comments/".$_POST['articleid'];
    $date = date('d-M-Y');
    $comment = preg_replace("/\[NL\]/","[[NNLL]]",$_POST["comment"]);
    $comment = preg_replace("/\\n/","[NL]",$comment);
    $comment = preg_replace("/\s+\[NL\]/","[NL]",$comment);
    $new_comment = "\n<comment user='Anonymous' date='$date'>".$comment."</comment>";
    $file_contents = '';
    if(file_exists($file)) {
	echo $file. 'Found';
        $file_handle = @fopen($file, "r") or die("Couldn't open file $file reason: $@" );
        $file_contents = fread($file_handle, filesize($file));
        $regex = "<\/comments>";
        $file_contents = preg_replace("/$regex/",$new_comment."</comments>",$file_contents);
        fclose($file_handle);
        unlink($file);
	$file_handle = @fopen($file."t","w") or die ("Could not open file $file reason: $php_errormsg");
	fwrite($file_handle,$file_contents);
        fclose($file_handle);
    } else {
        $file_contents = "<comments>\n$new_comment\n</comments>";
	$file_handle = @fopen($file."t","w") or die ("Could not open file $file reason: $php_errormsg");
        fwrite($file_handle,$file_contents);
        fclose($file_handle);
    }
    
  
#    rename($file."1",$file);
    header("Location: http://".$_SERVER[HTTP_HOST] ."/display_article.php?articleid=".$_POST['articleid'],0,302);
    
?>