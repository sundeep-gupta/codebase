<?php

######################################################################################
#
# Copyright:     AppLabs Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: $
# Last Modified: $Date: $
# Modified By:   $Author: $
# Source:        $Source: $
#
######################################################################################


class xmlParser {
    
    var $xml_obj = null;
    var $output = array();
    var $attrs;
    var $_content;
    
    //
    // xmlParser() - Function that creates our xml parser object.
    // Input:  
    // Output: 
    function xmlParser() {
        $this->xml_obj = xml_parser_create();
        xml_parser_set_option($this->xml_obj, XML_OPTION_CASE_FOLDING, 0);
        xml_set_object($this->xml_obj,$this);
        xml_set_character_data_handler($this->xml_obj, "dataHandler");
        xml_set_element_handler($this->xml_obj, "startHandler", "endHandler");
    }
    
    //
    // parse() - Function that parses an incoming stream of XML or an XML string.
    // Input:  
    // Output: 
    function parse($file) {
        if (!($fp = fopen($file, "r"))) {
            die("Cannot open XML data file: $file");
            return false;
        }
        
        $xml_string = "";
        while (!feof($fp)) {
            $data = fread($fp, 4096);
            $data = preg_replace("/^\s+/m", "", $data);
            $data = preg_replace("/\s+$/m", "", $data);
            $data = preg_replace("/\r/", "", $data);
            $data = preg_replace("/\n/", "", $data);
            $xml_string .= $data;
        }
        fclose($fp);
        
        if (!xml_parse_into_struct($this->xml_obj, $xml_string, $vals, $index)) {
            die(sprintf("XML error: %s at line %d", xml_error_string(xml_get_error_code($this->xml_obj)), xml_get_current_line_number($this->xml_obj)));
            xml_parser_free($this->xml_obj);
        }
        
        return true;
    }
    
    //
    // startHandler() - Function that defines our XML starting element (tag).
    // Input:  
    // Output: 
    function startHandler($parser, $name, $attribs) {
        $_content = array("node" => $name, "attrs" => $attribs);
        array_push($this->output, $_content);
    }
    
    //
    // dataHandler() - Function that handles the data that exists within the XML tags.
    // Input:  
    // Output: 
    function dataHandler($parser, $data) {
        $cleanData = trim($data);
        if (!empty($cleanData)) {
            $_output_idx = count($this->output) - 1;
            if (isset($this->output[$_output_idx]['content'])) {
                $this->output[$_output_idx]['content'] .= $data;
            }
            else {
                $this->output[$_output_idx]['content'] = $data;
            }
        }
    }
    
    //
    // endHandler() - Function that defines oure XML ending element (tag), and the subsequent attributes and child tags.
    // Input:  
    // Output: 
    function endHandler($parser, $name) {
        if (count($this->output) > 1) {
            $_data = array_pop($this->output);
            $_output_idx = count($this->output) - 1;
            $add = array();
            if (isset($_data['attrs'])) {
                $add['attrs'] = $_data['attrs'];
            }
            if (isset($_data['child'])) {
                $add['child'] = $_data['child'];
            }
            $add['content'] = $_data['content'];
            $this->output[$_output_idx]['child'][$name] = $add;
        }
    }
    
}



?>
