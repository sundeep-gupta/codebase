<?php
$xml_to_html_text = "";
$comment_text = "";
$user_row = 0;
$section_depth = 0;
$table_alt_colors;
$table_depth = 0;
include('~library/conf.php');
/*
 * parses the xml file and prepares the equivalent html content for it.
 * INPUT: $article_id is the name of the xml file to be parsed.
 */
function read_article ($article_id) {
    global $xml_to_html_text;
    if(! ($xmlparser = xml_parser_create())){
        die('Cannot create xml parser');
    } else {
        xml_set_element_handler($xmlparser,"article_start_tag","article_end_tag");
        xml_set_character_data_handler($xmlparser,"article_tag_contents");
        
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
    return $xml_to_html_text;
}

/*
 * The callback routine called by the xml parser during the parsing of the
 * article.
 * INPUT: $parser
 *        $name - name of the xml element
 *        $attribute - associative array of the attributes.
 */
function article_start_tag ($parser,$name,$attribute) {
    global $xml_to_html_text, $x2h_start, $section_depth, $table_alt_colors,
            $table_depth;
    $name = strtoupper($name);
    switch ($name) {
    case "ARTICLE" :
    case "ARTICLES" :
        break;

    case "TITLE":
        $xml_to_html_text = $xml_to_html_text. $x2h_start[$name];
        break;

    case "AUTHOR":
        $xml_to_html_text = $xml_to_html_text. $x2h_start[$name];
        break;

    case "DATE":
        $xml_to_html_text = $xml_to_html_text. $x2h_start[$name];
        break;
    
    case "CONTENT":
        $xml_to_html_text = $xml_to_html_text. $x2h_start[$name];
        break;
        
    case "B":
        $xml_to_html_text = $xml_to_html_text. $x2h_start[$name];
        break;
    
    case "P":
        $xml_to_html_text = $xml_to_html_text. $x2h_start[$name];
        if(is_array($attribute) and 
             array_key_exists('COLOR',$attribute) ) {
                $xml_to_html_text = preg_replace('/\*color\*/',$attribute['COLOR'],$xml_to_html_text);
            
        } else {
            $xml_to_html_text = preg_replace('/\*color\*/','black',$xml_to_html_text);
        }
        break;
    case "CODE":
        $xml_to_html_text = $xml_to_html_text. $x2h_start[$name];

        break;
 
   case "IMAGE":
        $xml_to_html_text = $xml_to_html_text.$x2h_start[$name];
        if(is_array($attribute)) {
           while( list($keys,$value) = each($attribute)) {
                switch ($keys) {
                case "SRC":
                    $xml_to_html_text = $xml_to_html_text."Key: $keys Value: $value <br />";
                    $xml_to_html_text = preg_replace("/image_source/","/src='$value'/",$xml_to_html_text);
                    break;
                }
            }
        }
        break;

    case "A":
        $xml_to_html_text = $xml_to_html_text. $x2h_start[$name];
        if(is_array($attribute)) {
            $additional_attributes = "";
            while( list($keys,$value) = each($attribute)) {
                if($keys == 'ARTICLE') {
                    $additional_attributes = $additional_attributes.' href = '.'/display_article.php?articleid='.$attribute['ARTICLE'];
                } else {
                   $additional_attributes  = $additional_attributes.$keys."=".$value." ";
                }
            }
            $xml_to_html_text = preg_replace("/additional_attributes/",$additional_attributes,$xml_to_html_text);
        }
        break;

    case "SECTION":
        $section_depth++;
        $xml_to_html_text = $xml_to_html_text. $x2h_start[$name];
        $depth = $section_depth*8;
        $xml_to_html_text = preg_replace("/section_indent/","$depth",$xml_to_html_text);
        break;
    case "NAME":
        if($section_depth > 0) {
            $xml_to_html_text = $xml_to_html_text. $x2h_start[$name];
        }
        break;
    case "TABLE":
        $attr = '';
        $table_depth++;
        
        if(is_array($attribute)) {
            while( list($keys,$value) = each($attribute) ) {
                switch(strtolower($keys)) {
                    case 'altcolors':
                    case 'c1':
                    case 'c2':
                        $table_alt_colors[$table_depth][strtolower($keys)] = $value;
                        break;
                    default:
                        $attr = $attr.' '.$keys.'='.$value;
                        break;
                }
            }
            $table_alt_colors[$table_depth]['next'] =  'c1';
        }
        $xml_to_html_text = $xml_to_html_text. "<".$name.$attr.">";
        break;
    case "TR" :
        $attr = '';
        if(is_array($attribute)) {
            /*
             * If we have to use alt colors for the table
             * and if the bgcolor of the th is not defined then
             * use the color defined in c1 and c2 of the table.
             */
            if (array_key_exists('altcolors',$table_alt_colors[$table_depth])
            && ! array_key_exists('BGCOLOR',$attribute)){
                
                $attribute['bgcolor'] = $table_alt_colors[$table_depth][$table_alt_colors[$table_depth]['next']];
                $table_alt_colors[$table_depth]['next'] = ($table_alt_colors[$table_depth]['next'] == 'c1') ? 'c2':'c1';
            }
            while( list($keys,$value) = each($attribute) ) {
                $attr = $attr.' '.$keys.'="'.$value.'"';
            }
        }
        $xml_to_html_text = $xml_to_html_text. "<".$name.$attr.">";
    default:
        $attr = '';
        if(is_array($attribute)) {
            while( list($keys,$value) = each($attribute)) {
                $attr = $attr." ".$keys."=".$value;
            }
        }
        $xml_to_html_text = $xml_to_html_text. "<".$name.$attr.">";
    }
}

function article_end_tag ($parser,$name) {
    global $xml_to_html_text,$x2h_end;
    global $table_depth,$section_level;
    $name = strtoupper($name);
    switch ($name) {
    case "ARTICLE" :
    case "CONTENT";
        break;
    case "TITLE":
    case "AUTHOR":
    case "DATE":
    case "NAME":
    case "CODE":
    case "A":
    case "B":
    case "P":
        $xml_to_html_text = $xml_to_html_text. $x2h_end[$name];
        break;
    case "SECTION":
        $xml_to_html_text = $xml_to_html_text. $x2h_end[$name];
        $section_level--;
        break;
    case 'TABLE':
        $xml_to_html_text = $xml_to_html_text.$x2h_end[$name];
        $table_depth--;
    default:
        $xml_to_html_text = $xml_to_html_text. "</$name>";
    }
}

function article_tag_contents ($parser, $data) {
    global $xml_to_html_text;
    if($data !== "") {
        $xml_to_html_text = $xml_to_html_text.$data ;
    }
}

?>