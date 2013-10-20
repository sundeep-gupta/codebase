<?php
function read_comments ($article_id) {
    global $comment_text;
    if(! ($xmlparser = xml_parser_create())){
        die('Cannot create xml parser');
    } else {
        xml_set_element_handler($xmlparser,"comment_start_tag","comment_end_tag");
        xml_set_character_data_handler($xmlparser,"comment_tag_contents");
        
        if( ! ($fp = fopen( $article_id, "r") ) ) {
            die ("Cannot open :".$article_id);
        }
        while ($data = fread($fp, 4096)){
            $data=eregi_replace(">"."[[:space:]]+"."< ",">< ",$data);
            if (!xml_parse($xmlparser, $data, feof($fp))) {
                $reason = xml_error_string(xml_get_error_code($xmlparser));
                $reason .= xml_get_current_line_number($xmlparser);
                die($reason);
            }
        }
        xml_parser_free($xmlparser); 
    }
    return $comment_text;
}

function comment_start_tag ($parser,$name,$attribute) {
    global $comment_text, $comment_x2h_start, $user_row;
    switch ($name) {
    case "COMMENTS" :
        $comment_text = $comment_text. $comment_x2h_start[$name];
        break;
    case "COMMENT":
        $comment_text = $comment_text. $comment_x2h_start[$name];
        if(is_array($attribute)) {
            $comment_text = $comment_text. (($attribute["USER"])?$attribute["USER"]:"anonymous");
            $comment_text = $comment_text. (($attribute["DATE"])?$attribute["DATE"]:"");
        } else {
            $comment_text = $comment_text."anonymous";
        }
        $user_row = 1;
        break;
    default:
        $xml_to_html_text = $xml_to_html_text. 'Current Tag: '. $name. "<br/>";
        if(is_array($attribute)) {
            while( list($keys,$value) = each($attribute)) {
                $xml_to_html_text = $xml_to_html_text."Key: $keys Value: $value <br />";
            }
        }    
    }
}

function comment_end_tag ($parser,$name) {
    global $comment_text,$comment_x2h_end,$user_row;
    $name = strtoupper($name);
    switch ($name) {
    case "COMMENTS" :
        $comment_text = $comment_text. $comment_x2h_end[$name];
        break;
    case "COMMENT":
        $comment_text = $comment_text. $comment_x2h_end[$name];
        break;
    default:
#        $comment_text = $comment_text. 'Reached end of tag '.$name;
    }
}

function comment_tag_contents ($parser, $data) {
    global $comment_text,$user_row;
    $data =  preg_replace("/\[NL\]/","<br/>",$data);
    $data = preg_replace("/\[\[NNLL\]\]/","[NL]",$data);
#    $data = "</td></td><tr bgcolor='#bbbbbb'><td>".$data.'<br/><br/></td></tr>';
#    echo "DATA:".$data;
    if($user_row === 1) {
        $comment_text = $comment_text."</td></td><tr bgcolor='#bbbbbb'><td>";
        $comment_text = $comment_text.$data;
        $comment_text = $comment_text.'<br/><br/></td></tr>' ;
        $user_row = 0;
    }
}
?>